package com.ruoyi.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.entity.SysUser;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 用户聊天对象 asq_chat
 *
 * @author zjh
 * @date 2023-04-19
 */
public class AsqChat extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 发送人id */
    @Excel(name = "发送人id")
    private Long userId;
    // 发送人昵称
    private String nickName;
    // 发送人头像
    private String avatar;

    /** 接收方id */
    @Excel(name = "接收方id")
    private Long fromId;

    /** 聊天内容 */
    @Excel(name = "聊天内容")
    private String content;

    /** 聊天时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "聊天时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date time;

    private SysUser sysUser;

    public SysUser getSysUser() {
        return sysUser;
    }

    public void setSysUser(SysUser sysUser) {
        this.sysUser = sysUser;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setFromId(Long fromId)
    {
        this.fromId = fromId;
    }

    public Long getFromId()
    {
        return fromId;
    }
    public void setContent(String content)
    {
        this.content = content;
    }

    public String getContent()
    {
        return content;
    }
    public void setTime(Date time)
    {
        this.time = time;
    }

    public Date getTime()
    {
        return time;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("fromId", getFromId())
            .append("content", getContent())
            .append("time", getTime())
            .toString();
    }
}
