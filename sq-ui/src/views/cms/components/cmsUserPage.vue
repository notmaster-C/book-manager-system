<template>
  <div style="padding: 0 200px">
    <el-card class="box-card">
      <el-card style="margin-bottom: 5px;">
        <el-row>
          <el-col :span="5">
            <el-image
                style="width: 160px;height:160px;border-radius: 4px"
                fit="cover"
                :src="baseUrl+this.user.avatar">
              <el-avatar shape="square" :size="160" slot="error" class="image-slot"><span style="font-size: 50px"> {{
                  this.user.nickName
                }}</span>
              </el-avatar>
            </el-image>
          </el-col>
          <el-col :span="19">
            <span style="display: block; font-weight: bold;font-size: 40px">{{ this.user.nickName }}</span>
            <span style="font-size: 20px;padding-right: 10px">{{ this.user.email }}</span>
            <i :class="this.user.sex != 1 ? 'el-icon-male' :'el-icon-female'"
               :style="this.user.sex != 1 ? 'color:blue' :'color:red'"></i>
            <div
                style="float: right;">
              <div style="font-size: 14px;line-height: 30px">IP属地：{{
                  this.user.loginLocation
                }}
              </div>
              <el-button v-show="loading" icon="el-icon-message" plain @click="openSMS">发私信</el-button>
            </div>

            <h3 style="display: block;padding-top: 20px">为了阅读的价值 ~</h3>
            <el-divider content-position="right">拾柒爱阅读</el-divider>
          </el-col>
        </el-row>
      </el-card>
      <el-tabs type="border-card" @tab-click="tabClick">
        <el-tab-pane label="动态">
          <el-row :gutter="10">
            <div style="width: 500px;margin: 20px auto;">
              <el-input placeholder="请输入话题（支持模糊查询）" v-model="queryParames.topicName" clearable
                        @keyup.enter.native="getTopicList">
                <el-button slot="append" icon="el-icon-search" @click="getTopicList"></el-button>
              </el-input>
            </div>
            <el-col :span="24" v-for="(o, index) in topicList" :key="index">
              <el-card class="book" :body-style="{ padding: '20px'}" shadow="hover">
                <el-skeleton :loading="topicLoading" animated>
                  <template slot="template">
                    <div style="padding: 14px;">
                      <el-skeleton-item variant="h1" style="width: 50%;"/>
                      <el-skeleton-item variant="image"
                                        style="width: 180px;height:120px;border-radius: 4px;display: block;margin: 10px auto;"/>
                      <div
                          style="display: flex; align-items: center; justify-items: space-between; margin-top: 16px; height: 16px;"
                      >
                        <el-skeleton-item variant="text" style="margin-right: 16px;"/>
                        <el-skeleton-item variant="text" style="width: 30%;"/>
                      </div>
                    </div>
                  </template>
                  <el-row>
                    <span style="font-size: 24px;font-weight: bold;">{{ o.sysUser.nickName + '：' + o.topicName }}</span>
                  </el-row>
                  <el-image
                      v-if="o.topicCover != null"
                      style="width: 180px;height:120px;border-radius: 4px;display: block;margin: 10px auto;"
                      fit="cover"
                      :src="baseUrl+o.topicCover"></el-image>
                  <div class="ql-editor" v-if="!o.readActivated" v-html="o.topicContent.slice(0,100)"/>
                  <div class="ql-editor" v-if="o.readActivated" v-html="o.topicContent"/>
                  <span v-if="o.readActivated" style="font-style:italic;color: grey">发布于 {{ o.topicCreatedate }}</span>
                  <div style="display: block; text-align: center;">
                    <el-link v-if="!o.readActivated" :underline="false" @click="o.readActivated = !o.readActivated">阅读全文
                      <i
                          class="el-icon-arrow-down"></i></el-link>
                    <el-link v-if="o.readActivated" :underline="false" @click="o.readActivated = !o.readActivated">收起 <i
                        class="el-icon-arrow-up"></i></el-link>
                  </div>

                  <el-link :underline="false" @click="showComment(o)"><i class="el-icon-chat-dot-round"></i>
                    {{ o.commentNum }} 条评论 <span
                        style="padding-left: 20px;font-style:italic;color: grey">{{ o.topicCreatedate }}</span>
                  </el-link>
                  <div v-if="o.commentShow">
                    <el-divider></el-divider>
                    <el-form :model="form" label-width="80px">
                      <el-form-item label="发表评论">
                        <el-input type="textarea" v-model="form.commentText"></el-input>
                      </el-form-item>
                      <el-form-item>
                        <el-button type="primary" @click="onSubmit">发表</el-button>
                      </el-form-item>
                    </el-form>
                    <el-divider></el-divider>
                    <MainComment v-for="(comment, index) in commentList" :key="index" :commentData="comment"/>
                    <p style="padding-left: 20px" v-if="commentListTotal === 0">暂无评论</p>
                    <div style="display: block; text-align: center;">
                      <el-link v-if="o.commentShow" :underline="false" @click="o.commentShow = !o.commentShow">收起评论 <i
                          class="el-icon-arrow-up"></i></el-link>
                    </div>
                  </div>
                </el-skeleton>
              </el-card>
              <div style="height: 20px"></div>
            </el-col>
            <el-col v-show="topicList.length === 0">
              <el-card>
                <el-empty :image-size="200" description=" ">
                  <el-link>
                    <router-link to="/topicByUser">自己发布该话题吧~</router-link>
                  </el-link>
                </el-empty>
              </el-card>
            </el-col>
          </el-row>
          <div style="text-align: center;margin: 30px">
            <el-button v-if="commentListTotal >= 4" round
                       @click="commentMore"
                       :disabled="this.commentListTotal <= this.queryParames.pageSize ? true:false"
            ><i class="el-icon-arrow-down"></i> {{
                this.commentListTotal <= this.queryParames.pageSize ? "暂无更多" : "更多"
              }}
            </el-button>
          </div>
        </el-tab-pane>
        <el-tab-pane label="书架">
          <el-empty :image-size="200" v-if="collectBooksList.length == 0" description=" ">
            <el-link>
              <router-link to="/cms/main/cmsIndex">快去添加书籍吧~</router-link>
            </el-link>
          </el-empty>
          <el-card v-else shadow="hover" v-for="(o, index) in collectBooksList">
            <el-row>
              <el-col :span="6">
                <el-image
                    style="width: 180px;height:200px;border-radius: 4px"
                    fit="cover"
                    :src="baseUrl+o.bookCover"></el-image>
              </el-col>
              <el-col :span="16">
                <div>
                  <h3>{{ o.bookName }}</h3>
                  <p>{{ o.bookWriterName }} 著</p>
                  <p>分类：{{ o.bookType }}</p>
                  <p> 更新时间：{{ o.bookUpDate }}</p>
                  <div style="position: absolute;right: 100px;top:70px;transform:rotate(-35deg); color: #a1f3cf">
                    <i class="el-icon-circle-plus"></i> ：{{ o.createDate }}
                  </div>
                  <el-link style="position: relative;top: 10px" @click="jump(2,o)">立即阅读 ></el-link>
                </div>
              </el-col>
            </el-row>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="喜欢">
          <el-empty :image-size="200" v-if="booksList.length == 0" description=" ">
            <el-link>
              <router-link to="/cms/main/cmsIndex">快去添加喜欢吧~</router-link>
            </el-link>
          </el-empty>
          <el-card v-else shadow="hover" v-for="(o, index) in booksList">
            <el-row>
              <el-col :span="6">
                <el-image
                    style="width: 180px;height:200px;border-radius: 4px"
                    fit="cover"
                    :src="baseUrl+o.bookCover"></el-image>
              </el-col>
              <el-col :span="16">
                <div>
                  <h3>{{ o.bookName }}</h3>
                  <p>{{ o.bookWriterName }} 著</p>
                  <p>分类：{{ o.bookType }}</p>
                  <p> 更新时间：{{ o.bookUpDate }}</p>
                  <div class="likeTime"
                       style="position: absolute;right: 100px;top:70px;transform:rotate(-35deg); color: pink">
                    ❤：{{ o.creadData }}
                  </div>
                  <el-link style="position: relative;top: 10px" @click="jump(2,o)">立即阅读 ></el-link>
                </div>
              </el-col>
            </el-row>
          </el-card>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import {getUser} from "../../../api/system/user";
import {listAndBookInfo} from "../../../api/collect/collect";
import {listApplaudAndBookInfo} from "../../../api/applaud/applaud";
import MainComment from "../../components/comment/mainComment";
import cmsIM from "./cmsIM";
import {ListComPub} from "../../../api/pub/detail";
import {addComment} from "../../../api/comment/comment";
import {listTopic} from "../../../api/pub/topic/topic";
import {listMine} from "../../../api/topic/topic";

export default {
  name: "cmsUserPage",
  components: {MainComment, cmsIM},
  provide() {
    return {
      fatherMethod: this.getComList
    }
  },
  data() {
    return {
      topicLoading: true,
      loading: false,
      readActivated: false,
      IMVisible: false,
      user: {},
      baseUrl: process.env.VUE_APP_BASE_API,
      booksList: [],
      collectBooksList: [],
      id: this.$route.query.userID,
      topicList: [],
      queryParames: {
        pageNum: 1,
        pageSize: 4,
        topicName: "",
        userId: this.$route.query.userID,
      },
      form: {},
      commentListTotal: 0,
      commentList: [],
      comBodyId: '',
      nextTopicCom: ''
    };
  },
  created() {
    this.getUser();
  },
  methods: {
    openSMS() {
      console.log(this.user)
      this.$router.push({
        path: "/cms/main/cmsIM",
        query: {
          userId: this.user.userId,
          nickName: this.user.nickName,
          avatar: this.user.avatar
        }
      });
    },
    setLoading() {
      this.topicLoading = true
      setTimeout(() => (this.topicLoading = false), 1200)
    },
    showComment(o) {
      if (this.nextTopicCom === '') {
        this.comBodyId = o.topicId
        this.getComList(this.comBodyId)
        o.commentShow = true
        this.nextTopicCom = o.topicId
      } else {
        this.topicList = this.topicList.map(res => {
          if (res.topicId === this.nextTopicCom) {
            res.commentShow = false
            o.commentShow = true
            this.nextTopicCom = o.topicId
            this.comBodyId = o.topicId
            this.getComList(this.comBodyId)
          }
          return res
        })
      }
    },
    getComList(id) {
      const data = {};
      data.comBodyId = id
      data.comBodyType = 2
      ListComPub(data).then(res => {
        this.commentList = res.rows
        this.commentListTotal = res.total
      })
    },
    onSubmit() {
      console.log(this.form)
      this.form.comBodyId = this.comBodyId
      this.form.comBodyType = 2
      addComment(this.form).then(res => [
        this.getComList(this.comBodyId),
        this.$message.success("感谢您的反馈")
      ])
    },
    commentMore() {
      this.setLoading()
      this.queryParames.pageSize += 4
      listMine(this.queryParames).then(res => {
        this.topicList = res.rows.map(item => {
          item.readActivated = false
          item.commentShow = false
          return item
        })
        this.commentListTotal = res.total
      })
    },
    getTopicList() {
      this.setLoading()
      listTopic(this.queryParames).then(res => {
        this.topicList = res.rows.map(item => {
          item.readActivated = false
          item.commentShow = false
          return item
        })
        this.commentListTotal = res.total
      })
    },
    getUser() {
      getUser(this.id).then(response => {
        this.user = response.data;
        this.loading = true
        this.getTopicList();
      });
    },
    tabClick(tab) {
      let qm = {
        userId: this.user.userId
      }
      switch (tab.index) {
        case '0' :
          break
        case '1':
          listAndBookInfo(qm).then(res => {
            this.collectBooksList = res.rows
          })
          break
        case '2':
          listApplaudAndBookInfo(qm).then(res => {
            this.booksList = res.rows
          })
          break
      }
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
    }
  }
}
</script>

<style scoped>

</style>
