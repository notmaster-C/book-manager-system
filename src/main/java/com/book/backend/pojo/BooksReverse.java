package com.book.backend.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 *
 * @TableName t_books_reverse
 */
@TableName(value ="t_books_reverse")
@Data
public class BooksReverse implements Serializable {
    /**
     * 预约表唯一标识
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 预约证编号 固定11位随机生成 用户和图书关联的唯一标识
     */
    private Long cardNumber;

    /**
     * 图书编号 图书唯一标识
     */
    private Long bookNumber;

    /**
     * 预约日期
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private LocalDateTime reverseDate;

    /**
     * 截止日期
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private LocalDateTime closeDate;


    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private String createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String updateTime;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    public BooksReverse(Integer id, Long cardNumber, Long bookNumber, LocalDateTime reverseDate, LocalDateTime closeDate,String createTime, String updateTime) {
        this.id = id;
        this.cardNumber = cardNumber;
        this.bookNumber = bookNumber;
        this.reverseDate = reverseDate;
        this.closeDate = closeDate;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public BooksReverse() {
    }
}
