import request from '@/utils/request'
import {chatApiIP} from '../../config'

// 查询用户聊天列表
export function listChat(query) {
    return request({
        url: '/chat/chat/list',
        method: 'get',
        params: query
    })
}

// 查询用户聊天详细
export function getChat(id) {
    return request({
        url: '/chat/chat/' + id,
        method: 'get'
    })
}

// 查询用户聊天记录
export function chatRecords(fromId) {
    return request({
        url: '/chat/chat/chatRecords/' + fromId,
        method: 'get'
    })
}

// 查询用户未读消息
export function chatMesHistory() {
    return request({
        url: '/chat/chat/chatMesHistory',
        method: 'get'
    })
}

// 清除全部未读消息
export function chatMesAllClose() {
    return request({
        url: '/chat/chat/chatMesAllClose',
        method: 'get'
    })
}

// 清除未读消息
export function chatMesClose(uid) {
    return request({
        url: '/chat/chat/chatMesClose/' + uid,
        method: 'get'
    })
}

// 查询用户消息列表
export function chatList() {
    return request({
        url: '/chat/chat/chatList',
        method: 'get'
    })
}

// 新增用户聊天
export function addChat(data) {
    return request({
        url: '/chat/chat',
        method: 'post',
        data: data
    })
}

// 新增用户聊天
export function chatBot(data) {
    return request({
        url: '/ai/sentAi/' + data.userinput,
        method: 'post'
    })
}

// 修改用户聊天
export function updateChat(data) {
    return request({
        url: '/chat/chat',
        method: 'put',
        data: data
    })
}

// 删除用户聊天
export function delChat(id) {
    return request({
        url: '/chat/chat/' + id,
        method: 'delete'
    })
}

// 导出用户聊天
export function exportChat(query) {
    return request({
        url: '/chat/chat/export',
        method: 'get',
        params: query
    })
}
