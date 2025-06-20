package com.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import com.utils.PageUtils;
import com.utils.Query;

import com.dao.JiankangDao;
import com.entity.JiankangEntity;
import com.service.JiankangService;
import com.entity.view.JiankangView;

/**
 * 健康记录 服务实现类
 * @since 2025-05-21
 */
@Service("jiankangService")
@Transactional
public class JiankangServiceImpl extends ServiceImpl<JiankangDao, JiankangEntity> implements JiankangService {

    @Override
    public PageUtils queryPage(Map<String,Object> params) {
        if(params != null && (params.get("limit") == null || params.get("page") == null)){
            params.put("page","1");
            params.put("limit","10");
        }
        Page<JiankangView> page = new Query<JiankangView>(params).getPage();
        page.setRecords(baseMapper.selectListView(page,params));
        return new PageUtils(page);
    }

} 