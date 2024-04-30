package com.ruoyi.domain.echarts;

import com.ruoyi.common.annotation.Excel;

/**
 * @Author zjh
 * @Date 2023-04-26 上午 12:15
 **/
public class AsqBookRank {

    private String bookName;

    /** $column.columnComment */
    private Long rankParmId;


    /** 书籍id */
    @Excel(name = "书籍id")
    private Long bookId;

    /** 阅读数 */
    @Excel(name = "阅读数")
    private Long readNum;

    /** 赞同数 */
    @Excel(name = "赞同数")
    private Long applaudNum;

    /** 评论数 */
    @Excel(name = "评论数")
    private Long commentNum;

    /** 加入书架数 */
    @Excel(name = "加入书架数")
    private Long collectNum;

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public Long getRankParmId() {
        return rankParmId;
    }

    public void setRankParmId(Long rankParmId) {
        this.rankParmId = rankParmId;
    }

    public Long getBookId() {
        return bookId;
    }

    public void setBookId(Long bookId) {
        this.bookId = bookId;
    }

    public Long getReadNum() {
        return readNum;
    }

    public void setReadNum(Long readNum) {
        this.readNum = readNum;
    }

    public Long getApplaudNum() {
        return applaudNum;
    }

    public void setApplaudNum(Long applaudNum) {
        this.applaudNum = applaudNum;
    }

    public Long getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(Long commentNum) {
        this.commentNum = commentNum;
    }

    public Long getCollectNum() {
        return collectNum;
    }

    public void setCollectNum(Long collectNum) {
        this.collectNum = collectNum;
    }
}
