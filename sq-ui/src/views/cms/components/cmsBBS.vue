<template>
  <div>
    <div class="top"></div>
    <div style="padding: 100px 100px;">
      <el-row :gutter="10">
        <div style="width: 500px;margin: 20px auto;">
          <el-input placeholder="请输入话题（支持模糊查询）" v-model="queryParames.topicName" clearable
                    @keyup.enter.native="getTopicList">
            <el-button slot="append" icon="el-icon-search" @click="getTopicList"
                       :loading="commentMoreLoading"></el-button>
          </el-input>
        </div>
        <el-col :span="20">
          <el-row>
            <el-skeleton :loading="topicLoading" animated :count="4">
              <template slot="template">
                <div style="padding: 14px;">
                  <el-card class="book" :body-style="{ padding: '20px'}" shadow="hover">
                    <el-skeleton-item variant="h1" style="width: 50%;"/>
                    <el-skeleton-item variant="image"
                                      style="width: 180px;height:120px;border-radius: 4px;display: block;margin: 10px auto;"/>
                    <div
                        style="display: flex; align-items: center; justify-items: space-between; margin-top: 16px; height: 16px;"
                    >
                      <el-skeleton-item variant="text" style="margin-right: 16px;"/>
                      <el-skeleton-item variant="text" style="width: 30%;"/>
                    </div>
                  </el-card>
                </div>
              </template>
            </el-skeleton>
            <el-col :span="24" v-for="(o, index) in topicList" :key="index">
              <el-card class="book" :body-style="{ padding: '20px'}" shadow="hover">
                <el-row>
                  <el-link :underline="false" @click="toZuye(o.sysUser.userId)">
                      <span style="font-size: 24px;font-weight: bold;">{{
                          o.sysUser.nickName + '：' + o.topicName
                        }}</span>
                  </el-link>
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
              </el-card>
              <div style="height: 20px"></div>
            </el-col>
            <el-col v-show="topicLoading === false && topicList.length === 0">
              <el-card>
                <el-empty :image-size="200" description=" ">
                  <el-link>
                    <router-link to="/topicByUser">自己发布该话题吧~</router-link>
                  </el-link>
                </el-empty>
              </el-card>
            </el-col>
          </el-row>
        </el-col>
        <el-col :span="4">
          <el-card :body-style="{ padding: '0px' }" v-if="isAds">
            <i class="el-icon-circle-close"
               style="position: absolute;right:10px;top:90px;font-size: 20px;color: red;z-index: 1024"
               @click="isAds = false"
            />
            <el-carousel height="200px" direction="vertical">
              <el-carousel-item v-for="item in PPTList" :key="item.pptId">
                <div @click="jump(1,item)">
                  <el-image :src="baseUrl + item.pptPic"
                            fit="cover"
                            style="width: 100%"
                  />
                  <p style="text-align: center">{{ item.pptName }}</p>
                </div>
              </el-carousel-item>
            </el-carousel>

          </el-card>
        </el-col>
      </el-row>
      <div style="text-align: center;margin: 30px">
        <el-button v-if="topicListTotal >= 4" round
                   @click="commentMore"
                   :loading="commentMoreLoading"
                   :disabled="this.topicListTotal <= this.pageSize"
        ><i class="el-icon-arrow-down"></i> {{
            this.commentMoreLoading === true ? '加载中' : this.topicListTotal <= this.pageSize ? "暂无更多" : "更多"
          }}
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
import {indexPpt} from "../../../api/pub/index";
import {listTopic} from "../../../api/pub/topic/topic";
import MainComment from "../../components/comment/mainComment";
import {addComment} from "../../../api/comment/comment";
import {ListComPub} from "../../../api/pub/detail";

export default {
  components: {MainComment},
  provide() {
    return {
      Id: this.comBodyId,
      fatherMethod: this.getComList
    }
  },
  data() {
    return {
      topicLoading: true,
      isAds: true,
      readActivated: false,
      baseUrl: process.env.VUE_APP_BASE_API,
      PPTList: [],
      topicList: [],
      queryParames: {
        pageNum: 1,
        pageSize: 4,
        topicName: ""
      },
      form: {
        commentText: ''
      },
      commentListTotal: 0,
      topicListTotal: 0,
      pageSize: 0,
      commentList: [],
      comBodyId: '',
      nextTopicCom: '',
      commentMoreLoading: true
    }
  },
  created() {
    this.getTopicList()
    this.getPPT()
  },

  methods: {
    toZuye(id) {
      let routeUrl = this.$router.resolve({
        path: '/cms/main/cmsUserPage',
        query: {
          userID: id
        }
      })
      window.open(routeUrl.href, '_blank')
    },
    showComment(o) {
      if (o.commentShow){
        o.commentShow = false
      }else if(this.nextTopicCom === '') {
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
      this.commentList = []
      const data = {};
      data.comBodyId = id === undefined ? this.comBodyId : id
      data.comBodyType = 2
      ListComPub(data).then(res => {
        this.commentList = res.rows
        this.commentListTotal = res.total
      })
    },
    onSubmit() {
      this.form.comBodyId = this.comBodyId
      this.form.comBodyType = 2
      addComment(this.form).then(res => [
        this.getComList(this.comBodyId),
        this.form.commentText = null,
        this.$message.success("感谢您的反馈")
      ])
    },
    commentMore() {
      this.commentMoreLoading = true
      this.queryParames.pageNum += 1
      listTopic(this.queryParames).then(res => {
        res.rows.map(item => {
          item.readActivated = false
          item.commentShow = false
          this.topicList.push(item)
          this.pageSize++
        })
        this.topicListTotal = res.total
        this.commentMoreLoading = false
      })
    },
    getPPT() {
      let obj = {};
      obj.pptDesc = 1
      indexPpt(obj).then(res => {
        this.PPTList = res.rows
      })
    },
    getTopicList() {
      this.commentMoreLoading = true
      listTopic(this.queryParames).then(res => {
        this.topicListTotal = res.total
        this.topicList = res.rows.map(item => {
          item.readActivated = false
          item.commentShow = false
          return item
        })
        this.topicLoading = false
        this.commentMoreLoading = false
      })
    },
  }

}
</script>

<style scoped>
.el-card.book:hover {
  transform: scale(1.005);
  transition: transform .3s;
}

.top {
  background-image: linear-gradient(to top, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0)),
  url("../../../assets/images/wallhaven-39qjjd.jpg");
  width: 95%;
  height: 60%;
  position: absolute;
  background-size: cover;
}
</style>
