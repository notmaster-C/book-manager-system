package com.book.backend.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.book.backend.common.BasePage;
import com.book.backend.common.R;
import com.book.backend.pojo.Users;
import com.baomidou.mybatisplus.extension.service.IService;
import com.book.backend.pojo.dto.UsersDTO;
import org.apache.poi.hpsf.Decimal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import java.math.BigDecimal;

/**
 * @author 程序员小白条
 * @description 针对表【t_users】的数据库操作Service
 * @createDate 2023-02-02 16:20:02
 */
public interface UsersService extends IService<Users> {
    /**
     * Rest接受参数 查询个人用户userId
     *
     * @param userId 用户id
     * @return R<Users>
     */
    R<Users> getUserByUserId(Integer userId);

    /**
     * 修改密码
     *
     * @return R
     */
    R<String> updatePassword(Users users);

    R<String> updateAmt(Long userId);

    /**
     * 借阅用户登录
     *
     * @param users 借阅者用户
     * @return 返回R通用数据
     */
    R login(Users users);

    /**
     * 注册
     * @param users
     * @return
     */
    R register(Users users);
    /**
     * 违章扣款
     *
     * @param cardNumber 借阅证号
     * @param violationAmt 扣款金额
     * @return 返回R通用数据
     */
    R updateAccountAmt(Long cardNumber , BigDecimal  violationAmt);
    /**
     * 根据用户id传给用户所需的信息
     * @param users 用户
     * @return R<Users>
     */
    R<Users> getUserData( Users users);
    /**
     * 获取借阅证列表(用户列表)
     *
     * @param basePage 用于接受模糊查询和分页构造的参数
     * @return R<Page < Users>>
     */
    R<Page<Users>> getStatementList( BasePage basePage);
    /**
     * 获取用户信息 根据用户id  用于回显借阅证
     *
     * @param userId 用户id
     * @return R<UsersDTO>
     */
    R<UsersDTO> getStatementByUserId( Integer userId);
    /**
     * 修改借阅证信息(用户信息)
     *
     * @param usersDTO 用户DTO
     * @return R
     */
    R<String> updateStatement( UsersDTO usersDTO);
    /**
     * 删除借阅证信息 根据用户id
     *
     * @param userId 用户id
     * @return R
     */
    R<String> deleteStatementByUserId( Integer userId);
}
