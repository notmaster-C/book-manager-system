<template>
	<view style="margin: 20rpx;">
		<view class="cu-card case" v-for="(item, index) in booksList" :key="index" @click="toBookDetail(item.bookId)">
			<view class="cu-item shadow">
				<view class="image">
					<image :src="baseUrl+item.bookCover" mode="widthFix">
					</image>
					<view class="cu-bar bg-shadeBottom">
						<text class="text-cut">类型：{{item.bookType}}</text>
						<view>出版社：{{item.bookPress}}</view>
					</view>
				</view>
				<view class="cu-list menu-avatar">
					<view class="cu-item">
						<view class="text-grey">《{{item.bookName}}》</view>
						<view class="text-gray  flex justify-between">
							<text class="text-black">作者:{{item.bookWriterName}}</text>
						</view>
					</view>
				</view>
			</view>
		</view>
		<u-empty
				v-show="booksList.length == 0"
		        mode="search"
		        icon="http://cdn.uviewui.com/uview/empty/search.png"
		>
		</u-empty>
		<u-loadmore v-show="booksList.length != 0" :status="status" />
		<u-back-top :scroll-top="scrollTop" top="300"></u-back-top>
		
	</view>
</template>

<script>
	import {
		listHistory
	} from '@/api/service/private'
	import config from '@/config'
	export default {
		data() {
			return {
				queryParames: {
					pageNum: 1,
					pageSize: 4,
					bookName: ""
				},
				scrollTop: 0,
				status: 'loadmore',
				listTotal: 0,
				listTotalR: 0,
				baseUrl: config.baseUrl,
				booksList: []
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
				listHistory(this.queryParames).then(response => {
					this.booksList = [...this.booksList, ...response.rows]
					this.listTotal = response.total
					this.listTotalR += 4
				})
				// 判断还有没有
				if (this.listTotal == this.listTotalR) this.status = 'nomore';
				else this.status = 'loading';
			}, 100)
		},
		onLoad() {
			this.getBookList()
		},
		methods: {
			getBookList() {
				listHistory(this.queryParames).then(res => {
					this.booksList = res.rows
					this.listTotal = res.total
					this.listTotalR = 4
				})
			},
			toBookDetail(bookId) {
				this.$tab.navigateTo('/pages/service/bookDetail?bookId=' + bookId)
			},
		}
	}
</script>

<style>
	page {
		background-color: #fff;
	}
</style>
