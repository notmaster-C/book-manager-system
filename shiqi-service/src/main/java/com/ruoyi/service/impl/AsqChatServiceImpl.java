package com.ruoyi.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mapper.AsqChatMapper;
import com.ruoyi.domain.AsqChat;
import com.ruoyi.service.IAsqChatService;

/**
 * 用户聊天Service业务层处理
 *
 * @author zjh
 * @date 2023-04-19
 */
@Service
public class AsqChatServiceImpl implements IAsqChatService
{
    @Autowired
    private AsqChatMapper asqChatMapper;

    /**
     * 查询用户聊天
     *
     * @param id 用户聊天主键
     * @return 用户聊天
     */
    @Override
    public AsqChat selectAsqChatById(Long id)
    {
        return asqChatMapper.selectAsqChatById(id);
    }

    /**
     * 查询用户聊天列表
     *
     * @param asqChat 用户聊天
     * @return 用户聊天
     */
    @Override
    public List<AsqChat> selectAsqChatList(AsqChat asqChat)
    {
        return asqChatMapper.selectAsqChatList(asqChat);
    }

    /**
     * 新增用户聊天
     *
     * @param asqChat 用户聊天
     * @return 结果
     */
    @Override
    public int insertAsqChat(AsqChat asqChat)
    {
        return asqChatMapper.insertAsqChat(asqChat);
    }

    /**
     * 修改用户聊天
     *
     * @param asqChat 用户聊天
     * @return 结果
     */
    @Override
    public int updateAsqChat(AsqChat asqChat)
    {
        return asqChatMapper.updateAsqChat(asqChat);
    }

    /**
     * 批量删除用户聊天
     *
     * @param ids 需要删除的用户聊天主键
     * @return 结果
     */
    @Override
    public int deleteAsqChatByIds(Long[] ids)
    {
        return asqChatMapper.deleteAsqChatByIds(ids);
    }

    /**
     * 删除用户聊天信息
     *
     * @param id 用户聊天主键
     * @return 结果
     */
    @Override
    public int deleteAsqChatById(Long id)
    {
        return asqChatMapper.deleteAsqChatById(id);
    }

    /**
     * 查询用户聊天列表
     *
     * @param userId
     */
    @Override
    public List<AsqChat> selectAsqChatListByUserId(Long userId) {
        return asqChatMapper.selectAsqChatListByUserId(userId);
    }

    @Override
    public List<AsqChat> selectChatRecordsByUserId(Long userId, Long fromId) {
        return asqChatMapper.selectChatRecordsByUserId(userId,fromId);
    }
}
