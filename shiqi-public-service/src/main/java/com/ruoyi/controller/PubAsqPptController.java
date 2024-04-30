package com.ruoyi.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.domain.AsqPpt;
import com.ruoyi.service.IAsqPptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前台首页幻灯片Controller
 *
 * @author ruoyi
 * @date 2022-07-24
 */
@RestController
@RequestMapping("/public/ppt/ppt")
public class PubAsqPptController extends BaseController {
    @Autowired
    private IAsqPptService asqPptService;
    @Autowired
    private RedisCache redisCache;


    /**
     * 查询广告列表
     * @param asqPpt AsqPpt对象，包含查询条件
     * @return 返回TableDataInfo对象，包含广告列表信息
     */
    @GetMapping("/list")
    public TableDataInfo list(AsqPpt asqPpt) {
        // 开启分页
        startPage();

        // 缓存键名
        String key = "indexCache_ppt";

        // 从缓存中获取广告列表
        Object cacheObject = redisCache.getCacheObject(key);
        if (cacheObject != null) {
            // 若缓存中有数据，则直接返回缓存中的数据
            return getDataTable((List<?>) cacheObject);
        } else {
            // 若缓存中没有数据，则从数据库中查询
            List<AsqPpt> list = asqPptService.selectAsqPptList(asqPpt);
            // 将查询结果存入缓存
            redisCache.setCacheObject(key, list);
            // 返回查询结果
            return getDataTable(list);
        }
    }


}
