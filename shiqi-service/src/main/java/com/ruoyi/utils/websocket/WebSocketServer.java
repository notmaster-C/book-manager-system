package com.ruoyi.utils.websocket;

import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.domain.AsqChat;
import com.ruoyi.service.impl.AsqChatServiceImpl;
import com.ruoyi.system.service.impl.SysUserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.TimeUnit;

/**
 * websocket 消息处理
 *
 * @author ruoyi
 */
@Component("webSocket")
//此注解相当于设置访问URL
@ServerEndpoint("/websocket/{userId}")
public class WebSocketServer {
    /**
     * 项目启动时初始化，会初始化 websocket （非用户连接的），
     * spring 同时会为其注入 service，该对象的 service 不是 null，被成功注入。
     * 但是，由于 spring 默认管理的是单例，所以只会注入一次 service。
     * 当新用户进入聊天时，系统又会创建一个新的 websocket 对象，
     * 这时矛盾出现了：spring 管理的都是单例，不会给第二个 websocket 对象注入 service，
     * 所以导致只要是用户连接创建的 websocket 对象，都不能再注入了。
     * 像 controller 里面有 service， service 里面有 dao。
     * 因为 controller，service ，dao 都是单例，所以注入时不会报 null。
     * 但是 websocket 不是单例，所以使用spring注入一次后，后面的对象就不会再注入了，会报null。
     */
    private static SysUserServiceImpl userService;
    private static AsqChatServiceImpl chatService;
    private static RedisCache redisCache;


    @Autowired
    public void setApplicationContext(SysUserServiceImpl userService) {
        WebSocketServer.userService = userService;
    }
    @Autowired
    public void setApplicationContext(AsqChatServiceImpl chatService) {
        WebSocketServer.chatService = chatService;
    }
    @Autowired
    public void setApplicationContext(RedisCache redisCache) {
        WebSocketServer.redisCache = redisCache;
    }

    private Session session;

    private static CopyOnWriteArraySet<WebSocketServer> webSockets = new CopyOnWriteArraySet<WebSocketServer>();
    private static Map<String, Session> sessionPool = new HashMap<String, Session>();

    @OnOpen
    public void onOpen(Session session, @PathParam(value = "userId") String userId) {
        this.session = session;
        webSockets.add(this);
        sessionPool.put(userId, session);
        JSONObject result = new JSONObject();
        JSONArray array = new JSONArray();
        result.put("users", array);
        for (Object key : sessionPool.keySet()) {
            JSONObject jsonObject = new JSONObject();
            SysUser sysUser = userService.selectUserById(Long.valueOf(String.valueOf(key)));
            jsonObject.put("userId", key);
            jsonObject.put("nickName", sysUser.getNickName());
            jsonObject.put("avatar", sysUser.getAvatar());
            array.add(jsonObject);
        }
        sendAllMessage(JSONUtils.toJSONString(result));
        System.out.println("【websocket消息】有新的连接，总数为:" + webSockets.size() + "用户id：" + userId);
    }

    @OnClose
    public void onClose() {
        webSockets.remove(this);
        Object obj = (Object) this.session.getRequestParameterMap().get("userId").get(0);
        String userId = String.valueOf(obj);
        sessionPool.remove(userId);
        System.out.println("【websocket消息】连接断开，总数为:" + webSockets.size());
    }

    @OnMessage
    public void onMessage(String message) {
        Map obj = (Map) JSONUtils.parse(message);
        String userId = obj.get("userId").toString();
        // to表示发送给哪个用户，比如 admin
        String toUserId = obj.get("to").toString();
        // 发送的消息文本  hello
        String text = obj.get("text").toString();
        // {"to": "admin", "text": "聊天文本"}
        if (toUserId.isEmpty()) {
            this.sendAllMessage(text);
        } else {
//           消息持久化
            AsqChat asqChat = new AsqChat();
            asqChat.setUserId(Long.valueOf(userId));
            asqChat.setFromId(Long.valueOf(toUserId));
            asqChat.setContent(text);
            chatService.insertAsqChat(asqChat);
            this.sendOneMessage(toUserId, userId, text);
        }
    }

    // 此为广播消息
    public void sendAllMessage(String message) {
        for (WebSocketServer webSocket : webSockets) {
            System.out.println("【websocket消息】广播消息:" + message);
            try {
                webSocket.session.getAsyncRemote().sendText(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // 此为单点消息
    public void sendOneMessage(String userId, String from, String message) {
        Session session = sessionPool.get(userId);
        Session sessionFrom = sessionPool.get(from);
//        session为空则是不在线，存入redis中
        if(session == null){
            String key = "messages_uid_" + userId + "_fid_" + from;
            redisCache.setCacheObject(key, message);

            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("from", userId);
            jsonObject1.put("text", "拾柒提示：用户当前离线喔~");
            String mes = jsonObject1.toString();
            System.out.println("【websocket消息】单点消息:" + mes);
            if (sessionFrom != null) {
                try {
                    sessionFrom.getAsyncRemote().sendText(mes);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            //消息持久化
            AsqChat asqChat = new AsqChat();
            asqChat.setUserId(Long.valueOf(userId));
            asqChat.setFromId(Long.valueOf(from));
            asqChat.setContent("拾柒提示：用户当前离线喔~");
            chatService.insertAsqChat(asqChat);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("from", from);
        jsonObject.put("text", message);
        String mes = jsonObject.toString();
        System.out.println("【websocket消息】单点消息:" + mes);
        if (session != null) {
            try {
                session.getAsyncRemote().sendText(mes);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
