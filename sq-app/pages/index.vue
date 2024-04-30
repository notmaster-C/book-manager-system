<template>
	<!-- #ifndef APP-NVUE || MP-TOUTIAO -->
	<view class="u-demo-block">
		<u-swiper :list="PPTList" keyName="pptPic" previousMargin="30" nextMargin="30" circular :autoplay="true"
			radius="5" bgColor="#ffffff" @click="toDetail" showTitle></u-swiper>
		<view style="margin: 20rpx;" class="bg-white margin-top-xs ">
			<view class="cu-bar bg-white margin-top-xs ">
				<view class="action sub-title u-skeleton-rect">
					<text class="text-xl text-bold text-red text-shadow cuIcon-titles">拾柒推荐</text>
					<text class="text-ABC text-red">Shiqirecommend</text>
				</view>
			</view>
			<u-scroll-list>
				<view class="scroll-list" style="flex-direction: row;">
					<view class="scroll-list__goods-item" v-for="(item, index) in booksRecList" :key="index"
					@click="toBookDetail(item.bookId)"
						:class="[(index === 9) && 'scroll-list__goods-item--no-margin-right']">
						<image class="scroll-list__goods-item__image" :src="baseUrl+item.bookCover"></image>
						<text class="scroll-list__goods-item__text">《{{item.bookName}}》</text>
					</view>
					<!-- <view class="scroll-list__show-more" @click="recommendMore">
						<text class="scroll-list__show-more__text">查看更多</text>
						<u-icon name="arrow-leftward" color="#f56c6c" size="12"></u-icon>
					</view> -->
				</view>
			</u-scroll-list>

			<view class="cu-bar bg-white margin-top-xs ">
				<view class="action sub-title u-skeleton-rect">
					<text class="text-xl text-bold text-red text-shadow cuIcon-titles">拾柒书库</text>
					<text class="text-ABC text-red">Shiqistack</text>
				</view>
				<view class="action" @click="recommendMore">
					<text class="cuIcon-right text-shadow text-black">更多</text>
				</view>
			</view>

			<view class="cu-card case" v-for="(item, index) in booksList" :key="index" @click="toBookDetail(item.bookId)">
				<view class="cu-item shadow" >
					<view class="image">
						<image :src="baseUrl+item.bookCover" mode="widthFix">
						</image>
						<view class="cu-tag bg-red"
							v-if="(item.rankParm.readNum*0.2+item.rankParm.applaudNum*0.6+item.rankParm.commentNum*0.2)>= 10">热
						</view>
						<view class="cu-tag bg-red"
							v-else-if="(item.rankParm.applaudNum)>= 5">赞
						</view>
						<view class="cu-tag bg-red"
							v-else-if="(item.rankParm.commentNum)>= 5">评
						</view>
						<view class="cu-tag bg-red"
							v-else-if="(item.rankParm.readNum)>= 20">阅
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
			<u-loading-icon mode="circle" text="拼命加载中" size="36" :vertical="true" :show="loading" style="margin-top: 50%;"></u-loading-icon>	
			<u-loadmore :status="status" />
			<u-back-top :scroll-top="scrollTop" top="300"></u-back-top>
		</view>
		<u-gap height="40"></u-gap>
	</view>
	<!-- #endif -->
</template>

<script>
	import {
		getPpt,
		hotRank,
		BooksList
	} from '@/api/service/public'
	import config from '@/config'
	export default {
		data() {
			return {
				scrollTop: 0,

				status: 'loadmore',
				listTotal: 0,
				listTotalR: 0,
				
				loading: true,
				
				PPTList: [],
				booksRecList: [],
				queryParames: {
					pageNum: 1,
					pageSize: 4,
					bookName: ""
				},
				baseUrl: config.baseUrl,
				booksList: [],

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
			this.getPPT()
			this.getRecList()
			this.getBooksList()
		},
		methods: {
			getPPT() {
				let obj = {};
				obj.pptDesc = 1
				getPpt(obj).then(res => {
					this.PPTList = JSON.parse(JSON.stringify(res.rows).replace(/pptName/g, "title"))
					this.PPTList.map(item => {
						return item.pptPic = this.baseUrl + item.pptPic
					})
				})
			},
			getBooksList() {
				this.loading = true
				BooksList(this.queryParames).then(res => {
					this.booksList = res.rows
					this.listTotal = res.total
					this.listTotalR = 4
					this.loading = false
				})
			},
			getRecList() {
				hotRank().then(res => {
					this.booksRecList = res.rows
				})
			},
			recommendMore() {
				this.$tab.navigateTo('/pages/service/bookList')
			},
			toBookDetail(bookId){
				this.$tab.navigateTo('/pages/service/bookDetail?bookId='+bookId)
			},
			toDetail(e) {
				if (this.PPTList[e].pptType === 1) {
					 this.$tab.navigateTo('/pages/service/bookDetail?bookId='+this.PPTList[e].pptUrl)
				}
				if (this.PPTList[e].pptType === 2 || this.PPTList[e].pptType === 3) {
					this.$tab.navigateTo(
						`/pages/common/webview/index?title=${this.PPTList[e].title}&url=${this.PPTList[e].pptUrl}`)
				}

			}
		}
	}
</script>

<style lang="scss">
	.u-page__text-item {
		margin-right: 10px;
		flex: 1;
	}

	.u-demo-block__content {
		@include flex;
		flex-direction: row;
		flex-wrap: wrap;
		align-items: center;
	}

	.scroll-list {
		@include flex(column);

		&__goods-item {
			margin-right: 20px;

			&__image {
				width: 120px;
				height: 140px;
				border-radius: 10px;
			}

			&__text {
				color: #000000;
				text-align: center;
				font-size: small;
				margin-top: 5px;
			}
		}

		&__show-more {
			background-color: #fff0f0;
			border-radius: 3px;
			padding: 3px 6px;
			@include flex(column);
			align-items: center;

			&__text {
				font-size: 16px;
				width: 12px;
				color: #f56c6c;
				line-height: 34px;
			}
		}
	}
</style>
