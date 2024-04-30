<template>
	<view style="margin: 20rpx;">
		<u-search :showAction="true" actionText="搜索" v-model="queryParames.bookName" :animation="true"
			placeholder="请输入想查找的书籍名" @search="getBookList" @custom="getBookList" @clear="getBookList">
		</u-search>
		<view class="cu-card case" v-for="(item, index) in booksList" :key="index" @click="toBookDetail(item.bookId)">
			<view class="cu-item shadow">
				<view class="image">
					<image :src="baseUrl+item.bookCover" mode="widthFix">
					</image>
					<view class="cu-tag bg-red"
						v-if="(item.rankParm.readNum*0.2+item.rankParm.applaudNum*0.6+item.rankParm.commentNum*0.2)>= 10">
						热
					</view>
					<view class="cu-tag bg-red" v-else-if="(item.rankParm.applaudNum)>= 5">赞
					</view>
					<view class="cu-tag bg-red" v-else-if="(item.rankParm.commentNum)>= 5">评
					</view>
					<view class="cu-tag bg-red" v-else-if="(item.rankParm.readNum)>= 20">阅
					</view>
					<view class="cu-bar bg-shadeBottom">
						<text class="text-cut">类型：{{item.bookType}}</text>
						<view>出版社：{{item.bookPress}}</view>
					</view>
				</view>
				<view class="cu-list menu-avatar">
					<view class="cu-item">
						<image class="cu-avatar round lg" :src="baseUrl+item.writer.writerPic" />
						<view class="content flex-sub">
							<view class="text-grey">《{{item.bookName}}》</view>
							<view class="text-gray text-sm flex justify-between">
								<text class="text-black">作者:{{item.bookWriterName}}</text>
								<view class="text-gray text-lg flex justify-between">
									<u-icon name="eye"></u-icon> {{item.rankParm.readNum || 0}}
									<u-icon name="heart"></u-icon> {{item.rankParm.applaudNum || 0}}
									<u-icon name="chat"></u-icon> {{item.rankParm.commentNum || 0}}
								</view>
							</view>
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
		BooksList
	} from '@/api/service/public'
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
				BooksList(this.queryParames).then(response => {
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
				BooksList(this.queryParames).then(res => {
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
