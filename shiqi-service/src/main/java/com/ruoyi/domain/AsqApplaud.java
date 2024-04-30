package com.ruoyi.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 用户喜欢对象 asq_applaud
 *
 * @author zjh
 * @date 2022-10-24
 */
public class AsqApplaud extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long applaudId;

    /** 用户 */
    @Excel(name = "用户")
    private Long userId;

    /** 书籍 */
    @Excel(name = "书籍")
    private Long bookId;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date creadData;

    public void setApplaudId(Long applaudId)
    {
        this.applaudId = applaudId;
    }

    public Long getApplaudId()
    {
        return applaudId;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setBookId(Long bookId)
    {
        this.bookId = bookId;
    }

    public Long getBookId()
    {
        return bookId;
    }
    public void setCreadData(Date creadData)
    {
        this.creadData = creadData;
    }

    public Date getCreadData()
    {
        return creadData;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("applaudId", getApplaudId())
            .append("userId", getUserId())
            .append("bookId", getBookId())
            .append("creadData", getCreadData())
            .toString();
    }
}
