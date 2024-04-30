<template>
  <div>
    <div class="top"></div>
    <div style="padding: 100px 100px;">
      <el-row :gutter="10">
        <div style="width: 500px;margin: 20px auto;">
          <el-input placeholder="请输入书籍名（支持模糊查询）" v-model="queryParames.bookName" clearable @keyup.enter.native="getBooksList">
            <el-button slot="append" icon="el-icon-search" @click="getBooksList"></el-button>
          </el-input>
        </div>
        <el-col :span="20">
          <el-row>
            <el-col :span="12" v-for="(o, index) in booksList" :key="index">
              <el-card class="book" :body-style="{ padding: '20px'}" shadow="hover">
                <el-row>
                  <el-col :span="12">
                    <el-image
                        style="width: 180px;height:200px;border-radius: 4px"
                        fit="cover"
                        :src="baseUrl+o.bookCover"></el-image>
                  </el-col>
                  <el-col :span="12">
                    <div>
                      <h3>{{ o.bookName }}</h3>
                      <p>{{ o.bookWriterName }} 著</p>
                      <p>分类：{{ o.bookType }}</p>
                      <p> 更新时间：{{ o.bookUpDate }}</p>
                      <el-link style="position: relative;top: 10px" @click="jump(2,o)">立即阅读 ></el-link>
                    </div>
                  </el-col>
                </el-row>
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
        <el-button v-if="commentListTotal >= 4" round
                   @click="commentMore"
                   :disabled="this.commentListTotal === this.queryParames.pageSize ? true:false"
        ><i class="el-icon-arrow-down"></i> {{ this.commentListTotal === this.queryParames.pageSize ? "暂无更多" : "更多" }}
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
import {indexBooks, indexPpt} from "../../../api/pub/index";

export default {
  data() {
    return {
      isAds: true,
      baseUrl: process.env.VUE_APP_BASE_API,
      PPTList: [],
      booksList: [],
      queryParames: {
        pageNum: 1,
        pageSize: 4,
        bookName: ""
      },
      commentListTotal: 0,
    }
  },

  created() {
    this.getPPT()
    this.getBooksList()
  },

  methods: {
    commentMore() {
      this.queryParames.pageSize += 4
      indexBooks(this.queryParames).then(response => {
        this.booksList = response.rows
        this.commentListTotal = response.total
      })
    },
    getPPT() {
      let obj = {};
      obj.pptDesc = 1
      indexPpt(obj).then(res => {
        this.PPTList = res.rows
      })
    },
    getBooksList() {
      indexBooks(this.queryParames).then(res => {
        this.booksList = res.rows
        this.commentListTotal = res.total
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
  }

}
</script>

<style scoped>
.el-card.book:hover {
  transform: scale(1.02);
  transition: transform .3s;
}

.top {
  background-image: linear-gradient(to top, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0)),url("../../../assets/images/wallhaven-39qjjd.jpg");
  width: 95%;
  height: 60%;
  position: absolute;
  background-size: cover;
}
</style>
