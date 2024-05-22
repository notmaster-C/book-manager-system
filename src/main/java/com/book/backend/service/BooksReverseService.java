package com.book.backend.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.book.backend.common.BasePage;
import com.book.backend.common.R;
import com.book.backend.pojo.BooksReverse;
import com.book.backend.pojo.dto.BooksBorrowDTO;

/**
 * @author 程序员小白条
 * @description 针对表【t_books_Reverse】的数据库操作Service
 * @createDate 2023-02-05 18:53:07
 */
public interface BooksReverseService extends IService<BooksReverse> {
    /**
     * 借阅信息查询 根据用户id，条件及其内容
     *
     * @param basePage 用于接受分页传参和用户id
     * @return R<Page < BooksReverse>>
     */
    R<Page<BooksReverse>> getBookReversePage(BasePage basePage);

    /**
     * 获取图书预约信息
     *
     * @return R<Violation>预约
     */
    R<Page<BooksReverse>> queryByBookNumber(BasePage basePage);

    /**
     * 预约图书
     *
     * @return R
     */
    R<String> reverseBook(BooksReverse booksReverse);

    R<String> borrowBookByReverse(BooksBorrowDTO booksBorrowDTO);


}
