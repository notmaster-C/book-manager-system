package com.ruoyi.service.impl;

import com.ruoyi.domain.echarts.AsqBookRank;
import com.ruoyi.mapper.AsqEchartsMapper;
import com.ruoyi.service.IAsqEchartsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author zjh
 * @Date 2023-04-26 上午 12:20
 **/
@Service
public class AsqEchartsServiceImpl implements IAsqEchartsService {
    @Autowired
    private AsqEchartsMapper echartsMapper;
    @Override
    public List<AsqBookRank> bookRank() {
        return echartsMapper.bookRank();
    }
}
