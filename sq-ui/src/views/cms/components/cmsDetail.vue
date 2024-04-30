<template>
  <div style="padding: 0 100px">

    <el-row>
      <el-col :span="20" style="padding: 0 40px">
        <div style="float: left;padding-right: 30px">
          <el-image :src="baseUrl+detail.bookCover" style="width: 180px;height: 250px" fit="cover"></el-image>
        </div>
        <div>
          <el-tooltip effect="dark"
                      :content="detail.bookName"
                      placement="top-start">
            <p style="font-weight: bold;font-size: 28px">{{ detail.bookName | ellipsis }}</p>
          </el-tooltip>
          <p style="color: #5a5e66;font-size: 20px">{{ detail.bookWriterName }} 著 <i>{{ detail.bookPress }} 出版</i></p>
          <p style="font-style: italic;color: #5a5e66">分类： {{ detail.bookType }}</p>
          <p style="font-style: italic;color: #5a5e66">发布于： {{ detail.bookPubDate }}</p>
          <p style="font-style: italic;color: #5a5e66">最近更新： {{ detail.bookUpDate }}</p>
        </div>
        <div style="position: absolute;top:10px;right: 25%">
          <el-button type="danger" round @click="read">立即阅读</el-button>
          <el-button type="danger" plain round v-if="collectShow" @click="collect">加入书架</el-button>
          <el-button type="danger" plain round v-else @click="collect">取消加入书架</el-button>
          <el-tooltip class="item" effect="dark">
            <div slot="content" style="margin: 10px;text-align: center">
              <h3>打开微信扫一扫 <br>
                即刻体验移动端</h3>
              <div ref="qrCodeUrl"></div>
            </div>
            <el-link style="color: #30B08F;margin-left: 10px"><i class="el-icon-mobile"></i>移动端阅读</el-link>
          </el-tooltip>
          <i class="el-icon-star-off" v-show="starShow"
             style="font-size: 30px;position: relative;top: 5px;right: -10px;color: grey" @click="star(1)"></i>
          <i class="el-icon-star-on" v-show="!starShow"
             style="font-size: 30px;position: relative;top: 5px;right: -10px;color: #ff0000" @click="star(0)"></i>
        </div>
        <el-divider></el-divider>
        <div>
          <i style="font-size: 20px; color: red" class="el-icon-chat-dot-round"><span style="color: black"
          > 评论</span></i>
          <el-divider></el-divider>
          <el-form ref="form" :model="form" label-width="80px">
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

        </div>
      </el-col>
      <el-col :span="4">
        <el-card :body-style="{ padding: '0px' }" v-if="isAds">
          <i class="el-icon-circle-close"
             style="position: absolute;right:10px;top:5px;font-size: 20px;color: red;z-index: 1024"
             @click="isAds = false"
          />
          <el-carousel height="200px" direction="vertical">
            <el-carousel-item v-for="item in PPTList" :key="item.pptId">
              <div @click="jump(1,item)">
                <el-image :src="baseUrl + item.pptPic"
                          fit="cover"
                          style="width: 100%"
                />
                <p style="padding-left: 5px">{{ item.pptName }}</p>
              </div>
            </el-carousel-item>
          </el-carousel>

        </el-card>
        <el-divider></el-divider>
        <el-card :body-style="{ padding: '0px' }">
          <div style="padding: 14px;">
            <el-image :src="this.baseUrl+writerInfo.writerPic"
                      style="border-radius: 100px;width: 100px;display: block;margin: 0 auto;"></el-image>
            <div style="text-align: center">
              <h3>{{ this.writerInfo.writerName }}</h3>
              <p>{{ this.writerInfo.writerIntro }}</p>
            </div>
            <el-divider></el-divider>
            <h3>作者其他作品</h3>
            <el-tooltip v-for="item in writerOtherBooks" :key="item.newsId" class="item" effect="dark"
                        :content="item.bookName"
                        placement="left-start"
            >
              <div @click="toDetail(item)">
                <el-card shadow="hover">
                  {{ item.bookName | ellipsis }}
                </el-card>
              </div>
            </el-tooltip>
          </div>
        </el-card>
      </el-col>
    </el-row>

  </div>
</template>

<script>
import {addRankParm, getDetail, getWriterInfo, ListBook, ListComPub} from "../../../api/pub/detail";
import {indexPpt} from "../../../api/pub/index";
import {addApplaud, delApplaud, listApplaud} from "../../../api/applaud/applaud";
import {getToken} from "../../../utils/auth";
import {addCollect, delCollect, listCollect} from "../../../api/collect/collect";
import MainComment from "../../components/comment/mainComment";
import {addComment} from "../../../api/comment/comment";
import QRCode from 'qrcodejs2'
import {computerIp} from "../../../config.js"

export default {
  components: {MainComment},
  filters: {
    ellipsis(value) {
      if (!value) return ''
      if (value.length > 9) {
        return value.slice(0, 9) + '...'
      }
      return value
    }
  },
  provide() {
    return {
      fatherMethod: this.getComList
    }
  },
  data() {
    return {
      isAds: true,
      starShow: true,
      collectShow: true,
      starYesShow: false,
      commentListTotal: 0,
      baseUrl: process.env.VUE_APP_BASE_API,
      detail: {},
      writerInfo: {},
      form: {
        commentText: ''
      },
      writerOtherBooks: [],
      PPTList: [],
      commentList: [],
      queryParames: {
        newsFormBoxer: null,
        pageNum: 1,
        pageSize: 4
      },
      queryCommentParames: {
        pageNum: 1,
        pageSize: 5,
      }
    }
  },

  created() {
    this.getDetailInfo()
    this.getPPT()
    this.getComList()
  },
  mounted() {
    this.$nextTick(function () {
      this.creatQrCode();
    })
  },

  methods: {
    creatQrCode() {
      var qrcode = new QRCode(this.$refs.qrCodeUrl, {
        text: computerIp + ':81/#/pages/service/bookDetail?bookId=' + this.$route.query.pptUrl, // 需要转换为二维码的内容
        width: 120,
        height: 120,
        colorDark: '#000000',
        colorLight: '#ffffff',
        correctLevel: QRCode.CorrectLevel.H
      })
    },
    getComList() {
      const data = {};
      data.comBodyId = this.$route.query.pptUrl
      data.comBodyType = 1
      ListComPub(data).then(res => {
        this.commentList = res.rows
        this.commentListTotal = res.total
      })
    },
    star(type) {
      if (type === 1) {
        const data = {
          bookId: this.$route.query.pptUrl
        };
        addApplaud(data).then(res => {
          this.$message.success("已喜欢")
          this.starShow = false
        })
      } else {
        delApplaud(this.$route.query.pptUrl).then(res => {
          this.$message.warning("取消喜欢")
          this.starShow = true
        })
      }
    },
    collect() {
      if (this.collectShow) {
        const data = {
          bookId: this.$route.query.pptUrl
        };
        addCollect(data).then(res => {
          this.$message.success("已加入")
          this.collectShow = false
        })
      } else {
        delCollect(this.$route.query.pptUrl).then(res => {
          this.$message.warning("取消加入")
          this.collectShow = true
        })
      }
    },
    read() {
      const data = {};
      data.readNum = 1
      data.bookId = this.detail.bookId
      addRankParm(data).then(res => {
        window.open(this.baseUrl + this.detail.bookPdfUrl, '_blank')
      })
    },
    getPPT() {
      let obj = {};
      obj.pptDesc = 1
      indexPpt(obj).then(res => {
        this.PPTList = res.rows
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

      }
    },
    getDetailInfo() {
      getDetail(this.$route.query.pptUrl).then(res => {
        this.detail = res.data
        var obj = {}
        obj.bookWriterName = this.detail.bookWriterName
        obj.writerName = this.detail.bookWriterName
        getWriterInfo(obj).then(res => {
          this.writerInfo = res.rows[0]
        })
        ListBook(obj).then(res => {
          this.writerOtherBooks = res.rows
        })
        let token = getToken();
        if (token != null) {
          const applaud = {
            bookId: this.$route.query.pptUrl
          }
          listApplaud(applaud).then(res => {
            if (res.total == 1) this.starShow = false
          })
          listCollect(applaud).then(res => {
            if (res.total == 1) this.collectShow = false
          })
        }
      })
    },
    toDetail(parm) {
      let routeUrl = this.$router.resolve({
        path: '/cms/main/cmsDetail',
        query: {
          pptUrl: parm.bookId
        }
      })
      window.open(routeUrl.href, '_blank')
    },
    onSubmit() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.comBodyId = this.$route.query.pptUrl
          this.form.comBodyType = 1
          addComment(this.form).then(res => [
            this.getComList(),
            this.form.commentText = null,
            this.$message.success("感谢您的反馈")
          ])
        }
      });
    },
  }

}
</script>

<style scoped>

</style>
