package com.book.backend.controller.bookadmin;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.book.backend.common.BasePage;
import com.book.backend.common.R;
import com.book.backend.pojo.*;
import com.book.backend.pojo.dto.*;
import com.book.backend.service.*;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.List;

/**
 * @author 程序员小白条
 */
@RestController
@RequestMapping("/bookadmin")
public class BookAdminFunctionController {
    @Resource
    private BookAdminsService bookAdminsService;

    @Resource
    private BooksService booksService;
    @Resource
    private BooksBorrowService booksBorrowService;

    @Resource
    private NoticeService noticeService;
    @Resource
    private UsersService usersService;
    @Resource
    private AdminsService adminsService;
    @Resource
    private ViolationService violationService;
    @Resource
    private BookTypeService bookTypeService;
    @Resource
    private BookRuleService bookRuleService;
    @Resource
    private BooksReverseService booksReverseService;
    /**
     * 借阅图书根据借阅证号和图书编号
     *
     * @return R
     */
    @PostMapping("borrow_book")
    @ApiOperation("根据借阅证号和图书编号借阅图书")
    public R<String> borrowBookByCardNumberAndBookNumber(@RequestBody BooksBorrowDTO booksBorrowDTO) {
        return booksService.borrowBookByCardNumberAndBookNumber(booksBorrowDTO);
    }
    /**
     * 借阅已预约图书根据借阅证号和图书编号
     *
     * @return R
     */
    @GetMapping("reverse_book/{id}")
    @ApiOperation("根据借阅证号和图书编号借阅图书")
    public R<String> borrowBookByReverse(@PathVariable("id") Long id) {
        return booksReverseService.borrowBookByReverse(id);
    }
    @GetMapping("del_reverse/{id}")
    @ApiOperation("删除预约记录")
    public R<String> delReverse(@PathVariable("id") Long id) {
        return booksReverseService.delReverse(id);
    }
    /**
     * 预约列表
     *
     * @return R
     */
    @PostMapping("reverse_list")
    @ApiOperation("根据借阅证号和图书编号查看预约列表图书")
    public R<Page<BooksReverse>> reverseList(@RequestBody BasePage basePage) {
        return booksReverseService.getBookReversePage(basePage);
    }
    /**
     * 查看图书是否有逾期(查看是否借出)
     *
     * @param bookNumber 图书编号
     * @return R
     */
    @GetMapping("query_book/{bookNumber}")
    @ApiOperation("查看图书是否有逾期")
    public R<String> queryBookExpireByBookNumber(@PathVariable("bookNumber") Long bookNumber) {
        return booksService.queryBookExpireByBookNumber(bookNumber);
    }

    /**
     * 获取图书逾期信息
     *
     * @param bookNumber 图书编号
     * @return R<Violation>
     */
    @GetMapping("query_expire/{bookNumber}")
    @ApiOperation("获取图书逾期信息")
    public R<ViolationDTO> queryExpireInformationByBookNumber(@PathVariable("bookNumber") Long bookNumber) {
        return booksBorrowService.queryExpireInformationByBookNumber(bookNumber);
    }

    /**
     * 归还图书
     *
     * @param violation 违章表
     * @return R
     */
    @PostMapping("return_book")
    @ApiOperation("归还图书")
    public R<String> returnBook(@RequestBody Violation violation) {
        return booksBorrowService.returnBook(violation);
    }
    @GetMapping("payment/{userId}")
    @ApiOperation("钱包充值")
    public R<String> updateAmt(@PathVariable("userId") Long userId) {
        return usersService.updateAmt(userId);
    }
    /**
     * 获取还书报表
     *
     * @param basePage 接受分页构造器和模糊查询的传参
     * @return R<Page < BooksBorrow>>
     */
    @PostMapping("get_return_statement")
    @ApiOperation("获取还书报表")
    public R<Page<BooksBorrow>> getReturnStatement(@RequestBody BasePage basePage) {
        return booksBorrowService.getReturnStatement(basePage);
    }

    /**
     * 获取违章报表
     *
     * @param basePage 接受分页构造器和模糊查询的传参
     * @return R<Page < ViolationDTO>>
     */
    @PostMapping("get_borrow_statement")
    @ApiOperation("获取借书报表")
    public R<Page<ViolationDTO>> getBorrowStatement(@RequestBody BasePage basePage) {
        return bookAdminsService.getBorrowStatement(basePage);
    }
    /**
     * 获取借书报表
     *
     * @param basePage 接受分页构造器和模糊查询的传参
     * @return R<Page < ViolationDTO>>
     */
    @PostMapping("get_borrow_statementV2")
    @ApiOperation("获取借书报表")
    public R<Page<BooksBorrow>> getBorrowStatementV2(@RequestBody BasePage basePage) {
        return bookAdminsService.getBorrowStatementV2(basePage);
    }
    /**
     * 获取公告列表
     *
     * @return R<Notice>
     */
    @PostMapping("get_noticelist")
    @ApiOperation("获取公告列表")
    public R<Page<Notice>> getNoticeList(@RequestBody BasePage basePage) {
        return noticeService.getNoticeList(basePage);
    }

    /**
     * 添加公告
     *
     * @param notice 公告
     * @return R<String>
     */
    @PostMapping("add_notice")
    @ApiOperation("添加公告")
    public R<String> addNotice(@RequestBody Notice notice) {
        return noticeService.addNotice(notice);
    }

    /**
     * 删除公告根据指定的id
     *
     * @param noticeId 公告id
     * @return R
     */
    @GetMapping("delete_notice/{noticeId}")
    @ApiOperation("删除公告根据指定的id")
    public R<String> deleteNoticeById(@PathVariable("noticeId") Integer noticeId) {
        return noticeService.deleteNoticeById(noticeId);
    }

    /**
     * 根据指定id获取公告
     *
     * @param noticeId 公告id
     * @return R<Notice>
     */
    @GetMapping("get_notice/{noticeId}")
    @ApiOperation("根据指定id获取公告")
    public R<Notice> getNoticeByNoticeId(@PathVariable("noticeId") Integer noticeId) {
        return noticeService.getNoticeByNoticeId(noticeId);
    }

    /**
     * 更新公告根据公告id
     *
     * @param noticeId 公告id
     * @param notice   公告
     * @return R
     */
    @PutMapping("update_notice/{noticeId}")
    @ApiOperation("更新公告根据公告id")
    public R<String> updateNoticeByNoticeId(@PathVariable("noticeId") Integer noticeId, @RequestBody Notice notice) {
        return noticeService.updateNoticeByNoticeId(noticeId, notice);
    }

    /**
     * 获取借阅量
     *
     * @return R<BorrowData>
     */
    @GetMapping("get_borrowdata")
    @ApiOperation("获取借阅量")
    public R<BorrowData> getBorrowDate() {
        return violationService.getBorrowDate();
    }

    /**
     * 获取借书分类统计情况
     *
     * @return R<List < BorrowTypeDTO>>
     */
    @GetMapping("get_borrowtype_statistics")
    @ApiOperation("获取借书分类统计情况")
    public R<List<BorrowTypeDTO>> getBorrowTypeStatistic() {
        return booksService.getBorrowTypeStatistic();
    }

    /**
     * 批量删除图书
     *
     * @param booksList 图书列表
     * @return R<String>
     */
    @DeleteMapping("delete_book_batch")
    @ApiOperation("批量删除图书")
    public R<String> deleteBookByBatch(@RequestBody List<Books> booksList) {
        return booksService.deleteBookByBatch(booksList);

    }

    /**
     * 从Excel批量导入图书
     *
     * @param file 文件
     * @return R<String>
     * @throws IOException IO异常
     */
    @PostMapping("/updown")
    @ApiOperation("从Excel批量导入图书")
    public R<String> upload(@RequestParam("files") MultipartFile file) throws IOException {
        return adminsService.upload(file);
    }

    /**
     * 获取图书列表
     *
     * @param basePage 页码，页数，条件和内容
     * @return R<Page < Books>>
     */
    @PostMapping("get_booklist")
    @ApiOperation("获取图书列表")
    public R<Page<Books>> getBookList(@RequestBody BasePage basePage) {
        return booksService.getBookList(basePage);
    }

    /**
     * 查询书籍类型的列表 用于添加图书中回显分类
     *
     * @return R<BookType>
     */
    @GetMapping("get_type")
    @ApiOperation("查询书籍类型列表")
    public R<List<BookType>> getBookTypeList() {
        return bookTypeService.getBookTypeList();
    }

    /**
     * 添加图书 利用DTO去接受 书籍类别的id 然后再通过id查询分类表获取分类名称 封装给图书
     *
     * @return R
     */
    @PostMapping("add_book")
    @ApiOperation("添加图书")
    public R<String> addBook(@RequestBody BookDTO bookDTO) {
        return booksService.addBook(bookDTO);
    }

    /**
     * 根据图书id删除对应的图书
     *
     * @param bookId 图书id
     * @return R
     */
    @GetMapping("delete_book/{bookId}")
    @ApiOperation("根据图书id删除对应的图书")
    public R<String> deleteBookByBookId(@PathVariable("bookId") Integer bookId) {
        return booksService.deleteBookByBookId(bookId);
    }

    /**
     * 根据图书id获得相对应的图书信息
     *
     * @param bookId 图书id
     * @return R<Books>
     */
    @GetMapping("get_bookinformation/{bookId}")
    @ApiOperation("根据图书id获得相对应的图书信息")
    public R<Books> getBookInformationByBookId(@PathVariable("bookId") Integer bookId) {
        return booksService.getBookInformationByBookId(bookId);
    }

    /**
     * 根据前端传输的图书信息更新图书
     *
     * @param books 图书
     * @return R
     */
    @PostMapping("update_book")
    @ApiOperation("更新图书")
    public R<String> updateBookByEditForm(@RequestBody Books books) {
        return booksService.updateBookByEditForm(books);
    }

    /**
     * 书籍类别 获取书籍类别的列表
     *
     * @return R<List < BookType>>
     */
    @PostMapping("get_booktype_page")
    @ApiOperation("获取书籍类别的列表")
    public R<Page<BookType>> getBookTypeListByPage(@RequestBody BasePage basePage) {
        return bookTypeService.getBookTypeListByPage(basePage);
    }

    /**
     * 添加书籍类别
     *
     * @param bookType 书籍类别
     * @return R
     */
    @PostMapping("add_booktype")
    @ApiOperation("添加书籍类别")
    public R<String> addBookType(@RequestBody BookType bookType) {
        return bookTypeService.addBookType(bookType);
    }

    /**
     * 根据书籍类别id 获取书籍类别信息
     *
     * @param typeId 书籍类别id
     * @return R
     */
    @GetMapping("get_booktype/{typeId}")
    @ApiOperation("获取书籍类别信息")
    public R<BookType> getBookTypeByTypeId(@PathVariable("typeId") Integer typeId) {
        return bookTypeService.getBookTypeByTypeId(typeId);
    }

    /**
     * 更新书籍类别
     *
     * @param bookType 书籍类别
     * @return R
     */
    @PostMapping("update_booktype")
    @ApiOperation("更新书籍类别")
    public R<String> updateBookType(@RequestBody BookType bookType) {
        return bookTypeService.updateBookType(bookType);
    }

    /**
     * 删除书籍类别 根据书籍类别的ID
     *
     * @param typeId 书籍类别的id
     * @return R
     */
    @GetMapping("delete_booktype/{typeId}")
    @ApiOperation("删除书籍类别")
    public R<String> deleteBookTypeByTypeId(@PathVariable("typeId") Integer typeId) {
        return bookTypeService.deleteBookTypeByTypeId(typeId);
    }

    /**
     * 获取借阅证列表(用户列表)
     *
     * @param basePage 用于接受模糊查询和分页构造的参数
     * @return R<Page < Users>>
     */
    @PostMapping("get_statementlist")
    @ApiOperation("获取借阅证列表")
    public R<Page<Users>> getStatementList(@RequestBody BasePage basePage) {
        return usersService.getStatementList(basePage);
    }

    /**
     * 添加借阅证
     *
     * @param usersDTO 用户DTO
     * @return R<String>
     */
    @PostMapping("add_statement")
    @ApiOperation("添加借阅证")
    public R<String> addStatement(@RequestBody UsersDTO usersDTO) {
        return adminsService.addRule(usersDTO);
    }

    /**
     * 获取用户信息 根据用户id  用于回显借阅证
     *
     * @param userId 用户id
     * @return R<UsersDTO>
     */
    @GetMapping("get_statement/{userId}")
    @ApiOperation("获取用户信息用于回显借阅证")
    public R<UsersDTO> getStatementByUserId(@PathVariable("userId") Integer userId) {
        return usersService.getStatementByUserId(userId);
    }

    /**
     * 修改借阅证信息(用户信息)
     *
     * @param usersDTO 用户DTO
     * @return R
     */
    @PostMapping("update_statement")
    @ApiOperation("修改借阅证信息")
    public R<String> updateStatement(@RequestBody UsersDTO usersDTO) {
        return usersService.updateStatement(usersDTO);
    }

    /**
     * 删除借阅证信息 根据用户id
     *
     * @param userId 用户id
     * @return R
     */
    @DeleteMapping("delete_statement/{userId}")
    @ApiOperation("删除借阅证信息")
    public R<String> deleteStatementByUserId(@PathVariable("userId") Integer userId) {
        return usersService.deleteStatementByUserId(userId);
    }

    /**
     * 获取规则列表(分页)
     *
     * @param basePage 分页构造器用于接受页数和页码
     * @return R<Page < BookRule>>
     */
    @PostMapping("get_rulelist_page")
    @ApiOperation("获取规则列表")
    public R<Page<BookRule>> getRuleListByPage(@RequestBody BasePage basePage) {
        return bookRuleService.getRuleListByPage(basePage);
    }

    /**
     * 添加规则
     *
     * @param bookRule 图书规则
     * @return R
     */
    @PostMapping("add_rule")
    @ApiOperation("添加规则")
    public R<String> addRule(@RequestBody BookRule bookRule) {
        return bookRuleService.addRule(bookRule);
    }

    /**
     * 根据规则编号 查询规则
     *
     * @param ruleId 规则编号
     * @return R<BookRule>
     */
    @GetMapping("get_rule_ruleid/{ruleId}")
    @ApiOperation("根据规则编号查询规则")
    public R<BookRuleDTO> getRuleByRuleId(@PathVariable("ruleId") Integer ruleId) {
        return bookRuleService.getRuleByRuleId(ruleId);
    }

    /**
     * 修改规则
     *
     * @param bookRuleDTO 图书规则
     * @return R
     */
    @PutMapping("update_rule")
    @ApiOperation("修改规则")
    public R<String> updateRule(@RequestBody BookRuleDTO bookRuleDTO) {
        return bookRuleService.updateRule(bookRuleDTO);
    }

    /**
     * 删除规则
     *
     * @param ruleId 规则编号
     * @return R
     */
    @DeleteMapping("delete_rule/{ruleId}")
    @ApiOperation("删除规则")
    public R<String> deleteRule(@PathVariable("ruleId") Integer ruleId) {
        return bookRuleService.deleteRule(ruleId);
    }
}
