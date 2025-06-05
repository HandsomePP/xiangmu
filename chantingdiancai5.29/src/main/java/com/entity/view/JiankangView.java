package com.entity.view;

import com.entity.JiankangEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;

/**
 * 健康记录
 * 后端返回视图实体辅助类
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @email
 * @date 2025-05-21
 */
@TableName("jiankang")
public class JiankangView extends JiankangEntity implements Serializable {
    private static final long serialVersionUID = 1L;

	public JiankangView() {

	}
	
	// 可以添加关联表的信息，例如用户名
	private String yonghuName;
	
	public String getYonghuName() {
		return yonghuName;
	}
	
	public void setYonghuName(String yonghuName) {
		this.yonghuName = yonghuName;
	}

    public JiankangView(JiankangEntity jiankangEntity) {
		try {
			BeanUtils.copyProperties(this, jiankangEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
} 