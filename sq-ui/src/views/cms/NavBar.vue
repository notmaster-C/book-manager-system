<template>
  <el-header :style="'margin-bottom:'+ headerBottom +'px'">
    <router-link to="/">
      <h1 class="logo" style="color: #30B08F;">拾柒爱阅读</h1>
    </router-link>
    <div class="bg-purple-light">
      <el-menu :default-active="activeIndex" router mode="horizontal" style="border: none;"
               background-color="#545c64" text-color="#fff" active-text-color="#FD0000">
        <el-menu-item :index="item.path" v-for="item in menulist" :key="item.id"
                      style="color: black;text-align: center">
          <el-row>
            <el-col>
              <i :class="item.icon" style="color: black;"></i>
            </el-col>
            <el-col style="position: relative;top: -30px;">
              {{ item.authName }}
            </el-col>
          </el-row>
        </el-menu-item>
      </el-menu>
      <div style="position: absolute;right: 160px;top: 20px;text-align: center;">

        <span v-if="islogin" style="position: absolute;right: 130px;top: 2px">
              <el-button type="text" style="color: rgb(48 176 143)" @click="openChatBot">
                  <i class="el-icon-cpu"></i>
                  <p style="font-size: 14px;margin-top: 2px;">拾柒助手</p>
                </el-button>
        </span>

        <el-popover
            placement="bottom"
            width="400"
            v-if="this.islogin"
            trigger="hover">
          <el-tabs :stretch="true" v-model="tabName">
            <el-tab-pane label="评论回复" name="comment">
              <div v-if="this.unreadCommentList.length != 0">
                <el-card shadow="hover" v-for="(item,index) in unreadCommentList" :key="index" style="margin-top: 3px;"
                         body-style="padding:6px 2px 6px 2px">
                  <div @click="openComment(item.comment)">
                    <el-row>
                      <el-col :span="3">
                        <el-avatar
                            :src="baseUrl+item.comment.sysUser.avatar"
                            shape="square" style="vertical-align: middle;">
                        </el-avatar>
                      </el-col>
                      <el-col :span="21">
                        <span style="font-size: 16px;">{{ item.comment.sysUser.nickName }}</span>
                        <p style="line-height: 0;font-size: 14px;color: #606266">
                          {{ item.comment.commentText| ellipsis }}
                        </p>
                      </el-col>
                    </el-row>
                  </div>
                </el-card>
              </div>
              <p v-else style="text-align: center;margin: 0">
                暂无评论~
              </p>
            </el-tab-pane>
            <el-tab-pane label="你的私信" name="message">
              <div v-if="this.chatMesHistoryList.length != 0">
                <el-card shadow="hover" v-for="(item,index) in chatMesHistoryList" :key="index" style="margin-top: 3px;"
                         body-style="padding:6px 2px 6px 2px">
                  <div @click="openSMS(item.sysUser)">
                    <el-row>
                      <el-col :span="3">
                        <el-avatar
                            :src="baseUrl+item.sysUser.avatar"
                            shape="square" style="vertical-align: middle;">
                        </el-avatar>
                      </el-col>
                      <el-col :span="21">
                        <span style="font-size: 16px;">{{ item.sysUser.nickName }}</span>
                        <p style="line-height: 0;font-size: 14px;color: #606266">
                          {{ item.content | ellipsis }}
                        </p>
                      </el-col>
                    </el-row>
                  </div>
                </el-card>
              </div>
              <p v-else style="text-align: center;margin: 0">
                暂无私信~
              </p>
              <el-button @click="mesAllClose()" type="warning" plain size="small" round
                         style="float: left;margin-top: 5px" v-show="this.chatMesHistoryList!=0">
                一键已读
              </el-button>
              <el-button @click="openIM()" type="primary" plain size="small" round style="float: right;margin-top: 5px">
                查看全部私信
              </el-button>
            </el-tab-pane>
          </el-tabs>
          <el-badge :value="chatMesHistoryList.length+unreadCommentList.length"
                    :hidden="(this.chatMesHistoryList.length+this.unreadCommentList.length) == 0"
                    style="margin-right: 20px" slot="reference">
            <el-button type="text" style="color: rgb(48 176 143);">
              <i class="el-icon-chat-line-round"></i>
              <p style="font-size: 14px;margin-top: 3px;">消息</p>
            </el-button>
          </el-badge>
        </el-popover>

        <el-dropdown placement="bottom">
          <span class="el-dropdown-link">
              <el-badge is-dot hidden>
                <el-button type="text" style="color: rgb(48 176 143)">
                  <i class="el-icon-time"></i>
                  <p style="font-size: 14px;margin-top: 2px;">最近阅读</p>
                </el-button>
             </el-badge>
          </span>
          <el-dropdown-menu slot="dropdown" class="dropdownMenu">
            <el-dropdown-item disabled>
              <p style="text-align: center;margin: 0">
                {{ this.islogin ? "只保存24小时内的浏览历史" : "登录查看吧~" }}
              </p>
            </el-dropdown-item>
            <el-dropdown-item v-for="(o, index) in booksHistoryList" @click.native="jump(2,o)" :key="index">
              <el-card shadow="hover">
                <el-row>
                  <el-col :span="12">
                    <el-image
                        style="width: 60px;height:80px;border-radius: 4px"
                        fit="cover"
                        :src="baseUrl+o.bookCover"></el-image>
                  </el-col>
                  <el-col :span="12">
                    <div>
                      <h3>{{ o.bookName }}</h3>
                    </div>
                  </el-col>
                </el-row>
              </el-card>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
    <div v-if="islogin" class="bg-purple" style="position: relative;top: 10px">
      <el-dropdown class="avatar-container right-menu-item hover-effect" trigger="click">
        <div class="avatar-wrapper">
          <el-avatar class="user-avatar" :src="avatar" @error="errorHandler">
            <i class="el-icon-s-custom"/>
          </el-avatar>
          <p class="avatar-Name">{{ nickName | ellipsisName }}</p>
        </div>
        <el-dropdown-menu slot="dropdown">
          <router-link target="_blank" to="/index">
            <el-dropdown-item>创作中心</el-dropdown-item>
          </router-link>
          <router-link target="_blank" to="/cms/main/cmsMine">
            <el-dropdown-item>我的地盘</el-dropdown-item>
          </router-link>
          <el-dropdown-item divided @click.native="logout">
            <span>退出登录</span>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
    <div v-else class="bg-purple">
      <div class="avatar-wrapper">
        <el-row>
          <el-col style="position: relative;top: 20px">
            <i class="el-icon-user"/>
          </el-col>
          <el-col style="position: relative; right: 46px;top: 15px;">
            <p class="avatar-Name" @click="tologin">登录|注册</p>
          </el-col>
        </el-row>
      </div>
    </div>

    <el-dialog
        title="回复评论"
        :visible.sync="centerDialogVisible"
        width="30%"
        center>
      <span style="font-size: 18px;line-height: 38px">{{ this.comment.sysUser.nickName }} 评论你：<span
          style="color: #3A71A8">{{ this.comment.commentText }}</span></span>
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="发表评论">
          <el-input type="textarea" v-model="form.commentText"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button style="float: right" type="primary" @click="onSubmit">发表</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <el-dialog
        title="拾柒助手"
        :visible.sync="dialogVisible"
        width="80%"
        center>
      <div v-html="content" style="height: 320px;overflow: auto " id="QAContent"></div>
      <div style="height: 130px"
           v-loading="chatLoading"
           element-loading-text="拾柒助手思考中~">
        <textarea v-model="text" style="height: 100px; width: 100%; padding: 20px; border: 1px solid #ccc;outline: none"
                  @keyup.enter="send" placeholder="Enter 发送"></textarea>
        <div style="text-align: right">
          <el-button type="primary" size="mini" @click="send">发送</el-button>
        </div>
      </div>
    </el-dialog>

  </el-header>
</template>

<script>
import {
  mapGetters
} from 'vuex'
import {
  getToken
} from '@/utils/auth'
import 'element-ui/lib/theme-chalk/display.css'
import {listHistory} from "../../api/bookM/books";
import cmsIM from "./components/cmsIM";
import {getInfo} from "../../api/login";
import {chatMesAllClose, chatMesClose, chatMesHistory, chatBot} from "../../api/chat/chat";
import {addComment, readComment, unreadComment} from "../../api/comment/comment";
import {computerIp} from "../../config.js"

let socketMain;
export default {
  name: 'cmsNavBar',
  filters: {
    ellipsis(value) {
      if (!value) return ''
      if (value.length > 26) {
        return value.slice(0, 26) + '...'
      }
      return value
    },
    ellipsisName(value) {
      if (!value) return ''
      if (value.length > 10) {
        return value.slice(0, 10) + '...'
      }
      return value
    }
  },
  data() {
    return {
      tabName: 'comment',
      activeIndex: 'this.$router.path',
      islogin: false,
      menuHiddenVisiable: false,
      centerDialogVisible: false,
      searchInput: true,
      dialogVisible: false,
      chatLoading: false,
      headerBottom: 0,
      queryInfo: {
        query: '',
        timer: null
      },
      form: {
        commentText: ''
      },
      searchList: [],
      searching: false,
      menulist: [{
        id: 0,
        authName: '首页',
        path: '/cms/main/cmsIndex',
        icon: 'el-icon-monitor',
      }, {
        id: 1,
        authName: '社区广场',
        path: '/cms/main/cmsBBS',
        icon: 'el-icon-guide',
      },],
      baseUrl: process.env.VUE_APP_BASE_API,
      booksHistoryList: [],
      chatMesHistoryList: [],
      unreadCommentList: [],
      commentList: [],
      userId: "",
      content: "",
      text: "",
      user: {
        userId: ''
      },
      comment: {
        sysUser: {}
      },
      users: [],
      chatUser: {
        userId: '',
        nickName: '',
        avatar: ''
      }
    };
  },
  computed: {
    ...mapGetters([
      'avatar',
      'nickName'
    ]),
  },
  components: {cmsIM},
  created() {
    this.login();
    this.initUserInfo();
    this.getChatMesHistory();
    this.getHistory()
  },
  methods: {
    openChatBot() {
      this.dialogVisible = true
      setTimeout(() => {
        this.createContent(1, null, "我是你的助手，你可以问我一些问题。比如：推荐几本书或者写一首诗等等！")
      }, 500)
    },
    linkify(text) {
      const urlRegex = /http?:\/\/[^\s]+/g
      return text.replace(urlRegex, url => `<a href="${url}" target="_blank">${url}</a>`)
    },
    send() {
      this.chatLoading = true
      const data = {
        userinput: this.text
      }
      chatBot(data).then(res => {
        this.chatLoading = false
        const item = this.linkify(res.msg)
        this.createContent(1, null, item)
      })
      // 构建消息内容，本人消息
      this.createContent(null, this.user.userId, this.text)
      this.text = '';
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
            "   <el-avatar style=\"object-fit: cover;\">拾柒</el-avatar>\n" +
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
    onSubmit() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.comBodyId = this.comment.comBodyId
          this.form.comBodyType = this.comment.comBodyType
          this.form.commentParentId = this.comment.commentId
          addComment(this.form).then(res => {
            this.form.commentText = null
            this.centerDialogVisible = false
            this.$message.success("感谢您的反馈")
            readComment(this.form.commentParentId).then(res => {
              this.getChatMesHistory()
            })
          })
        }
      });
    },
    openSMS(user) {
      this.$router.push({
        path: "/cms/main/cmsIM",
        query: {
          userId: user.userId,
          nickName: user.nickName,
          avatar: user.avatar
        }
      });
      chatMesClose(user.userId).then(res => {
        this.getChatMesHistory()
      })
    },
    openIM() {
      this.$router.push({
        path: "/cms/main/cmsIM"
      });
    },
    initUserInfo() {
      getInfo().then(res => {
        this.user = res.user
        this.init()
      })
    },
    init() {
      let userId = this.user.userId;
      let _this = this;
      if (typeof (WebSocket) == "undefined") {
        this.$message({type: 'error', message: "您的浏览器暂不支持该功能！"})
      } else {
        // let socketUrl = "ws://localhost:8080/websocket/" + userId;
        let socketUrl = "ws://" + computerIp + ":8080/websocket/" + userId;
        if (socketMain != null) {
          socketMain.close();
          socketMain = null;
        }
        // 开启一个websocket服务
        socketMain = new WebSocket(socketUrl);
        //打开事件
        socketMain.onopen = function () {
          console.log("websocket已打开");
        };
        //  浏览器端收消息，获得从服务端发送过来的文本消息
        socketMain.onmessage = function (msg) {
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
            let not = _this.$notify({
              title: '收到了一条私信！',
              message: data.text,
              duration: 0,
              iconClass: "el-icon-message",
              offset: 100,
              onClick() {
                let user = {
                  userId: data.from
                }
                not.close()
                _this.openSMS(user)
              },
            });
          }
        };
      }
    },
    mesAllClose() {
      chatMesAllClose().then(res => {
        this.$message({type: 'warning', message: "已一键已读，若要回复，请点击【查看全部私信】按钮"})
        this.getChatMesHistory()
      })
    },
    jump(type, parm) {
      switch (type) {
          //幻灯片
        case 1:
          if (parm.pptType === 1) {
            let routeUrl = this.$router.resolve({
              path: '/cms/main/cmsDetail',
              query: parm
            })
            window.open(routeUrl.href, '_blank')
          }
          if (parm.pptType === 2 || parm.pptType === 3) {
            window.open(parm.pptUrl, '_blank');
          }
          break
        case 2:
          let routeUrl = this.$router.resolve({
            path: '/cms/main/cmsDetail',
            query: {
              pptUrl: parm.bookId
            }
          })
          window.open(routeUrl.href, '_blank')
          break
      }
    },
    openComment(comment) {
      this.comment = comment
      this.centerDialogVisible = true
    },
    getHistory() {
      let token = getToken();
      if (token != null) {
        listHistory().then(res => {
          this.booksHistoryList = res.rows
        })
      }
    },
    getChatMesHistory() {
      let token = getToken();
      if (token != null) {
        chatMesHistory().then(res => {
          this.chatMesHistoryList = res.rows
        })
        unreadComment().then(res => {
          this.unreadCommentList = res.data
        })
      }
    },
    menulistAdd() {
      //push()方法一般是添加到数组的最后的位置；unshift()方法是往最前面的位置添加。
      // this.menulist.push({id:"",authName:""})
      this.menulist.unshift({
        id: "",
        authName: ""
      })
    },
    notSearching() {
      setTimeout(() => {
        this.searching = false
      }, 100)
    },
    checkInput() {
      this.searching = this.queryInfo.query !== '';
    },
    tologin() {
      this.$router.push({
        path: "/cmsLogin"
      });
    },
    login() {
      let token = getToken();
      if (token == null || token == '') {
        this.islogin = false;
      } else {
        this.islogin = true;
      }
    },
    errorHandler() {
      return true
    },

    async logout() {
      this.$confirm('确定注销并退出登录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$store.dispatch('LogOut').then(() => {
          location.href = '/cms/main/cmsIndex';
        })
      }).catch(() => {
      });
    }
  }
}
</script>

<style scoped>
.el-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  transition: .2s;
}

.el-header:hover {
  opacity: 1 !important;
}

.el-menu {
  flex-shrink: 0;
  background-color: rgba(0, 0, 0, 0) !important;
}

.el-menu /deep/ .el-menu-item {
  height: 70px;
  background-color: rgba(0, 0, 0, 0) !important;
}


.el-menu /deep/ .el-menu-item i {
  color: rgba(255, 255, 255);
}

.el-menu /deep/ .el-menu-item:hover i {
  color: white;
}

.el-menu /deep/ .el-menu-item:hover {
  background-color: rgba(48, 176, 143, 0.5) !important;
}


.bg-purple-light {
  float: right;
}

.bg-purple {
  float: right;
}

.user-avatar {
  float: left;
  cursor: pointer;
  border: dashed rgba($
  color: #ffff7f, $
  alpha: 0.5);
}

.avatar-container {
  margin-right: 30px;
}

.avatar-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.avatar-Name {
  margin-left: 10px;
  cursor: pointer;
  float: right;
  font-size: 14px;
  color: #000000;
}

.logo {
  float: left;
  margin-left: 50px;
  margin-top: 46px;
  color: #000000;
  font-size: 42px;
  font-weight: bold;
}

.logo:hover {
  cursor: pointer;
}

.el-dropdown-menu.dropdownMenu {
  overflow: scroll;
  max-height: 300px;
  overflow-x: hidden;
}
</style>
