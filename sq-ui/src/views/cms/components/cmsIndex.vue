<template>
  <div style="margin-left: 80px;margin-right: 80px">
    <el-row :gutter="40" style="padding-left: 15%">
      <el-col :span="14">
        <el-carousel :interval="4000" type="card" height="200px">
          <el-carousel-item v-for="item in PPTList" :key="item.pptId" :label="item.pptName">
            <el-tooltip class="item" effect="dark" :content="item.pptName" placement="right">
              <el-image :src="baseUrl+item.pptPic" @click="jump(1,item)"></el-image>
            </el-tooltip>
          </el-carousel-item>
        </el-carousel>
      </el-col>
      <el-col :span="10">
        <h1>实 时 最 热 榜 单
          <el-tooltip class="item" effect="dark" content="实 时 更 新 榜 单" placement="bottom">
            <i class="el-icon-info" style="font-size: 18px"></i>
          </el-tooltip>
        </h1>
        <div v-for="(item,index) in hotRank" :key="index" style="height: 30px;">
          <el-link :underline="false" @click="jump(2,item)">
            <span>{{ (index + 1) + ". " + item.bookName }}
                    <el-badge value="热" v-show="index<3">
                      <i class="el-icon-trophy" style="color: red;"></i>
                    </el-badge>
                  </span>
          </el-link>
        </div>
      </el-col>
    </el-row>
    <el-divider></el-divider>

    <h1><i class="el-icon-s-opportunity" style="color:rgb(48, 176, 143)"></i> 拾柒推荐</h1>
    <el-row :gutter="20">
      <el-skeleton animated :loading="booksRecLoading">
        <template slot="template">
          <el-col :span="8" v-for="o in 3">
            <el-card :body-style="{ padding: '0px'}" shadow="hover">
              <el-row>
                <el-col :span="12">
                  <el-skeleton-item variant="image"
                                    style="width: 180px;height:200px;border-radius: 4px"/>
                </el-col>
                <el-col :span="12">
                  <div style="padding-top: 20px;line-height: 35px;width: 80%">
                    <el-skeleton-item variant="h1"/>
                    <el-skeleton-item variant="text"/>
                    <el-skeleton-item variant="text"/>
                    <el-skeleton-item variant="text"/>
                    <el-skeleton-item variant="text" style="width: 30%;"/>
                  </div>
                </el-col>
              </el-row>
            </el-card>
          </el-col>
        </template>
      </el-skeleton>
      <el-col :span="8" v-for="(o, index) in booksRecList" :key="index">
        <el-card :body-style="{ padding: '0px'}" shadow="hover">
          <div @click="jump(2,o)">
            <el-row>
              <el-col :span="12">
                <el-image
                    style="width: 180px;height:200px;border-radius: 4px"
                    fit="cover"
                    :src="baseUrl+o.bookCover"></el-image>
              </el-col>
              <el-col :span="12">
                <div>
                  <el-tooltip class="item" effect="dark" :content="o.bookName" placement="top">
                    <h3>{{ o.bookName | ellipsis }}</h3>
                  </el-tooltip>
                  <p>{{ o.bookWriterName }} 著</p>
                  <p>分类：{{ o.bookType }}</p>
                  <p> 更新时间：{{ o.bookUpDate }}</p>
                  <el-link style="position: relative;top: 10px">立即阅读 ></el-link>
                </div>
              </el-col>
            </el-row>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-divider></el-divider>
    <el-row>
      <el-col :span="14">
        <h1><i class="el-icon-s-management" style="color:rgb(48,176,143)"></i> 拾柒书库</h1>
      </el-col>
      <el-col :span="9">
        <router-link to="/cms/main/cmsBookList">
          <el-link style="margin-top: 10px"><h1>更多>>></h1></el-link>
        </router-link>
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :span="16">
        <el-row>
          <el-skeleton animated :loading="booksDBLoading">
            <template slot="template">
              <el-col :span="12" v-for="o in 4">
                <el-card :body-style="{ padding: '0px'}" shadow="hover">
                  <el-row>
                    <el-col :span="12">
                      <el-skeleton-item variant="image"
                                        style="width: 180px;height:200px;border-radius: 4px"/>
                    </el-col>
                    <el-col :span="12">
                      <div style="padding-top: 20px;line-height: 35px;width: 80%">
                        <el-skeleton-item variant="h1"/>
                        <el-skeleton-item variant="text"/>
                        <el-skeleton-item variant="text"/>
                        <el-skeleton-item variant="text"/>
                        <el-skeleton-item variant="text" style="width: 30%;"/>
                      </div>
                    </el-col>
                  </el-row>
                </el-card>
              </el-col>
            </template>
          </el-skeleton>
          <el-col :span="12" v-for="(o, index) in booksList" :key="index">
            <el-card :body-style="{ padding: '0px'}" shadow="hover">
              <div @click="jump(2,o)">
                <el-row>
                  <el-col :span="12">
                    <el-image
                        style="width: 180px;height:200px;border-radius: 4px"
                        fit="cover"
                        :src="baseUrl+o.bookCover"></el-image>
                  </el-col>
                  <el-col :span="12">
                    <div>
                      <el-tooltip class="item" effect="dark" :content="o.bookName" placement="top">
                        <h3>{{ o.bookName | ellipsis }}</h3>
                      </el-tooltip>
                      <p>{{ o.bookWriterName }} 著</p>
                      <p>分类：{{ o.bookType }}</p>
                      <p> 更新时间：{{ o.bookUpDate }}</p>
                      <el-link style="position: relative;top: 10px">立即阅读 ></el-link>
                    </div>
                  </el-col>
                </el-row>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </el-col>
      <el-col :span="8">
        <h1>拾柒书库阅读总榜</h1>
        <el-skeleton animated :loading="booksRankLoading" :count="3"/>
        <div v-for="(item,index) in readAllRankList" :key="item.bookId" style="height: 30px;">
          <div v-show="index === 0">
            <el-badge value="NO.1">
              <el-card :body-style="{ padding: '0px'}" shadow="hover">
                <div @click="jump(2,item)">
                  <el-row>
                    <el-col :span="10">
                      <el-image
                          style="width: 120px;height:160px;border-radius: 4px"
                          fit="cover"
                          :src="baseUrl+item.bookCover"></el-image>
                    </el-col>
                    <el-col :span="14">
                      <div style="width: 200px">
                        <el-tooltip class="item" effect="dark" :content="item.bookName" placement="top">
                          <h3>{{ item.bookName | ellipsis }}</h3>
                        </el-tooltip>
                        <p>{{ item.bookWriterName }} 著</p>
                        <p>分类：{{ item.bookType }}</p>
                        <el-link>立即阅读 ></el-link>
                      </div>
                    </el-col>
                  </el-row>
                </div>
              </el-card>
            </el-badge>
          </div>
          <div v-show="index>0" style="position: relative;top: 160px;font-size: 18px;">
            <el-link @click="jump(2,item)">
              NO.{{ index + 1 }} {{ item.bookName }} <i v-show="index<=2" class="el-icon-trophy"
                                                        style="color: red;"></i></el-link>
          </div>
        </div>
      </el-col>
    </el-row>

    <el-divider></el-divider>
    <h1><i class="el-icon-star-on" style="color:rgb(48,176,143)"></i> 猜你喜欢
      <el-button type="text" @click="getGYWL" icon="el-icon-refresh">换一批</el-button>
    </h1>
    <el-row :gutter="20">
      <el-skeleton animated :loading="booksGYWLLoading">
        <template slot="template">
          <el-col :span="8" v-for="o in 3">
            <el-card :body-style="{ padding: '0px'}" shadow="hover">
              <el-row>
                <el-col :span="12">
                  <el-skeleton-item variant="image"
                                    style="width: 180px;height:200px;border-radius: 4px"/>
                </el-col>
                <el-col :span="12">
                  <div style="padding-top: 20px;line-height: 35px;width: 80%">
                    <el-skeleton-item variant="h1"/>
                    <el-skeleton-item variant="text"/>
                    <el-skeleton-item variant="text"/>
                    <el-skeleton-item variant="text"/>
                    <el-skeleton-item variant="text" style="width: 30%;"/>
                  </div>
                </el-col>
              </el-row>
            </el-card>
          </el-col>
        </template>
      </el-skeleton>
      <el-col :span="8" v-for="(o, index) in booksGYWLList" :key="index">
        <el-card :body-style="{ padding: '0px'}" shadow="hover">
          <div @click="jump(2,o)">
            <el-row>
              <el-col :span="12">
                <el-image
                    style="width: 180px;height:200px;border-radius: 4px"
                    fit="cover"
                    :src="baseUrl+o.bookCover"></el-image>
              </el-col>
              <el-col :span="12">
                <div>
                  <el-tooltip class="item" effect="dark" :content="o.bookName" placement="top">
                    <h3>{{ o.bookName | ellipsis }}</h3>
                  </el-tooltip>
                  <p>{{ o.bookWriterName }} 著</p>
                  <p>分类：{{ o.bookType }}</p>
                  <p> 更新时间：{{ o.bookUpDate }}</p>
                  <el-link style="position: relative;top: 10px">立即阅读 ></el-link>
                </div>
              </el-col>
            </el-row>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-divider></el-divider>
    <h1><i class="el-icon-s-flag" style="color:rgb(48,176,143)"></i> 关于爱阅读</h1>
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card shadow="hover">
          <el-row>
            <el-col :span="6">
              <i class="el-icon-mobile-phone" style="font-size: 60px;margin-top: 50px"></i>
            </el-col>
            <el-col :span="18">
              <div>
                <h3>拾柒爱阅读小程序</h3>
                <p>最走心的阅读产品</p>
                <p style="font-size: 12px"><em>关注我们：
                  <el-link href="https://space.bilibili.com/457574535?spm_id_from=333.788.0.0"
                           style="padding-right:5px ">哔哩哔哩
                  </el-link>
                  <el-link href="https://gitee.com/cxq21">Gitee</el-link>
                </em></p>
                <el-tooltip effect="dark" placement="top">
                  <div slot="content" style="margin: 10px;text-align: center">
                    <h3>打开微信扫一扫 <br>
                      即刻体验移动端</h3>
                    <div ref="qrCodeUrl"></div>
                  </div>
                  <el-link style="color: #30B08F">点我 ></el-link>
                </el-tooltip>
              </div>
            </el-col>
          </el-row>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="hover">
          <el-row>
            <el-col :span="6">
              <i class="el-icon-edit-outline" style="font-size: 60px;margin-top: 50px"></i>
            </el-col>
            <el-col :span="18">
              <div>
                <h3>创作中心</h3>
                <p>原创、自媒体、内容商、漫画、图书</p>
                <p style="font-size: 12px"><em>招募作者，福利优厚</em></p>
                <router-link target="_blank" to="/index">
                  <el-link style="color: #30B08F">投稿 ></el-link>
                </router-link>

              </div>
            </el-col>
          </el-row>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="hover">
          <el-row>
            <el-col :span="6">
              <i class="el-icon-chat-dot-round" style="font-size: 60px;margin-top: 50px"></i>
            </el-col>
            <el-col :span="18">
              <div>
                <h3>QQ交流群</h3>
                <p>欢迎反馈宝贵意见给我们</p>
                <p style="font-size: 12px"><em>QQ群：870299711</em></p>
                <el-link href="https://jq.qq.com/?_wv=1027&k=qzPRU17T" style="color: #30B08F">加入 ></el-link>
              </div>
            </el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>

  </div>
</template>

<script>
import {GYWLike, hotRank, indexBooks, indexPpt, readAllRank, readRec} from "../../../api/pub/index";
import QRCode from 'qrcodejs2'
import {computerIp} from "../../../config.js"

export default {
  name: "cmsIndex",

  data() {
    return {
      baseUrl: process.env.VUE_APP_BASE_API,
      PPTList: [],
      booksList: [],
      booksRecList: [],
      booksGYWLList: [],
      readAllRankList: [],
      hotRank: [],
      //  拾柒书库加载
      booksDBLoading: true,
      //阅读榜
      booksRankLoading: true,
      // 猜你喜欢
      booksGYWLLoading: true,
      //推荐
      booksRecLoading: true
    };
  },
  created() {
    this.getPPT()
    this.getHR()
    this.getRecBooksList()

    this.getBooksList()
    this.getRank()
    this.getGYWL()
  },
  mounted() {
    this.$nextTick(function () {
      this.creatQrCode();
    })
  },
  filters: {
    ellipsis(value) {
      if (!value) return ''
      if (value.length > 9) {
        return value.slice(0, 9) + '...'
      }
      return value
    }
  },
  methods: {
    creatQrCode() {
      var qrcode = new QRCode(this.$refs.qrCodeUrl, {
        text: computerIp + ':81/#/pages/index', // 需要转换为二维码的内容
        width: 120,
        height: 120,
        colorDark: '#000000',
        colorLight: '#ffffff',
        correctLevel: QRCode.CorrectLevel.H
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
      let obj = {};
      obj.pageNum = 1
      obj.pageSize = 4
      indexBooks(obj).then(res => {
        this.booksList = res.rows
        this.booksDBLoading = false
      })
    },
    getRecBooksList() {
      readRec().then(res => {
        this.booksRecList = res.rows
        this.booksRecLoading = false
      })
    },
    getGYWL() {
      GYWLike().then(res => {
        this.booksGYWLList = res.rows
        this.booksGYWLLoading = false
      })
    },
    getHR() {
      hotRank().then(res => {
        this.hotRank = res.rows
      })
    },
    getRank() {
      readAllRank().then(res => {
        this.readAllRankList = res.rows
        this.booksRankLoading = false
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
    }
  }
};
</script>

<style scoped>
#sector {
  width: 100%;
  height: 100px;
  margin: 0 auto;
}
</style>
