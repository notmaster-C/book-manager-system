package com.book.backend.service.impl;

import cn.hutool.core.date.LocalDateTimeUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.book.backend.common.BasePage;
import com.book.backend.common.R;
import com.book.backend.common.exception.CommonError;
import com.book.backend.common.exception.VueBookException;
import com.book.backend.constant.Constant;
import com.book.backend.mapper.BooksReverseMapper;
import com.book.backend.pojo.*;
import com.book.backend.pojo.dto.BooksBorrowDTO;
import com.book.backend.pojo.dto.ViolationDTO;
import com.book.backend.service.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import static com.book.backend.pojo.Violation.isViolation;

/**
 * @author 程序员小白条
 * @description 针对表【t_books_Reverse】的数据库操作Service实现
 * @createDate 2023-02-05 18:53:07
 */
@Service
public class BooksReverseServiceImpl extends ServiceImpl<BooksReverseMapper, BooksReverse>
        implements BooksReverseService {
    @Resource
    private ViolationService violationService;

    private BooksService booksService;
    @Resource
    private UsersService usersService;
    @Resource
    private BookRuleService bookRuleService;

    @Autowired
    public BooksReverseServiceImpl(@Lazy BooksService booksService) {
        this.booksService = booksService;
    }

    /**
     * 1.先根据预约证查询是否该用户在预约表中，如果没有直接返回
     * 2.先判断BasePage中传入的condition和query是否有空值
     * 3.如果有空值，根据预约证查询所有的预约信息,放入分页构造器,设置响应状态码和请求信息，返回给前端
     * 5.如果没有空值，创建条件构造器，并根据用户id、条件、内容查询
     * 6.获取预约数据，判断是否为空，如果为空，设置响应状态码404,并提示前端查询不到数据
     * 7.如果不为空,放入分页构造器,设置响应状态码和请求信息，返回给前端
     */
    @Override
    public R<Page<BooksReverse>> getBookReversePage(BasePage basePage) {
        // 页码
        int pageNum = basePage.getPageNum();
        // 页数
        int pageSize = basePage.getPageSize();
        String cardNumber = basePage.getCardNumber();
        String bookNumber = basePage.getBookNumber();
        String condition = basePage.getCondition();
        String query = basePage.getQuery();
        R<Page<BooksReverse>> result = new R<>();
        QueryWrapper<BooksReverse> queryWrapper = new QueryWrapper<>();
        // 创建分页构造器
        Page<BooksReverse> pageInfo = new Page<>(pageNum, pageSize);
        if (!("".equals(cardNumber)||cardNumber == null)){
            queryWrapper.eq("card_number", cardNumber);
        }
        if (!("".equals(bookNumber)||bookNumber == null)){
            queryWrapper.eq("book_number", bookNumber);
        }
        if (!StringUtils.isBlank(condition) && !StringUtils.isBlank(query)) {
            queryWrapper.like(condition, query);
        }
        queryWrapper.orderByDesc("create_time");
        Page<BooksReverse> page = this.page(pageInfo, queryWrapper);
        result.setData(page);
        result.setStatus(200);
        result.setMsg("获取预约信息成功");
        return result;
    }


    @Override
    public R<Page<BooksReverse>> queryByBookNumber(BasePage basePage) {

        String bookNumberS = basePage.getBookNumber();
        long bookNumber = Long.parseLong(bookNumberS);
        R<Page<BooksReverse>> result = new R<>();
        QueryWrapper<BooksReverse> queryWrapper = new QueryWrapper<>();
        // 页码
        int pageNum = basePage.getPageNum();
        // 页数
        int pageSize = basePage.getPageSize();
        // 创建分页构造器
        Page<BooksReverse> pageInfo = new Page<>(pageNum, pageSize);
        queryWrapper.eq("book_number", bookNumber);
        List<BooksReverse> list = this.list(queryWrapper);
        // 判断用户id 是否有预约记录
        if (list.isEmpty()) {
            return R.error("获取不到该图书预约信息");
        }
        // 有预约记录
        String condition = basePage.getCondition();
        String query = basePage.getQuery();
        if (StringUtils.isBlank(condition) || StringUtils.isBlank(query)) {
            LambdaQueryWrapper<BooksReverse> queryWrapper1 = new LambdaQueryWrapper<>();
            queryWrapper1.eq(BooksReverse::getBookNumber, bookNumber).orderByAsc(BooksReverse::getCreateTime);
            this.page(pageInfo, queryWrapper1);
            result.setData(pageInfo);
            result.setStatus(200);
            result.setMsg("获取预约信息成功");
            return result;
        }
        queryWrapper.like(condition, query);
        Page<BooksReverse> page = this.page(pageInfo, queryWrapper);
        if (page.getTotal() == 0) {
            return R.error("查询不到该预约信息");
        }
        result.setData(pageInfo);
        result.setStatus(200);
        result.setMsg("获取预约信息成功");
        return result;
    }
    /**
     * 预约图书
     * 一本图书只能一个人预约
     * @return R
     */
    @Transactional
    @Override
    public R<String> reverseBook(BooksBorrowDTO booksBorrow) {
        LocalDateTime reverseDate = booksBorrow.getBorrowDate();
        if (reverseDate==null||LocalDateTime.now().isAfter(reverseDate)){
            return R.error("预约时间异常");
        }
        Long cardNumber = booksBorrow.getCardNumber();
        Long bookNumber = booksBorrow.getBookNumber();
        if (cardNumber <=0 || bookNumber <=0){
            return R.error("图书编号或者借阅证错误");
        }
        LambdaQueryWrapper<BooksReverse> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(BooksReverse::getBookNumber,bookNumber).isNull(BooksReverse::getCloseDate);
        BooksReverse one = this.getOne(queryWrapper);
        if (one != null) {
            return R.error("该图书已预约");
        }
        LambdaQueryWrapper<Users> queryWrapper1 = new LambdaQueryWrapper<>();
        queryWrapper1.eq(Users::getCardNumber, cardNumber);
        Users users = usersService.getOne(queryWrapper1);
        if (users == null) {
            return R.error("预约图书失败,用户不存在");
        }
        LambdaQueryWrapper<Books> queryWrapper2 = new LambdaQueryWrapper<>();
        queryWrapper2.eq(Books::getBookNumber, bookNumber);
        Books book = booksService.getOne(queryWrapper2);
        if ((book == null) || (book.getBookStatus().equals(Constant.BOOKDISABLE))) {
            return R.error("预约图书失败,图书不存在");
        }
        BooksReverse booksReverse =new BooksReverse();
        booksReverse.setReverseDate(reverseDate);
        booksReverse.setBookNumber(bookNumber);
        booksReverse.setCardNumber(cardNumber);
        boolean save =  this.save(booksReverse);
        if (!save) {
            return R.error("预约图书失败");
        }
        return R.success(null, "预约图书成功");
    }

    @Override
    @Transactional
    public R<String> borrowBookByReverse(Long id) {
        BooksReverse booksReverse = this.getOne(new LambdaQueryWrapper<BooksReverse>().eq(BooksReverse::getId, id));
        if(booksReverse==null || booksReverse.getCloseDate()!=null){
            return R.error("借阅图书失败");
        }
        BooksBorrowDTO booksBorrowDTO =new BooksBorrowDTO();
        // 图书编号
        Long bookNumber = booksReverse.getBookNumber();
        // 借阅证号
        Long cardNumber = booksReverse.getCardNumber();
        // 当前时间
        LocalDateTime borrowDate = LocalDateTime.now();
        booksBorrowDTO.setBorrowDate(borrowDate);
        booksBorrowDTO.setBookNumber(bookNumber);
        booksBorrowDTO.setCardNumber(cardNumber);
        //处理借阅逻辑,如果能够借阅成功 说明 没问题,修改预约的时间即可
        R<String> s = booksService.borrowBookByCardNumberAndBookNumber(booksBorrowDTO);
        if (!s.getStatus().equals(200)){
            return s;
        }
        booksReverse.setCloseDate(borrowDate);
        boolean save = this.saveOrUpdate(booksReverse);
        if (!save) {
            return R.error("借阅图书失败");
        }
        return R.success(null, "借阅图书成功");
    }

    @Override
    public R<String> delReverse(Long id) {
        if (id ==null || id <=0){
            return R.error("删除失败");
        }
        boolean flag = this.removeById(id);
        if (!flag){
            return R.error("删除失败");
        }
        return R.success(null, "删除预约记录成功");
    }
}




