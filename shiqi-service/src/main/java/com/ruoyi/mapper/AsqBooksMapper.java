package com.ruoyi.mapper;

import java.util.List;
import com.ruoyi.domain.AsqBooks;
import com.ruoyi.domain.AsqBooksRank;

/**
 * 图书管理Mapper接口
 *
 * @author ruoyi
 * @date 2022-03-22
 */
public interface AsqBooksMapper {
    /**
     * 查询图书管理
     *
     * @param bookId 图书管理主键
     * @return 图书管理
     */
    public AsqBooks selectAsqBooksByBookId(Long bookId);

    /**
     * 查询图书管理列表
     *
     * @param asqBooks 图书管理
     * @return 图书管理集合
     */
    public List<AsqBooks> selectAsqBooksList(AsqBooks asqBooks);

    /**
     * 新增图书管理
     *
     * @param asqBooks 图书管理
     * @return 结果
     */
    public int insertAsqBooks(AsqBooks asqBooks);

    /**
     * 修改图书管理
     *
     * @param asqBooks 图书管理
     * @return 结果
     */
    public int updateAsqBooks(AsqBooks asqBooks);

    /**
     * 删除图书管理
     *
     * @param bookId 图书管理主键
     * @return 结果
     */
    public int deleteAsqBooksByBookId(Long bookId);

    /**
     * 批量删除图书管理
     *
     * @param bookIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAsqBooksByBookIds(Long[] bookIds);

    List<AsqBooksRank> readAllRank();
}
