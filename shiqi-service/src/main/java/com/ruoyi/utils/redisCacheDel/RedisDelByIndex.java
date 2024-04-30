package com.ruoyi.utils.redisCacheDel;

import com.ruoyi.common.core.redis.RedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Collection;

/**
 * @Author zjh
 * @Date 2023-04-28 下午 1:02
 **/
@Component
public class RedisDelByIndex {
    @Autowired
    private RedisCache redisCache;


    public void delete(){
        Collection<String> keys = redisCache.keys("indexCache_*");
        for (String key : keys) {
            redisCache.deleteObject(key);
        }
    }
}
