<template>
	<view class="u-content">
		<u--text :text="topicDetailInfo.topicName" size="22" bold v-show="topicDetailInfo.topicCover == null"></u--text>
		<view class="bg-img padding-bottom-xl" v-show="topicDetailInfo.topicCover != null"
			:style="'background-image: url('+baseUrl+ topicDetailInfo.topicCover+');height: 207upx;'">
			<view class="bg-shadeTop padding padding-bottom-xl text-xl text-bold">
				{{topicDetailInfo.topicName}}
			</view>
		</view>
		<u-divider :dot="true"></u-divider>
		<u-row>
			<u-col span="2">
				<u-avatar :src="baseUrl+ topicDetailInfo.sysUser.avatar" shape="square"></u-avatar>
			</u-col>
			<u-col span="8">
				<u--text :text="topicDetailInfo.sysUser.nickName" bold></u--text>
				<u--text :text="'发布于:'+topicDetailInfo.topicCreatedate" color="#8f9ca2"></u--text>
			</u-col>
			<u-col span="2" v-show="this.readPerson.userId != topicDetailInfo.sysUser.userId">
				<u-button type="error" text="私信"  @click="openIM(topicDetailInfo.sysUser)"></u-button>
			</u-col>
		</u-row>
		<u-gap height="20" bgColor="#fff"></u-gap>
		<u-parse :content="topicDetailInfo.topicContent"></u-parse>
		
		<u-divider :dot="true"></u-divider>
		
		<u--text prefixIcon="chat" iconStyle="font-size: 22px" text="评论"></u--text>
		<u--form labelPosition="left" :model="comment">
			<u-form-item label="" prop="commentText" borderBottom>
				<u--textarea v-model="comment.commentText" placeholder="评论千万条,友善第一条" confirmType="done">
				</u--textarea>
			</u-form-item>
			<u-button @tap="submitComment()" shape="circle" text="发 表" type="success"
				v-show="comment.commentText != ''">
			</u-button>
		</u--form>
		
		<u-gap height="20" bgColor="#fff"></u-gap>
		
		<view class="cu-list menu-avatar comment solids-top" v-for="(item ,index) in commentList" :key="index">
			<view class="cu-tag bg-red " v-show="item.likeNum >= 5">热评
			</view>
			<view class="cu-item">
				<view class="cu-avatar round" :style="{'background-image': 'url('+baseUrl+item.sysUser.avatar+')'}">
				</view>
				<view class="content">
					
					<view class="text-grey">{{item.sysUser.nickName}}</view>
					<view class="text-gray text-content text-df">
						{{item.commentText}}
					</view>
					
					<view class="bg-grey padding-sm radius margin-top-sm  text-sm"
						v-for="(itemChildren,indexChildren) in item.children" :key="indexChildren">
						<view class="flex">
							<view>{{itemChildren.sysUser.nickName}}：</view>
							<view class="flex-sub">{{itemChildren.commentText}}</view>
						</view>
					</view>
		
					<view class="margin-top-sm flex justify-between">
						<view class="text-gray text-df">{{item.createDate}}</view>
						<view>
							<view class="text-gray text-df">
								<u--text prefixIcon="chat" iconStyle="color:#3c9cff" type="primary" text="回复"
									@click="openCommentModel(item)">
								</u--text>
							</view>
						</view>
					</view>
		
					<u--form labelPosition="left" :model="commentForm" v-show="item.commentShow">
						<u-form-item label="" prop="commentText" borderBottom>
							<u--textarea v-model="commentForm.commentText" placeholder="评论千万条,友善第一条" confirmType="done">
							</u--textarea>
						</u-form-item>
						<u-button @tap="submitCommentFrom(item)" shape="circle" text="回 复" type="success"
							v-show="commentForm.commentText != ''">
						</u-button>
					</u--form>
		
				</view>
			</view>
		</view>
		
		<u-empty mode="comment" icon="http://cdn.uviewui.com/uview/empty/comment.png"
			v-show="commentList.length == 0">
		</u-empty>
		
		<u-gap height="10"></u-gap>
		<u-back-top :scroll-top="scrollTop" top="300"></u-back-top>
	</view>
</template>

<script>
	import {
		listTopic,
		comment,
		listComment
	} from '@/api/service/public'
	import {getUserProfile} from '@/api/system/user.js'
	import config from '@/config'
	export default {
		data() {
			return {
				scrollTop: 0,
				
				topicDetailInfo: {},
				baseUrl: config.baseUrl,
				comment: {
					comBodyId: '',
					comBodyType: 2,
					commentText: ''
				},
				commentForm: {
					comBodyId: '',
					comBodyType: 2,
					commentText: ''
				},
				readPerson:{},
				commentList: [],
			}
		},
		onLoad: function(option) {
			this.getTopic(option.topicId)
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		methods: {
			openIM(item) {
				this.$tab.navigateTo('/pages/service/IM?userId=' + item.userId + '&nickName=' + item.nickName +
					'&fromId=' + this.readPerson.userId +
					'&avatar=' + item.avatar)
			},
			getTopic(id) {
				let queryParames = {
					topicId: id
				}
				listTopic(queryParames).then(res => {
					this.topicDetailInfo = res.rows[0]
				})
				getUserProfile().then(res=>{
					this.readPerson = res.data
				})
				let parms = {
					comBodyId: id,
					comBodyType: 2
				}
				listComment(parms).then(res => {
					this.commentList = res.rows.map(item => {
						item.commentShow = false
						return item
					})
				})
			},
			openCommentModel(o){
				this.commentList = this.commentList.map(item => {
					item.commentShow = false
					return item
				})
				o.commentShow = !o.commentShow
			},
			submitComment() {
				this.comment.comBodyId = this.topicDetailInfo.topicId
				comment(this.comment).then(res => {
					this.comment.commentText = ''
					this.$modal.showToast('谢谢评论~')
					let parms = {
						comBodyId: this.comment.comBodyId,
						comBodyType: 2
					}
					listComment(parms).then(res => {
						this.commentList = res.rows
					})
				})
			},
			submitCommentFrom(item){
				this.commentForm.comBodyId = item.comBodyId
				this.commentForm.commentParentId = item.commentId
				comment(this.commentForm).then(res => {
					this.commentForm.commentText = ''
					this.$modal.showToast('谢谢评论~')
					let parms = {
						comBodyId: this.commentForm.comBodyId,
						comBodyType: 2
					}
					listComment(parms).then(res => {
						this.commentList = res.rows
					})
				})
			},
		}
	}
</script>

<style lang="scss" scoped>
	.u-content {
		padding: 24rpx;
		background-color: #fff;
	}
</style>
