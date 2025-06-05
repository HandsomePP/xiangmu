package com.dao;

import com.entity.JiankangEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.JiankangView;

/**
 * 健康记录 Dao 接口
 *
 * @since 2025-05-21
 */
public interface JiankangDao extends BaseMapper<JiankangEntity> {

   List<JiankangView> selectListView(Pagination page, @Param("params") Map<String, Object> params);

} 