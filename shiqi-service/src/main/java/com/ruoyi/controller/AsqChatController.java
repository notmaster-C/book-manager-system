package com.ruoyi.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.domain.AsqBooks;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.system.service.impl.SysUserServiceImpl;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.domain.AsqChat;
import com.ruoyi.service.IAsqChatService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 用户聊天Controller
 *
 * @author zjh
 * @date 2023-04-19
 */
@RestController
@RequestMapping("/chat/chat")
public class AsqChatController extends BaseController {
    @Autowired
    private IAsqChatService asqChatService;
    @Autowired
    private RedisCache redisCache;
    @Autowired
    private ISysUserService sysUserService;

    /**
     * 查询用户聊天列表
     */
    @PreAuthorize("@ss.hasPermi('chat:chat:list')")
    @GetMapping("/list")
    public TableDataInfo list(AsqChat asqChat) {
        startPage();
        List<AsqChat> list = asqChatService.selectAsqChatList(asqChat);
        return getDataTable(list);
    }

    /**
     * 导出用户聊天列表
     */
    @PreAuthorize("@ss.hasPermi('chat:chat:export')")
    @Log(title = "用户聊天", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(AsqChat asqChat) {
        List<AsqChat> list = asqChatService.selectAsqChatList(asqChat);
        ExcelUtil<AsqChat> util = new ExcelUtil<AsqChat>(AsqChat.class);
        return util.exportExcel(list, "用户聊天数据");
    }

    /**
     * 获取用户聊天详细信息
     */
    @PreAuthorize("@ss.hasPermi('chat:chat:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(asqChatService.selectAsqChatById(id));
    }

    /**
     * redis 查询未读消息
     */
    @GetMapping("/chatMesHistory")
    public TableDataInfo listHistory() {
        startPage();
        Collection<String> keys = redisCache.keys("messages_uid_" + SecurityUtils.getUserId() + "_*");
        Object[] objects = keys.toArray();
        ArrayList<AsqChat> asqChats = new ArrayList<>();
        for (int i = 0; i < objects.length; i++) {
            AsqChat asqChat1 = new AsqChat();
            asqChat1.setContent(redisCache.getCacheObject((String) objects[i]));
            asqChat1.setSysUser(sysUserService.selectUserById(Long.valueOf(StringUtils.substringAfterLast((String) objects[i], "fid_"))));
            asqChats.add(asqChat1);
        }
        return getDataTable(asqChats);
    }

    /**
     * 清除未读消息
     */
    @GetMapping("/chatMesClose/{id}")
    public AjaxResult chatMesClose(@PathVariable("id") Long id) {
        String key = "messages_uid_" + SecurityUtils.getUserId() + "_fid_" + id;
        redisCache.deleteObject(key);
        return AjaxResult.success();
    }

    /**
     * 清除全部未读消息
     */
    @GetMapping("/chatMesAllClose")
    public AjaxResult chatMesAllClose() {
        Collection<String> keys = redisCache.keys("messages_uid_" + SecurityUtils.getUserId() + "_fid_*");
        for (String key : keys) {
            redisCache.deleteObject(key);
        }
        return AjaxResult.success("1024");
    }


    /**
     * 查询用户聊天列表
     */
    @GetMapping("/chatList")
    public AjaxResult chatList() {
        List<AsqChat> list = asqChatService.selectAsqChatListByUserId(SecurityUtils.getUserId());
        return AjaxResult.success(list);
    }

    /**
     * 查询用户聊天记录
     */
    @GetMapping("/chatRecords/{fromId}")
    public AjaxResult chatRecords(@PathVariable("fromId") Long fromId) {
        List<AsqChat> list = asqChatService.selectChatRecordsByUserId(SecurityUtils.getUserId(), fromId);
        return AjaxResult.success(list);
    }

    /**
     * 新增用户聊天
     */
    @PreAuthorize("@ss.hasPermi('chat:chat:add')")
    @Log(title = "用户聊天", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AsqChat asqChat) {
        return toAjax(asqChatService.insertAsqChat(asqChat));
    }

    /**
     * 修改用户聊天
     */
    @PreAuthorize("@ss.hasPermi('chat:chat:edit')")
    @Log(title = "用户聊天", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AsqChat asqChat) {
        return toAjax(asqChatService.updateAsqChat(asqChat));
    }

    /**
     * 删除用户聊天
     */
    @PreAuthorize("@ss.hasPermi('chat:chat:remove')")
    @Log(title = "用户聊天", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(asqChatService.deleteAsqChatByIds(ids));
    }
}
