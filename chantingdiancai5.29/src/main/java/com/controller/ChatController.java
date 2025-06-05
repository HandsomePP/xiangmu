package com.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import com.utils.ValidatorUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.annotation.IgnoreAuth;

import com.entity.ChatEntity;
import com.entity.view.ChatView;

import com.service.ChatService;
import com.service.TokenService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;
import com.utils.CommonUtil;


/**
 * 客服聊天表
 * 后端接口
 * @author 
 * @email 
 * @date 2021-01-25 11:41:44
 */
@RestController
@RequestMapping("/chat")
public class ChatController {
    @Autowired
    private ChatService chatService;
    


    /**
     * 后端列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ChatEntity chat, HttpServletRequest request){
    	Object roleObj = request.getSession().getAttribute("role");
    	if(roleObj != null && !roleObj.toString().equals("管理员")) {
    		Object userIdObj = request.getSession().getAttribute("userId");
    		if(userIdObj != null) {
    			chat.setUserid((Integer)userIdObj);
    		}
    	}

        EntityWrapper<ChatEntity> ew = new EntityWrapper<ChatEntity>();
		PageUtils page = chatService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, chat), params), params));
        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,ChatEntity chat, HttpServletRequest request){
    	Object roleObj = request.getSession().getAttribute("role");
    	if(roleObj != null && !roleObj.toString().equals("管理员")) {
    		Object userIdObj = request.getSession().getAttribute("userId");
    		if(userIdObj != null) {
    			chat.setUserid((Integer)userIdObj);
    		}
    	}

        EntityWrapper<ChatEntity> ew = new EntityWrapper<ChatEntity>();
		PageUtils page = chatService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, chat), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ChatEntity chat){
       	EntityWrapper<ChatEntity> ew = new EntityWrapper<ChatEntity>();
      	ew.allEq(MPUtil.allEQMapPre( chat, "chat")); 
        return R.ok().put("data", chatService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ChatEntity chat){
        EntityWrapper< ChatEntity> ew = new EntityWrapper< ChatEntity>();
 		ew.allEq(MPUtil.allEQMapPre( chat, "chat")); 
		ChatView chatView =  chatService.selectView(ew);
		return R.ok("查询客服聊天表成功").put("data", chatView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ChatEntity chat = chatService.selectById(id);
        return R.ok().put("data", chat);
    }

    /**
     * 前端详情
     */
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ChatEntity chat = chatService.selectById(id);
        return R.ok().put("data", chat);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ChatEntity chat, HttpServletRequest request){
    	chat.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(chat);
    	
    	// 检查session中的userId是否存在
    	Object userIdObj = request.getSession().getAttribute("userId");
    	if(userIdObj == null) {
    		return R.error("用户未登录或登录已过期");
    	}
    	
    	Integer userId = (Integer) userIdObj;
    	
    	if(StringUtils.isNotBlank(chat.getAsk())) {
			chatService.updateForSet("isreply=0", new EntityWrapper<ChatEntity>().eq("userid", userId));
    		chat.setUserid(userId);
    		chat.setIsreply(1);
    	}
    	if(StringUtils.isNotBlank(chat.getReply())) {
    		chatService.updateForSet("isreply=0", new EntityWrapper<ChatEntity>().eq("userid", chat.getUserid()));
    		// 修复类型转换错误：Integer转Long
    		chat.setAdminid(userId.longValue());
    	}

        chatService.insert(chat);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody ChatEntity chat, HttpServletRequest request){
    	chat.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(chat);
    	
    	// 检查session中的userId是否存在
    	Object userIdObj = request.getSession().getAttribute("userId");
    	if(userIdObj == null) {
    		return R.error("用户未登录或登录已过期");
    	}
    	
    	Integer userId = (Integer) userIdObj;
    	chat.setUserid(userId);
    	
    	if(StringUtils.isNotBlank(chat.getAsk())) {
			chatService.updateForSet("isreply=0", new EntityWrapper<ChatEntity>().eq("userid", userId));
    		chat.setUserid(userId);
    		chat.setIsreply(1);
    	}
    	if(StringUtils.isNotBlank(chat.getReply())) {
    		chatService.updateForSet("isreply=0", new EntityWrapper<ChatEntity>().eq("userid", chat.getUserid()));
    		// 修复类型转换错误：Integer转Long
    		chat.setAdminid(userId.longValue());
    	}

        chatService.insert(chat);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody ChatEntity chat, HttpServletRequest request){
        //ValidatorUtils.validateEntity(chat);
        chatService.updateById(chat);//全部更新
        return R.ok();
    }
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        chatService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
    /**
     * 提醒接口
     */
	@RequestMapping("/remind/{columnName}/{type}")
	public R remindCount(@PathVariable("columnName") String columnName, HttpServletRequest request, 
						 @PathVariable("type") String type,@RequestParam Map<String, Object> map) {
		map.put("column", columnName);
		map.put("type", type);
		
		if(type.equals("2")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			Date remindStartDate = null;
			Date remindEndDate = null;
			if(map.get("remindstart")!=null) {
				Integer remindStart = Integer.parseInt(map.get("remindstart").toString());
				c.setTime(new Date()); 
				c.add(Calendar.DAY_OF_MONTH,remindStart);
				remindStartDate = c.getTime();
				map.put("remindstart", sdf.format(remindStartDate));
			}
			if(map.get("remindend")!=null) {
				Integer remindEnd = Integer.parseInt(map.get("remindend").toString());
				c.setTime(new Date());
				c.add(Calendar.DAY_OF_MONTH,remindEnd);
				remindEndDate = c.getTime();
				map.put("remindend", sdf.format(remindEndDate));
			}
		}
		
		Wrapper<ChatEntity> wrapper = new EntityWrapper<ChatEntity>();
		if(map.get("remindstart")!=null) {
			wrapper.ge(columnName, map.get("remindstart"));
		}
		if(map.get("remindend")!=null) {
			wrapper.le(columnName, map.get("remindend"));
		}


		int count = chatService.selectCount(wrapper);
		return R.ok().put("count", count);
	}
	
    /**
     * 获取所有对话列表（按用户分组）
     */
    @RequestMapping("/conversations")
    public R conversations(HttpServletRequest request){
        EntityWrapper<ChatEntity> ew = new EntityWrapper<ChatEntity>();
        ew.orderBy("addtime", false); // 按时间倒序
        
        List<ChatEntity> allChats = chatService.selectList(ew);
        
        // 按用户ID分组对话
        Map<Integer, List<Map<String, Object>>> conversationMap = new HashMap<>();
        
        for (ChatEntity chat : allChats) {
            Integer userId = chat.getUserid();
            if (!conversationMap.containsKey(userId)) {
                conversationMap.put(userId, new ArrayList<>());
            }
            
            List<Map<String, Object>> userMessages = conversationMap.get(userId);
            
            // 添加用户消息
            if (StringUtils.isNotBlank(chat.getAsk())) {
                Map<String, Object> askMessage = new HashMap<>();
                askMessage.put("id", "ask_" + chat.getId());
                askMessage.put("type", "user");
                askMessage.put("content", chat.getAsk());
                askMessage.put("time", chat.getAddtime());
                askMessage.put("chatId", chat.getId());
                askMessage.put("userId", chat.getUserid());
                userMessages.add(askMessage);
            }
            
            // 添加管理员回复
            if (StringUtils.isNotBlank(chat.getReply())) {
                Map<String, Object> replyMessage = new HashMap<>();
                replyMessage.put("id", "reply_" + chat.getId());
                replyMessage.put("type", "admin");
                replyMessage.put("content", chat.getReply());
                replyMessage.put("time", chat.getAddtime());
                replyMessage.put("chatId", chat.getId());
                replyMessage.put("userId", chat.getUserid());
                userMessages.add(replyMessage);
            }
        }
        
        // 转换为列表格式，包含用户信息和最新消息状态
        List<Map<String, Object>> conversations = new ArrayList<>();
        for (Map.Entry<Integer, List<Map<String, Object>>> entry : conversationMap.entrySet()) {
            Integer userId = entry.getKey();
            List<Map<String, Object>> messages = entry.getValue();
            
            // 按时间排序消息
            messages.sort((a, b) -> {
                Date timeA = (Date) a.get("time");
                Date timeB = (Date) b.get("time");
                return timeA.compareTo(timeB);
            });
            
            // 获取最新消息和未回复状态
            Map<String, Object> lastMessage = messages.get(messages.size() - 1);
            boolean isUnread = "user".equals(lastMessage.get("type"));
            
            Map<String, Object> conversation = new HashMap<>();
            conversation.put("userId", userId);
            conversation.put("messages", messages);
            conversation.put("lastMessage", lastMessage);
            conversation.put("isUnread", isUnread);
            conversation.put("messageCount", messages.size());
            
            conversations.add(conversation);
        }
        
        // 按最新消息时间排序
        conversations.sort((a, b) -> {
            Map<String, Object> lastA = (Map<String, Object>) a.get("lastMessage");
            Map<String, Object> lastB = (Map<String, Object>) b.get("lastMessage");
            Date timeA = (Date) lastA.get("time");
            Date timeB = (Date) lastB.get("time");
            return timeB.compareTo(timeA); // 最新的在前面
        });
        
        return R.ok().put("data", conversations);
    }

}
