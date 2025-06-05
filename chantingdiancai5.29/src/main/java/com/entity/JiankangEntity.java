package com.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 健康记录
 *
 * @email
 * @date 2025-05-21
 */
@TableName("jiankang")
public class JiankangEntity<T> implements Serializable {
    private static final long serialVersionUID = 1L;


    public JiankangEntity() {

    }

    public JiankangEntity(T t) {
    try {
    BeanUtils.copyProperties(this, t);
    } catch (IllegalAccessException | InvocationTargetException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
    }
    }


    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    @TableField(value = "id")
    private Integer id;


    /**
     * 用户id主键
     */
    @TableField(value = "yonghuid")
    private Integer yonghuid;


    /**
     * 内容
     */
    @TableField(value = "content")
    private String content;


    /**
     * 创建时间
     */
    @TableField(value = "createTime")
    private Date createTime;


    /**
     * 类型
     */
    @TableField(value = "type")
    private Integer type;


    /**
	 * 设置：主键
	 */
    public Integer getId() {
        return id;
    }


    /**
	 * 获取：主键
	 */
    public void setId(Integer id) {
        this.id = id;
    }
    /**
	 * 设置：用户id主键
	 */
    public Integer getYonghuid() {
        return yonghuid;
    }


    /**
	 * 获取：用户id主键
	 */
    public void setYonghuid(Integer yonghuid) {
        this.yonghuid = yonghuid;
    }
    /**
	 * 设置：内容
	 */
    public String getContent() {
        return content;
    }


    /**
	 * 获取：内容
	 */
    public void setContent(String content) {
        this.content = content;
    }
    /**
	 * 设置：创建时间
	 */
    public Date getCreateTime() {
        return createTime;
    }


    /**
	 * 获取：创建时间
	 */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    /**
	 * 设置：类型
	 */
    public Integer getType() {
        return type;
    }


    /**
	 * 获取：类型
	 */
    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
    return "Jiankang{" +
            "id=" + id +
            ", yonghuid=" + yonghuid +
            ", content=" + content +
            ", createTime=" + createTime +
            ", type=" + type +
    "}";
    }
} 