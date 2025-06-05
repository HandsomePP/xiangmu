package com.controller;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

import com.entity.*;
import com.entity.view.JiankangView;
import com.service.*;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;

import com.utils.PageUtils;
import com.utils.R;

/**
 * 健康记录
 * 后端接口
 * @author
 * @email
 * @date 2025-05-21
*/
@RestController
@Controller
@RequestMapping("/jiankang")
public class JiankangController {
    private static final Logger logger = LoggerFactory.getLogger(JiankangController.class);

    @Autowired
    private JiankangService jiankangService;
    
    @Autowired
    private YonghuService yonghuService;

    /**
    * 后端列表
    */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params){
        logger.debug("Controller:"+this.getClass().getName()+",page方法");
        PageUtils page = jiankangService.queryPage(params);
        return R.ok().put("data", page);
    }
    
    /**
    * 后端详情
    */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        logger.debug("Controller:"+this.getClass().getName()+",info方法");
        JiankangEntity jiankang = jiankangService.selectById(id);
        if(jiankang!=null){
            JiankangView jiankangView = new JiankangView();
            BeanUtils.copyProperties(jiankang, jiankangView);
            
            YonghuEntity yonghu = yonghuService.selectById(jiankang.getYonghuid());
            if(yonghu != null) {
                jiankangView.setYonghuName(yonghu.getName());
            }
            
            return R.ok().put("data", jiankangView);
        }else {
            return R.error(511,"查不到数据");
        }
    }

    /**
    * 后端保存
    */
    @RequestMapping("/save")
    public R save(@RequestBody JiankangEntity jiankang, HttpServletRequest request){
        logger.debug("Controller:"+this.getClass().getName()+",save");
        
        // 设置创建时间
        if(jiankang.getCreateTime() == null) {
            jiankang.setCreateTime(new Date());
        }
        
        jiankangService.insert(jiankang);
        return R.ok();
    }

    /**
    * 修改
    */
    @RequestMapping("/update")
    public R update(@RequestBody JiankangEntity jiankang, HttpServletRequest request){
        logger.debug("Controller:"+this.getClass().getName()+",update");
        jiankangService.updateById(jiankang);//根据id更新
        return R.ok();
    }

    /**
    * 删除
    */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        logger.debug("Controller:"+this.getClass().getName()+",delete");
        jiankangService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
} 