package com.ruoyi.service.impl;

import java.util.List;

import com.ruoyi.domain.vo.AsqApplaudAndBookInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mapper.AsqApplaudMapper;
import com.ruoyi.domain.AsqApplaud;
import com.ruoyi.service.IAsqApplaudService;

/**
 * 用户喜欢Service业务层处理
 *
 * @author zjh
 * @date 2022-10-24
 */
@Service
public class AsqApplaudServiceImpl implements IAsqApplaudService
{
    @Autowired
    private AsqApplaudMapper asqApplaudMapper;

    /**
     * 查询用户喜欢
     *
     * @param applaudId 用户喜欢主键
     * @return 用户喜欢
     */
    @Override
    public AsqApplaud selectAsqApplaudByApplaudId(Long applaudId)
    {
        return asqApplaudMapper.selectAsqApplaudByApplaudId(applaudId);
    }

    /**
     * 查询用户喜欢列表
     *
     * @param asqApplaud 用户喜欢
     * @return 用户喜欢
     */
    @Override
    public List<AsqApplaud> selectAsqApplaudList(AsqApplaud asqApplaud)
    {
        return asqApplaudMapper.selectAsqApplaudList(asqApplaud);
    }

    /**
     * 新增用户喜欢
     *
     * @param asqApplaud 用户喜欢
     * @return 结果
     */
    @Override
    public int insertAsqApplaud(AsqApplaud asqApplaud)
    {
        return asqApplaudMapper.insertAsqApplaud(asqApplaud);
    }

    /**
     * 修改用户喜欢
     *
     * @param asqApplaud 用户喜欢
     * @return 结果
     */
    @Override
    public int updateAsqApplaud(AsqApplaud asqApplaud)
    {
        return asqApplaudMapper.updateAsqApplaud(asqApplaud);
    }

    /**
     * 批量删除用户喜欢
     *
     * @param applaudIds 需要删除的用户喜欢主键
     * @return 结果
     */
    @Override
    public int deleteAsqApplaudByApplaudIds(Long[] applaudIds)
    {
        return asqApplaudMapper.deleteAsqApplaudByApplaudIds(applaudIds);
    }

    /**
     * 删除用户喜欢信息
     *
     * @param applaudId 用户喜欢主键
     * @return 结果
     */
    @Override
    public int deleteAsqApplaudByApplaudId(Long applaudId)
    {
        return asqApplaudMapper.deleteAsqApplaudByApplaudId(applaudId);
    }

    @Override
    public List<AsqApplaudAndBookInfoVo> selectAsqApplaudAndBookInfoList(AsqApplaudAndBookInfoVo infoVo) {
        return asqApplaudMapper.selectAsqApplaudAndBookInfoList(infoVo);
    }


}
