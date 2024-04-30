package com.ruoyi.service;

import java.util.List;
import com.ruoyi.domain.AsqApplaud;
import com.ruoyi.domain.vo.AsqApplaudAndBookInfoVo;

/**
 * 用户喜欢Service接口
 *
 * @author zjh
 * @date 2022-10-24
 */
public interface IAsqApplaudService
{
    /**
     * 查询用户喜欢
     *
     * @param applaudId 用户喜欢主键
     * @return 用户喜欢
     */
    public AsqApplaud selectAsqApplaudByApplaudId(Long applaudId);

    /**
     * 查询用户喜欢列表
     *
     * @param asqApplaud 用户喜欢
     * @return 用户喜欢集合
     */
    public List<AsqApplaud> selectAsqApplaudList(AsqApplaud asqApplaud);

    /**
     * 新增用户喜欢
     *
     * @param asqApplaud 用户喜欢
     * @return 结果
     */
    public int insertAsqApplaud(AsqApplaud asqApplaud);

    /**
     * 修改用户喜欢
     *
     * @param asqApplaud 用户喜欢
     * @return 结果
     */
    public int updateAsqApplaud(AsqApplaud asqApplaud);

    /**
     * 批量删除用户喜欢
     *
     * @param applaudIds 需要删除的用户喜欢主键集合
     * @return 结果
     */
    public int deleteAsqApplaudByApplaudIds(Long[] applaudIds);

    /**
     * 删除用户喜欢信息
     *
     * @param applaudId 用户喜欢主键
     * @return 结果
     */
    public int deleteAsqApplaudByApplaudId(Long applaudId);

    List<AsqApplaudAndBookInfoVo> selectAsqApplaudAndBookInfoList(AsqApplaudAndBookInfoVo infoVo);
}
