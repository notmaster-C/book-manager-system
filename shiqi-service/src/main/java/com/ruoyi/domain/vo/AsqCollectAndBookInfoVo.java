package com.ruoyi.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import java.util.Date;

/**
 * @Author zjh
 * @Date 2022-10-26 下午 3:20
 **/
public class AsqCollectAndBookInfoVo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long bookId;

    /** 书籍作者姓名 */
    @Excel(name = "书籍作者姓名")
    private String bookWriterName;

    /** 书籍名 */
    @Excel(name = "书籍名")
    private String bookName;

    /** 书籍类型 */
    @Excel(name = "书籍类型")
    private String bookType;

    /** 出版日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "出版日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date bookPubDate;

    /** 上传日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "上传日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date bookUpDate;

    /** 出版社 */
    @Excel(name = "出版社")
    private String bookPress;

    /** 书籍封面 */
    @Excel(name = "书籍封面")
    private String bookCover;

    /** 书籍的pdf */
    private String bookPdfUrl;

    /** 书籍的审核
     *  0 待审核
     *  1 审核成功
     *  2 审核失败
     * */
    private Integer bookAudit;


    /** 用户 */
    private Long userId;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createDate;


    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getBookPdfUrl() {
        return bookPdfUrl;
    }

    public void setBookPdfUrl(String bookPdfUrl) {
        this.bookPdfUrl = bookPdfUrl;
    }

    public Integer getBookAudit() {
        return bookAudit;
    }

    public void setBookAudit(Integer bookAudit) {
        this.bookAudit = bookAudit;
    }

    public void setBookId(Long bookId)
    {
        this.bookId = bookId;
    }

    public Long getBookId()
    {
        return bookId;
    }
    public void setBookWriterName(String bookWriterName)
    {
        this.bookWriterName = bookWriterName;
    }

    public String getBookWriterName()
    {
        return bookWriterName;
    }
    public void setBookName(String bookName)
    {
        this.bookName = bookName;
    }

    public String getBookName()
    {
        return bookName;
    }
    public void setBookType(String bookType)
    {
        this.bookType = bookType;
    }

    public String getBookType()
    {
        return bookType;
    }
    public void setBookPubDate(Date bookPubDate)
    {
        this.bookPubDate = bookPubDate;
    }

    public Date getBookPubDate()
    {
        return bookPubDate;
    }
    public void setBookUpDate(Date bookUpDate)
    {
        this.bookUpDate = bookUpDate;
    }

    public Date getBookUpDate()
    {
        return bookUpDate;
    }
    public void setBookPress(String bookPress)
    {
        this.bookPress = bookPress;
    }

    public String getBookPress()
    {
        return bookPress;
    }
    public void setBookCover(String bookCover)
    {
        this.bookCover = bookCover;
    }

    public String getBookCover()
    {
        return bookCover;
    }
}

