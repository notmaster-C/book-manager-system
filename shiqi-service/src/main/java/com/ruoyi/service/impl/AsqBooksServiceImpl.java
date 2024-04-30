package com.ruoyi.service.impl;

import java.util.*;

import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.domain.AsqBooksRank;
import com.ruoyi.domain.vo.AsqApplaudAndBookInfoVo;
import com.ruoyi.mapper.AsqApplaudMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.mapper.AsqBooksMapper;
import com.ruoyi.domain.AsqBooks;
import com.ruoyi.service.IAsqBooksService;

/**
 * 图书管理Service业务层处理
 *
 * @author ruoyi
 * @date 2022-03-22
 */
@Service
public class AsqBooksServiceImpl implements IAsqBooksService {
    @Autowired
    private AsqBooksMapper asqBooksMapper;
    @Autowired
    private AsqApplaudMapper asqApplaudMapper;

    /**
     * 查询图书管理
     *
     * @param bookId 图书管理主键
     * @return 图书管理
     */
    @Override
    public AsqBooks selectAsqBooksByBookId(Long bookId) {
        return asqBooksMapper.selectAsqBooksByBookId(bookId);
    }

    /**
     * 查询图书管理列表
     *
     * @param asqBooks 图书管理
     * @return 图书管理
     */
    @Override
    public List<AsqBooks> selectAsqBooksList(AsqBooks asqBooks) {
        return asqBooksMapper.selectAsqBooksList(asqBooks);
    }

    /**
     * 新增图书管理
     *
     * @param asqBooks 图书管理
     * @return 结果
     */
    @Override
    public int insertAsqBooks(AsqBooks asqBooks) {
        return asqBooksMapper.insertAsqBooks(asqBooks);
    }

    /**
     * 修改图书管理
     *
     * @param asqBooks 图书管理
     * @return 结果
     */
    @Override
    public int updateAsqBooks(AsqBooks asqBooks) {
        return asqBooksMapper.updateAsqBooks(asqBooks);
    }

    /**
     * 批量删除图书管理
     *
     * @param bookIds 需要删除的图书管理主键
     * @return 结果
     */
    @Override
    public int deleteAsqBooksByBookIds(Long[] bookIds) {
        return asqBooksMapper.deleteAsqBooksByBookIds(bookIds);
    }

    /**
     * 删除图书管理信息
     *
     * @param bookId 图书管理主键
     * @return 结果
     */
    @Override
    public int deleteAsqBooksByBookId(Long bookId) {
        return asqBooksMapper.deleteAsqBooksByBookId(bookId);
    }

    @Override
    public List<AsqBooksRank> readAllRank() {
        return asqBooksMapper.readAllRank();
    }

    /**
     * 协同过滤算法
     * 根据用户的行为：对图书的评论，喜欢，阅读，加入书架等，来进行推荐相关的图书
     *
     * @return 用户可能喜欢的书籍
     */
    @Override
    public List<AsqBooks> GYWLike() {
        ArrayList<AsqBooks> asqBooks1 = new ArrayList<>();
        Random random = new Random();
        AsqApplaudAndBookInfoVo vo = new AsqApplaudAndBookInfoVo();
        //判断用户是否登录
        if (SecurityUtils.getUnUserId() != -1) {
            vo.setUserId(SecurityUtils.getUnUserId());
        }
        //查询用户加入书架的图书列表
        List<AsqApplaudAndBookInfoVo> bookInfoList = asqApplaudMapper.selectAsqApplaudAndBookInfoList(vo);
        //如果用户有加入书架的图书
        if (bookInfoList.size() != 0) {
            //书籍类型数组
            String[] key = new String[3];
            for (int i = 0; i < 4; i++) {
                //书籍类型随机添加到书籍类型数组
                AsqApplaudAndBookInfoVo vo1 = bookInfoList.get(random.nextInt(bookInfoList.size()));
                key[0] = vo1.getBookType();
            }
            AsqBooks asqBooks = new AsqBooks();
            for (int i = 0; i < key.length; i++) {
                //根据书籍类型数组查询图书，并将查询的书籍随机返回
                asqBooks.setBookType(key[i]);
                List<AsqBooks> asqBooks2 = asqBooksMapper.selectAsqBooksList(asqBooks);
                asqBooks1.add(asqBooks2.get(random.nextInt(asqBooks2.size())));
            }
            return asqBooks1;
        } else {
            //如果书架没有一本书的话，就随机查询
            List<AsqBooks> asqBooks = asqBooksMapper.selectAsqBooksList(new AsqBooks());
            int[] ints = randomKey(asqBooks.size());
            for (int i = 0; i < ints.length; i++) {
                asqBooks1.add(asqBooks.get(ints[i]));
            }
            return asqBooks1;
        }
    }

    /**
     * @param size 随机数组的长度
     * @return 返回随机数组
     */
    private static int[] randomKey(int size) {
        Set<Integer> ints = new HashSet<>();
        while (true) {
            ints.add(new Random().nextInt(size));
            if (ints.size() == 3) {
                break;
            }
        }
        int[] ints1 = new int[3];
        Object[] objects = ints.toArray();
        for (int i1 = 0; i1 < ints.size(); i1++) {
            ints1[i1] = (int) objects[i1];
        }
        return ints1;
    }
}
