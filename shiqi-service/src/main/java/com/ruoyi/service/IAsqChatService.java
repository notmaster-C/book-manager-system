package com.ruoyi.service;

import java.util.List;
import com.ruoyi.domain.AsqChat;

/**
 * 用户聊天Service接口
 *
 * @author zjh
 * @date 2023-04-19
 */
public interface IAsqChatService
{
    /**
     * 查询用户聊天
     *
     * @param id 用户聊天主键
     * @return 用户聊天
     */
    public AsqChat selectAsqChatById(Long id);

    /**
     * 查询用户聊天列表
     *
     * @param asqChat 用户聊天
     * @return 用户聊天集合
     */
    public List<AsqChat> selectAsqChatList(AsqChat asqChat);

    /**
     * 新增用户聊天
     *
     * @param asqChat 用户聊天
     * @return 结果
     */
    public int insertAsqChat(AsqChat asqChat);

    /**
     * 修改用户聊天
     *
     * @param asqChat 用户聊天
     * @return 结果
     */
    public int updateAsqChat(AsqChat asqChat);

    /**
     * 批量删除用户聊天
     *
     * @param ids 需要删除的用户聊天主键集合
     * @return 结果
     */
    public int deleteAsqChatByIds(Long[] ids);

    /**
     * 删除用户聊天信息
     *
     * @param id 用户聊天主键
     * @return 结果
     */
    public int deleteAsqChatById(Long id);

    /**
     * 查询用户聊天列表
     * */
    List<AsqChat> selectAsqChatListByUserId(Long userId);

    List<AsqChat> selectChatRecordsByUserId(Long userId, Long fromId);
}
