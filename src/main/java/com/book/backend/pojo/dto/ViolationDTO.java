package com.book.backend.pojo.dto;

import com.book.backend.pojo.Violation;
import lombok.Data;
import org.apache.poi.hpsf.Decimal;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author 程序员小白条
 *  DTO用于将管理员昵称传输
 */
@Data
public class ViolationDTO extends Violation implements Serializable{
//    /**
//     * 违章列表
//     */
//    public Violation violation;
    /**
     * 违章信息处理人的姓名
     */
    public String violationAdmin;
    /**
     * 还剩多少天逾期
     */
    public long expireDays;
    /**
     * 需要缴纳的金额
     */
    public double violationAmt;
}
