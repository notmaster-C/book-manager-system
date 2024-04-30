<template>
  <div style="padding-left: 10%;padding-right: 10%">
    <el-row>
      <el-col :span="8">
        <el-card style="width: 100%; min-height: 300px; color: #333">
          <div style="padding-bottom: 10px; border-bottom: 1px solid #ccc">最近联系
          </div>
          <div v-if="this.chatsList.length != 0">
            <el-card :shadow="chatUser.userId == chat.userId?'always':'hover'" v-for="(chat,index) in chatsList"
                     :key="index" style="margin-top: 3px;"
                     body-style="padding:6px 2px 6px 2px">
              <div @click="openIM(chat)">
                <el-row>
                  <el-col :span="4">
                    <el-avatar
                        :src="baseUrl+chat.avatar"
                        shape="square" style="vertical-align: middle;">
                    </el-avatar>
                  </el-col>
                  <el-col :span="20">
                    <span style="font-size: 16px;">{{ chat.nickName }}</span>
                    <span style="font-size: 6px; color: #606266; float: right">{{ chat.time }}</span>
                    <p style="line-height: 0;font-size: 14px;color: #606266">
                      {{ chat.content | ellipsis }}
                    </p>
                  </el-col>
                </el-row>
              </div>
            </el-card>
          </div>
          <el-empty v-else description="暂无私信~"></el-empty>
        </el-card>
      </el-col>
      <el-col :span="16">
        <div style="width: 800px; margin: 0 auto; background-color: white;
                    border-radius: 5px; box-shadow: 0 0 10px #ccc">
          <div style="text-align: center; font-size: 20px;font-weight: bold; line-height: 50px;">
            {{ chatUser.nickName }}
          </div>
          <div v-html="content" style="height: 280px;overflow: auto " id="QAContent">

          </div>
          <div style="height: 200px">
            <textarea v-model="text" style="height: 160px; width: 100%; padding: 20px; border: none; border-top: 1px solid #ccc;
             border-bottom: 1px solid #ccc; outline: none" @keyup.enter="send"></textarea>
            <div style="text-align: right; padding-right: 10px">
              <el-button type="primary" size="mini" @click="send">发送</el-button>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import {getInfo} from "../../../api/login";
import {chatList, chatRecords} from "../../../api/chat/chat";
import {computerIp} from "../../../config.js"

let socket;
export default {
  name: "cmsIM",
  filters: {
    ellipsis(value) {
      if (!value) return ''
      if (value.length > 26) {
        return value.slice(0, 26) + '...'
      }
      return value
    }
  },
  data() {
    return {
      baseUrl: process.env.VUE_APP_BASE_API,
      user: {
        userId: '',
        nickName: '',
        avatar: ''
      },
      isCollapse: false,
      users: [],
      chatUser: {
        userId: '',
        nickName: '',
        avatar: ''
      },
      text: '',
      chatsList: [],
      content: ''
    }
  },
  created() {
    if (this.$route.query.userId != null) {
      this.user.userId = this.$route.query.userId
      this.user.nickName = this.$route.query.nickName
      this.user.avatar = this.$route.query.avatar
      this.openIM(this.user)
    }
    this.initUserInfo()
  },
  destroyed() {
    this.isCollapse = true
    socket.onclose()
  },
  methods: {
    openIM(user) {
      this.content = ''
      this.chatUser.userId = user.userId
      this.chatUser.nickName = user.nickName
      this.chatUser.avatar = user.avatar
      chatRecords(this.chatUser.userId).then(res => {
        for (let i = 0; i < res.data.length; i++) {
          let item = res.data[i]
          if (item.userId == this.chatUser.userId) {
            this.createContent(this.chatUser, null, item.content)
          } else {
            this.createContent(null, item.userId, item.content)
          }
        }
      })
    },
    send() {
      if (!this.chatUser.userId) {
        this.$message({type: 'warning', message: "请选择聊天对象"})
        return;
      }
      if (!this.text) {
        this.$message({type: 'warning', message: "请输入内容"})
      } else {
        if (typeof (WebSocket) == "undefined") {
          this.$message({type: 'error', message: "网络不稳定！"})
        } else {
          // 组装待发送的消息 json
          // {"from": "zhang", "to": "admin", "text": "聊天文本"}
          let message = {userId: this.user.userId, to: this.chatUser.userId, text: this.text}
          socket.send(JSON.stringify(message));  // 将组装好的json发送给服务端，由服务端进行转发
          // 构建消息内容，本人消息
          this.createContent(null, this.user.userId, this.text)
          this.text = '';
        }
      }
    },
    createContent(remoteUser, nowUser, text) {  // 这个方法是用来将 json的聊天消息数据转换成 html的。
      let html
      // 当前用户消息
      if (nowUser) { // nowUser 表示是否显示当前用户发送的聊天消息，绿色气泡
        html = "<div class=\"el-row\" style=\"padding: 5px 0\">\n" +
            "  <div class=\"el-col el-col-22\" style=\"text-align: right; padding-right: 10px\">\n" +
            "    <div class=\"tip left\">" + text + "</div>\n" +
            "  </div>\n" +
            "  <div class=\"el-col el-col-2\">\n" +
            "  <span class=\"el-avatar el-avatar--circle\" style=\"height: 40px; width: 40px; line-height: 40px;\">\n" +
            `    <img src="${this.baseUrl + this.user.avatar}" style=\"object-fit: cover;\">\n` +
            "  </span>\n" +
            "  </div>\n" +
            "</div>";
      } else if (remoteUser) {   // remoteUser表示远程用户聊天消息，蓝色的气泡
        html = "<div class=\"el-row\" style=\"padding: 5px 0\">\n" +
            "  <div class=\"el-col el-col-2\" style=\"text-align: right\">\n" +
            "  <span class=\"el-avatar el-avatar--circle\" style=\"height: 40px; width: 40px; line-height: 40px;\">\n" +
            `    <img src="${this.baseUrl + this.chatUser.avatar}" style=\"object-fit: cover;\">\n` +
            "  </span>\n" +
            "  </div>\n" +
            "  <div class=\"el-col el-col-22\" style=\"text-align: left; padding-left: 10px\">\n" +
            "    <div class=\"tip right\">" + text + "</div>\n" +
            "  </div>\n" +
            "</div>";
      }
      this.content += html;
      // this.$nextTick 将回调延迟到下次DOM更新循环之后执行。在修改数据之后立即使用它，然后等待DOM更新
      this.$nextTick(() => {
        let msg = document.getElementById('QAContent') // 获取对象
        msg.scrollTop = msg.scrollHeight // 滚动高度
      })
    },
    initUserInfo() {
      getInfo().then(res => {
        this.user = res.user
        chatList().then(res => {
          this.chatsList = res.data;
        })
        this.init()
      })
    },
    init() {
      let userId = this.user.userId;
      let _this = this;
      if (typeof (WebSocket) == "undefined") {
        this.$message({type: 'error', message: "您的浏览器暂不支持该功能！"})
      } else {
        this.$message({type: 'success', message: "连接成功！"})
        let socketUrl = "ws://" + computerIp + ":8080/websocket/" + userId;
        if (socket != null) {
          socket.close();
          socket = null;
        }
        // 开启一个websocket服务
        socket = new WebSocket(socketUrl);
        //打开事件
        socket.onopen = function () {
          console.log("websocket已打开");
        };
        //  浏览器端收消息，获得从服务端发送过来的文本消息
        socket.onmessage = function (msg) {
          console.log("收到数据====" + msg.data)
          // 对收到的json数据进行解析， 类似这样的： {"users": [{"username": "zhang"},{ "username": "admin"}]}
          let data = JSON.parse(msg.data)
          if (data.users) {  // 获取在线人员信息
            // 获取当前连接的所有用户信息，并且排除自身，自己不会出现在自己的聊天列表里
            _this.users = data.users.filter(user => user.userId != userId)
          } else {
            // 如果服务器端发送过来的json数据 不包含 users 这个key，那么发送过来的就是聊天文本json数据
            //  // {"from": "zhang", "text": "hello"}
            console.log(data.text)
            if (_this.isCollapse) {
              let notify = _this.$notify({
                title: '收到了一条私信！',
                message: data.text,
                duration: 0,
                iconClass: "el-icon-message",
                offset: 100,
                onClick() {
                  notify.close()
                  _this.$router.push({
                    path: "/cms/main/cmsIM",
                    query: {
                      userId: data.from,
                    }
                  });
                },
              });
            } else {
              if (data.from == _this.chatUser.userId) {
                // 构建消息内容
                _this.createContent(data.from, null, data.text)
              }
            }
          }
        };
        //关闭事件
        socket.onclose = function () {

        };
        //发生了错误事件
        socket.onerror = function () {
          _this.$message({type: 'error', message: "网络异常！"})
        }
      }
    }
  }
}
</script>
<style>
.tip {
  color: white;
  text-align: center;
  border-radius: 10px;
  font-family: sans-serif;
  padding: 10px;
  width: auto;
  display: inline-block !important;
  display: inline;
}

.right {
  background-color: deepskyblue;
}

.left {
  background-color: rgb(49 174 142);;
}
</style>
