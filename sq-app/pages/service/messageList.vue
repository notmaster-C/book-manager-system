<template>
	<view>
		<view class="cu-list menu-avatar">
			<view class="cu-item" v-for="(item,index) in list" :key="index" @click="openIM(item)">
				<view class="cu-avatar radius lg" :style="'background-image:url('+baseUrl+item.avatar+')'">
				</view>
				<view class="content">
					<view>{{item.nickName}}</view>
					<view class="text-gray text-sm flex">
						<view class="text-cut">
							<text class="cuIcon-infofill text-red  margin-right-xs text-cut"></text>
							{{item.content}}
						</view>
					</view>
				</view>
				<view>
					<view class="text-grey text-xs">{{item.time}}</view>
					<!-- <view class="cu-tag round bg-grey sm">5</view> -->
				</view>
			</view>
		</view>
		<u-empty v-if="list.length == 0" mode="message" icon="http://cdn.uviewui.com/uview/empty/message.png">
		</u-empty>
		<u-gap height="50"></u-gap>
		<view style="padding: 20rpx;">
			<u-row>
				<u-col span="4">
					<u--text prefixIcon="heart" iconStyle="font-size: 22px" text="猜你喜欢"></u--text>
				</u-col>
				<u-col span="8">
					<u--text type="primary" prefixIcon="attach" iconStyle="font-size: 22px;color:#3c9cff" text="换一个"
						@click="getGYWLike"></u--text>
				</u-col>
			</u-row>
			
			<view class="cu-card case" @click="toBookDetail(GYWLikeBook.bookId)">
				<view class="cu-item shadow">
					<view class="image">
						<image :src="baseUrl+GYWLikeBook.bookCover" mode="widthFix">
						</image>
						<view class="cu-bar bg-shadeBottom">
							<text class="text-cut">类型：{{GYWLikeBook.bookType}}</text>
							<view>出版社：{{GYWLikeBook.bookPress}}</view>
						</view>
					</view>
					<view class="cu-list menu-avatar">
						<view class="cu-item">
							<view class="content flex-sub">
								<view class="text-grey">《{{GYWLikeBook.bookName}}》 <text
										class="text-black">作者:{{GYWLikeBook.bookWriterName}}</text></view>
							</view>
						</view>
					</view>
				</view>
			</view>
		</view>
		<u-gap height="10"></u-gap>
		
	</view>
</template>

<script>
	import {
		chatList
	} from '@/api/service/private'
	import {
		GYWLike
	} from '@/api/service/public'
	import config from '@/config'
	export default {
		data() {
			return {
				list: [],
				baseUrl: config.baseUrl,
				GYWLikeBook: {}
			}
		},
		onLoad() {
			this.getChatList()
			this.getGYWLike()
		},
		methods: {
			getChatList() {
				chatList().then(res => {
					this.list = res.data
				})
			},
			openIM(item) {
				this.$tab.navigateTo('/pages/service/IM?userId=' + item.userId + '&nickName=' + item.nickName +
					'&fromId=' + item.fromId +
					'&avatar=' + item.avatar)
			},
			toBookDetail(bookId) {
				this.$tab.navigateTo('/pages/service/bookDetail?bookId=' + bookId)
			},
			getGYWLike() {
				GYWLike().then(res => {
					this.GYWLikeBook = res.rows[0]
				})
			},
		}
	}
</script>

<style>

</style>
