<template>
  <div class="chat-container">
    <!-- 左侧用户列表 -->
    <div class="chat-sidebar">
      <div class="sidebar-header">
        <h3><i class="el-icon-chat-dot-round"></i> 客服对话</h3>
        <div class="stats">
          <span class="stat-item">总对话: {{ totalConversations }}</span>
          <!-- <span class="stat-item unread">待回复: {{ unreadCount }}</span> -->
        </div>
      </div>
      
      <div class="user-list" v-loading="dataListLoading">
        <div 
          v-for="conversation in conversations" 
          :key="conversation.userId"
          :class="['user-item', { 'active': selectedUserId === conversation.userId, 'unread': conversation.isUnread }]"
          @click="selectUser(conversation)">
          
          <div class="user-info">
            <div class="user-avatar">
              <i class="el-icon-user"></i>
            </div>
            <div class="user-details">
              <div class="user-name">用户 {{ conversation.userId }}</div>
              <div class="last-message">{{ getLastMessagePreview(conversation.lastMessage) }}</div>
            </div>
          </div>
          
          <div class="message-meta">
            <div class="message-time">{{ formatTime(conversation.lastMessage.time) }}</div>
            <div v-if="conversation.isUnread" class="unread-badge">{{ conversation.messageCount }}</div>
          </div>
        </div>
        
        <div v-if="conversations.length === 0" class="empty-list">
          <i class="el-icon-chat-line-round"></i>
          <p>暂无对话记录</p>
        </div>
      </div>
    </div>
    
    <!-- 右侧对话区域 -->
    <div class="chat-main">
      <div v-if="!selectedConversation" class="chat-placeholder">
        <i class="el-icon-chat-dot-square"></i>
        <p>选择一个用户开始查看对话</p>
      </div>
      
      <div v-else class="chat-content">
        <!-- 对话头部 -->
        <div class="chat-header">
          <div class="chat-user-info">
            <i class="el-icon-user"></i>
            <span>用户 {{ selectedConversation.userId }}</span>
            <el-tag v-if="selectedConversation.isUnread" type="warning" size="mini">待回复</el-tag>
          </div>
          <div class="chat-actions">
            <span class="message-count">共 {{ selectedConversation.messageCount }} 条消息</span>
          </div>
        </div>
        
        <!-- 消息列表 -->
        <div class="messages-container" ref="messagesContainer">
          <div 
            v-for="message in selectedConversation.messages" 
            :key="message.id"
            :class="['message-item', `message-${message.type}`]">
            
            <div class="message-content">
              <div class="message-header">
                <span class="sender-name">
                  <i :class="message.type === 'user' ? 'el-icon-user' : 'el-icon-service'"></i>
                  {{ message.type === 'user' ? '用户' : '客服' }}
                </span>
                <span class="message-time">{{ formatDetailTime(message.time) }}</span>
              </div>
              <div class="message-bubble" :class="`bubble-${message.type}`">
                {{ message.content }}
              </div>
            </div>
          </div>
        </div>
        
        <!-- 回复输入区 -->
        <div class="reply-area">
          <el-form ref="replyForm" :model="replyForm" :rules="replyRules">
            <el-form-item prop="reply">
              <el-input
                type="textarea"
                v-model="replyForm.reply"
                placeholder="输入回复内容..."
                :rows="3"
                :maxlength="500"
                show-word-limit
                :disabled="sending"
                @keydown.ctrl.enter="sendReply">
              </el-input>
            </el-form-item>
            <el-form-item class="reply-actions">
              <el-button 
                type="primary" 
                @click="sendReply" 
                :loading="sending"
                size="medium">
                <i class="el-icon-s-promotion"></i>
                发送回复 (Ctrl+Enter)
              </el-button>
              <el-button @click="replyForm.reply = ''" size="medium">
                <i class="el-icon-refresh-left"></i>
                清空
              </el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      conversations: [],
      selectedConversation: null,
      selectedUserId: null,
      dataListLoading: false,
      sending: false,
      replyForm: {
        reply: ''
      },
      replyRules: {
        reply: [
          { required: true, message: "回复内容不能为空", trigger: "blur" },
          { min: 1, max: 500, message: "回复内容长度在 1 到 500 个字符", trigger: "blur" }
        ]
      },
      pollingInterval: null
    };
  },
  computed: {
    unreadCount() {
      return this.conversations.filter(conv => conv.isUnread).length;
    },
    totalConversations() {
      return this.conversations.length;
    }
  },
  created() {
    this.loadConversations();
    // 每3秒自动刷新数据
    this.pollingInterval = setInterval(() => {
      this.loadConversations();
    }, 3000);
    
    // 监听页面可见性变化
    document.addEventListener('visibilitychange', this.handleVisibilityChange);
  },
  destroyed() {
    if (this.pollingInterval) {
      clearInterval(this.pollingInterval);
    }
    document.removeEventListener('visibilitychange', this.handleVisibilityChange);
  },
  methods: {
    // 加载所有对话
    loadConversations() {
      this.dataListLoading = true;
      this.$http({
        url: this.$base.url + 'chat/conversations',
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.conversations = data.data;
          
          // 如果有选中的用户，更新其对话数据
          if (this.selectedUserId) {
            const updatedConversation = this.conversations.find(conv => conv.userId === this.selectedUserId);
            if (updatedConversation) {
              this.selectedConversation = updatedConversation;
              this.$nextTick(() => {
                this.scrollToBottom();
              });
            }
          }
        } else {
          this.conversations = [];
        }
        this.dataListLoading = false;
      }).catch(error => {
        console.error('获取对话列表失败:', error);
        this.dataListLoading = false;
      });
    },
    
    // 选择用户
    selectUser(conversation) {
      this.selectedConversation = conversation;
      this.selectedUserId = conversation.userId;
      this.$nextTick(() => {
        this.scrollToBottom();
      });
    },
    
    // 发送回复
    sendReply() {
      this.$refs["replyForm"].validate(valid => {
        if (valid) {
          this.sending = true;
          
          this.$http({
            url: this.$base.url + 'chat/save',
            method: "post",
            data: {
              reply: this.replyForm.reply,
              userid: this.selectedUserId
            }
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "回复发送成功",
                type: "success",
                duration: 1500
              });
              
              // 清空输入框
              this.replyForm.reply = "";
              
              // 重新加载对话
              this.loadConversations();
              
            } else {
              this.$message.error(data.msg || '发送失败');
            }
          }).catch(error => {
            this.$message.error('网络错误，发送失败');
            console.error('发送回复失败:', error);
          }).finally(() => {
            this.sending = false;
          });
        }
      });
    },
    
    // 获取最后消息预览
    getLastMessagePreview(lastMessage) {
      const content = lastMessage.content || '';
      return content.length > 30 ? content.substring(0, 30) + '...' : content;
    },
    
    // 格式化时间（简短）
    formatTime(timeStr) {
      const date = new Date(timeStr);
      const now = new Date();
      const diffMs = now - date;
      const diffMins = Math.floor(diffMs / (1000 * 60));
      const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
      const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
      
      if (diffMins < 1) {
        return '刚刚';
      } else if (diffMins < 60) {
        return `${diffMins}分钟前`;
      } else if (diffHours < 24) {
        return `${diffHours}小时前`;
      } else if (diffDays < 7) {
        return `${diffDays}天前`;
      } else {
        return date.toLocaleDateString('zh-CN', {
          month: '2-digit',
          day: '2-digit'
        });
      }
    },
    
    // 格式化详细时间
    formatDetailTime(timeStr) {
      const date = new Date(timeStr);
      const now = new Date();
      const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
      const messageDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
      
      const timeFormat = date.toLocaleTimeString('zh-CN', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      });
      
      if (messageDate.getTime() === today.getTime()) {
        return `今天 ${timeFormat}`;
      } else {
        const yesterday = new Date(today.getTime() - 24 * 60 * 60 * 1000);
        if (messageDate.getTime() === yesterday.getTime()) {
          return `昨天 ${timeFormat}`;
        } else {
          return `${date.getMonth() + 1}/${date.getDate()} ${timeFormat}`;
        }
      }
    },
    
    // 滚动到底部
    scrollToBottom() {
      const container = this.$refs.messagesContainer;
      if (container) {
        container.scrollTop = container.scrollHeight;
      }
    },
    
    // 处理页面可见性变化
    handleVisibilityChange() {
      if (document.visibilityState === 'visible') {
        this.loadConversations();
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.chat-container {
  display: flex;
  height: calc(100vh - 120px); // 固定高度，减去顶部导航等空间
  max-height: 800px;
  background: #f5f7fa;
}

.chat-sidebar {
  width: 320px;
  background: white;
  border-right: 1px solid #e4e7ed;
  display: flex;
  flex-direction: column;
  height: 100%; // 确保高度填满容器
}

.sidebar-header {
  padding: 20px;
  border-bottom: 1px solid #f0f2f5;
  flex-shrink: 0; // 防止被压缩
  
  h3 {
    margin: 0 0 10px 0;
    color: #303133;
    font-size: 18px;
    
    i {
      color: #409eff;
      margin-right: 8px;
    }
  }
  
  .stats {
    display: flex;
    gap: 15px;
    
    .stat-item {
      font-size: 12px;
      color: #909399;
      
      &.unread {
        color: #e6a23c;
        font-weight: bold;
      }
    }
  }
}

.user-list {
  flex: 1;
  overflow-y: auto;
  min-height: 0; // 重要：允许flex子项收缩
}

.user-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 15px 20px;
  border-bottom: 1px solid #f0f2f5;
  cursor: pointer;
  transition: background-color 0.3s;
  
  &:hover {
    background-color: #f8f9fa;
  }
  
  &.active {
    background-color: #ecf5ff;
    border-left: 3px solid #409eff;
  }
  
  &.unread {
    background-color: #fff7e6;
    
    &:hover {
      background-color: #fff3d9;
    }
  }
}

.user-info {
  display: flex;
  align-items: center;
  flex: 1;
  min-width: 0;
  
  .user-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: linear-gradient(135deg, #409eff 0%, #36a3f7 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    margin-right: 12px;
    flex-shrink: 0;
  }
  
  .user-details {
    min-width: 0;
    flex: 1;
    
    .user-name {
      font-size: 14px;
      font-weight: 500;
      color: #303133;
      margin-bottom: 4px;
    }
    
    .last-message {
      font-size: 12px;
      color: #909399;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
  }
}

.message-meta {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 4px;
  
  .message-time {
    font-size: 11px;
    color: #c0c4cc;
  }
  
  .unread-badge {
    background: #f56c6c;
    color: white;
    border-radius: 10px;
    padding: 2px 6px;
    font-size: 10px;
    min-width: 16px;
    text-align: center;
  }
}

.empty-list {
  text-align: center;
  padding: 60px 20px;
  color: #909399;
  
  i {
    font-size: 48px;
    color: #c0c4cc;
    margin-bottom: 15px;
  }
  
  p {
    margin: 0;
    font-size: 14px;
  }
}

.chat-main {
  flex: 1;
  background: white;
  display: flex;
  flex-direction: column;
  height: 100%; // 确保高度填满容器
  min-width: 0; // 重要：允许flex子项收缩
}

.chat-placeholder {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #909399;
  
  i {
    font-size: 64px;
    color: #d3d4d6;
    margin-bottom: 20px;
  }
  
  p {
    font-size: 16px;
    margin: 0;
  }
}

.chat-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  height: 100%; // 确保高度填满容器
  min-height: 0; // 重要：允许flex子项收缩
}

.chat-header {
  padding: 15px 20px;
  border-bottom: 1px solid #e4e7ed;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #fafafa;
  flex-shrink: 0; // 防止被压缩
  
  .chat-user-info {
    display: flex;
    align-items: center;
    gap: 8px;
    
    i {
      color: #409eff;
    }
    
    span {
      font-weight: 500;
      color: #303133;
    }
  }
  
  .message-count {
    font-size: 12px;
    color: #909399;
  }
}

.messages-container {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  min-height: 0; // 重要：允许flex子项收缩
  max-height: none; // 移除最大高度限制
}

.message-item {
  margin-bottom: 20px;
  display: flex;
  width: 100%;
  
  &.message-user {
    justify-content: flex-start; // 用户消息左对齐
    
    .message-content {
      max-width: 70%;
      display: flex;
      flex-direction: column;
      align-items: flex-start;
    }
    
    .message-header {
      margin-bottom: 5px;
      font-size: 12px;
      color: #909399;
      
      .sender-name {
        color: #409eff;
        font-weight: 500;
        
        i {
          margin-right: 4px;
        }
      }
      
      .message-time {
        margin-left: 10px;
      }
    }
    
    .bubble-user {
      background: #f0f2f5;
      color: #303133;
      border-radius: 18px 18px 18px 4px;
      padding: 12px 16px;
      font-size: 14px;
      line-height: 1.4;
      word-wrap: break-word;
      box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    }
  }
  
  &.message-admin {
    justify-content: flex-end; // 管理员消息右对齐
    
    .message-content {
      max-width: 70%;
      display: flex;
      flex-direction: column;
      align-items: flex-end;
    }
    
    .message-header {
      margin-bottom: 5px;
      font-size: 12px;
      color: #909399;
      text-align: right;
      
      .sender-name {
        color: #67c23a;
        font-weight: 500;
        
        i {
          margin-right: 4px;
        }
      }
      
      .message-time {
        margin-left: 10px;
      }
    }
    
    .bubble-admin {
      background: linear-gradient(135deg, #67c23a 0%, #85ce61 100%);
      color: white;
      border-radius: 18px 18px 4px 18px;
      padding: 12px 16px;
      font-size: 14px;
      line-height: 1.4;
      word-wrap: break-word;
      box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    }
  }
}

.message-content {
  // 移除之前的样式，新样式在各自的message-user和message-admin中定义
}

.reply-area {
  border-top: 1px solid #e4e7ed;
  padding: 20px;
  background: #fafafa;
  flex-shrink: 0; // 防止被压缩，固定在底部
  
  .reply-actions {
    margin-bottom: 0;
    text-align: right;
    
    .el-button {
      margin-left: 10px;
    }
  }
}

// 自定义滚动条
.user-list::-webkit-scrollbar,
.messages-container::-webkit-scrollbar {
  width: 6px;
}

.user-list::-webkit-scrollbar-track,
.messages-container::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 3px;
}

.user-list::-webkit-scrollbar-thumb,
.messages-container::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 3px;
}

.user-list::-webkit-scrollbar-thumb:hover,
.messages-container::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}
</style>

