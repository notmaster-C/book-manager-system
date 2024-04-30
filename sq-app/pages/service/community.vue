<template>
	<view style="margin: 20rpx;">
		<u-search :showAction="true" actionText="搜索" v-model="queryParames.topicName" :animation="true"
			placeholder="请输入想查找的话题" bgColor="#fff" @search="getTopicList" @custom="getTopicList" @clear="getTopicList">
		</u-search>
		<view class="cu-card dynamic" v-for="(item, index) in topicList" :key="index" @click="toTopicDetail(item)">
			<view class="cu-item shadow">
				<view class="cu-list menu-avatar">
					<view class="cu-item">
						<image class="cu-avatar round lg" :src="baseUrl+item.sysUser.avatar" />
						<view class="content flex-sub">
							<view>{{item.sysUser.nickName}}</view>
							<view class="text-gray text-sm flex justify-between">
								{{item.topicCreatedate}}
							</view>
						</view>
					</view>
				</view>

				<view class="text-content text-xxl text-bold" v-show="item.topicCover == null">
					{{item.topicName}}
				</view>

				<view class="bg-img bg-mask flex align-center" v-show="item.topicCover != null"
					:style="'background-image: url('+baseUrl+item.topicCover+');height: 313upx;'">
					<view class="padding-xl text-white">
						<view class="padding-xs text-xxl text-bold">
							{{item.topicName}}
						</view>
					</view>
				</view>

				<view class="text-gray text-sub  padding flex justify-end">
					<u-icon name="chat"></u-icon> {{item.commentNum}}
				</view>
			</view>
		</view>
		<view v-if="!loading">
			<u-empty v-show="topicList.length == 0" mode="search" icon="http://cdn.uviewui.com/uview/empty/search.png">
			</u-empty>
		</view>
		<u-loading-icon mode="circle" text="拼命加载中" size="36" :vertical="true" :show="loading" style="margin-top: 50%;"></u-loading-icon>
		<u-loadmore v-show="topicList.length != 0" :status="status" />
		<u-back-top :scroll-top="scrollTop" top="300"></u-back-top>

	</view>
</template>

<script>
	import {
		listTopic
	} from '@/api/service/public'
	import config from '@/config'
	export default {
		data() {
			return {
				scrollTop: 0,
				status: 'loadmore',
				loading: true,
				listTotal: 0,
				listTotalR: 0,
				topicList: [],
				queryParames: {
					pageNum: 1,
					pageSize: 4,
					topicName: ""
				},
				baseUrl: config.baseUrl,
			}
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		onReachBottom() {
			// 判断还有没有
			if (this.listTotal <= this.listTotalR) {
				this.status = 'nomore';
				return;
			}
			this.status = 'loading';
			this.queryParames.pageNum = ++this.queryParames.pageNum;
			setTimeout(() => {
				listTopic(this.queryParames).then(response => {
					this.topicList = [...this.topicList, ...response.rows]
					this.listTotal = response.total
					this.listTotalR += 4
				})
				// 判断还有没有
				if (this.listTotal == this.listTotalR) this.status = 'nomore';
				else this.status = 'loading';
			}, 500)
		},
		onLoad() {
			this.getTopicList()
		},
		methods: {
			getTopicList() {
				this.loading = true
				listTopic(this.queryParames).then(res => {
					this.topicList = res.rows
					this.listTotal = res.total
					this.listTotalR = 4
					this.loading = false
				})
			},
			toTopicDetail(item) {
				this.$tab.navigateTo('/pages/service/topicDetail?topicId=' + item.topicId)
			},
		}
	}
</script>

<style>

</style>
