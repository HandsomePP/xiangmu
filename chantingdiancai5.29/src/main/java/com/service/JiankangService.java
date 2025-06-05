package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.JiankangEntity;
import java.util.Map;

/**
 * 健康记录 服务类
 * @since 2025-05-21
 */
public interface JiankangService extends IService<JiankangEntity> {

     PageUtils queryPage(Map<String, Object> params);

} 