<template>
  <div>
    <el-link :underline="false" @click="toZuye(parentData.sysUser.userId)">
      <el-avatar :src="baseUrl+parentData.sysUser.avatar" style="vertical-align: middle;">
      </el-avatar>
      <span style="font-weight:bold;font-size: 20px;margin-left: 10px">{{ parentData.sysUser.nickName }}</span>
    </el-link>
    <span style="font-style: italic;color: #5a5e66;margin-left: 10px"> {{ parentData.createDate }}</span>
    <p style="padding-left: 20px">{{ parentData.isVio == 1 ? parentData.commentText : "该评论涉嫌违规"}}</p>
    <span style="font-style: italic;color: #5a5e66;margin-left: 10px"> IP属地：{{ parentData.sysUser.loginLocation }}</span>
    <div style="display: block;float: right">
      <el-button type="text" @click="huifu(parentData.commentId)" icon="el-icon-chat-dot-round">回复</el-button>
      <el-button type="text" @click="like(parentData)" icon="el-icon-star-on"
                 :style="!flag ? 'color: #5a5e66':'color: #6289ec'">
        {{ parentData.likeNum }}
      </el-button>
    </div>
    <div v-show="comShow">
      <el-input v-model="form.commentText" :placeholder="'回复 '+ parentData.sysUser.nickName">
        <el-button slot="append" icon="el-icon-s-promotion" @click="onSubmit">发布</el-button>
      </el-input>
    </div>
    <el-divider></el-divider>
    <div style="margin-left: 40px">
      <parent v-for="(comment, index) in parentData.children" :key="index" :parentData="comment" v-if="comment"/>
    </div>
  </div>
</template>

<script>
import {addComment, updateComment} from "../../../api/comment/comment";

export default {
  name: "parent",
  props: ["parentData"],
  data() {
    return {
      baseUrl: process.env.VUE_APP_BASE_API,
      flag: false,
      comShow: false,
      form: {
        commentText:''
      }
    }
  },
  inject:["fatherMethod"],
  methods: {
    toZuye(id){
      let routeUrl = this.$router.resolve({
        path: '/cms/main/cmsUserPage',
        query: {
          userID: id
        }
      })
      window.open(routeUrl.href, '_blank')
    },
    onSubmit(){
      this.form.comBodyId = this.parentData.comBodyId
      this.form.comBodyType = this.parentData.comBodyType
      this.form.commentParentId = this.parentData.commentId
      addComment(this.form).then(res => {
        this.fatherMethod()
        this.form.commentText = null
        this.$message.success("感谢您的反馈")
      })
    },
    huifu(i) {
      if (this.comShow) {
        this.comShow = false
      } else {
        this.comShow = true
      }
    },
    like(i) {
      //TODO 这个功能不想搞了，后面搞吧
      if (this.flag) {
        this.parentData.likeNum -= 1
        updateComment(i).then(res => {
          this.flag = false
        })
      } else {
        this.parentData.likeNum += 1
        updateComment(i).then(res => {
          this.flag = true
        })
      }

    }
  }
}
</script>

<style scoped>

</style>
