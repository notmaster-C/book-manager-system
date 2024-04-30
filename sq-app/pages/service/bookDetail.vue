<template>
	<view style="margin: 30rpx;">
		<u-skeleton rows="4" titleHeight="40" avatar avatarSize="140" avatarShape="square" title :loading="loading">
			<u-row>
				<u-col span="5">
					<u--image :showLoading="true" :src="baseUrl+bookDetail.bookCover" width="130px" height="180px"
						mode="heightFix">
					</u--image>
				</u-col>
				<u-col span="7">
					<view>
						<u--text :text="bookDetail.bookName" size="20" lines="2" bold></u--text>
					</view>
					<view style="margin-top: 60rpx; line-height: 50rpx;">
						<p>{{bookDetail.bookWriterName}} 著 {{bookDetail.bookPress}} 出版</p>
						<p>分类：{{bookDetail.bookType}}</p>
						<p>发布于：{{bookDetail.bookPubDate}}</p>
						<p>最近更新：{{bookDetail.bookUpDate}}</p>
					</view>
				</u-col>
			</u-row>
			<u-divider></u-divider>
			<u-button type="primary" shape="circle" text="立即阅读" @click="openBook(bookDetail.bookPdfUrl)"></u-button>
			<u-divider></u-divider>

			<u--text prefixIcon="file-text" iconStyle="font-size: 22px" text="作者相关书籍"></u--text>
			<u-divider></u-divider>
			<u-scroll-list>
				<view class="scroll-list" style="flex-direction: row;">
					<view class="scroll-list__goods-item" v-for="(item, index) in booksList" :key="index"
						@click="toBookDetail(item.bookId)"
						:class="[(index === 9) && 'scroll-list__goods-item--no-margin-right']">
						<image class="scroll-list__goods-item__image" :src="baseUrl+item.bookCover"></image>
						<text class="scroll-list__goods-item__text">《{{item.bookName}}》</text>
					</view>
				</view>
			</u-scroll-list>

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
								<u--textarea v-model="commentForm.commentText" placeholder="评论千万条,友善第一条"
									confirmType="done">
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
			<u-divider></u-divider>

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
			<u-gap height="10"></u-gap>
		</u-skeleton>
		<template>
			<u-skeleton rows="8" titleHeight="40" title :loading="loading"></u-skeleton>
		</template>

		<u-back-top :scroll-top="scrollTop" top="300"></u-back-top>
	</view>
</template>

<script>
	import {
		bookInfo,
		rankParm,
		comment,
		BooksList,
		listComment,
		GYWLike
	} from '@/api/service/public'
	import config, {
		baseUrl
	} from '@/config'
	export default {
		data() {
			return {
				scrollTop: 0,

				bookDetail: {},
				comment: {
					comBodyId: '',
					comBodyType: 1,
					commentText: ''
				},
				commentForm: {
					comBodyId: '',
					comBodyType: 1,
					commentText: ''
				},
				loading: true,
				baseUrl: config.baseUrl,
				commentList: [],
				booksList: [],
				GYWLikeBook: {},

			}
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		onLoad: function(option) {
			this.getBookInfo(option.bookId);
			this.getGYWLike();
		},
		methods: {
			getBookInfo(bookId) {
				bookInfo(bookId).then(res => {
					this.bookDetail = res.data
					let queryParames = {
						bookWriterName: this.bookDetail.bookWriterName,
						writerName: this.bookDetail.bookWriterName
					}
					BooksList(queryParames).then(res => {
						this.booksList = res.rows
					})
					uni.$u.sleep(1000).then(() => {
						this.loading = false
					})
				})
				let parms = {
					comBodyId: bookId,
					comBodyType: 1
				}
				listComment(parms).then(res => {
					this.commentList = res.rows.map(item => {
						item.commentShow = false
						return item
					})
				})
			},
			openCommentModel(o) {
				this.commentList = this.commentList.map(item => {
					item.commentShow = false
					return item
				})
				o.commentShow = !o.commentShow
			},
			getGYWLike() {
				GYWLike().then(res => {
					this.GYWLikeBook = res.rows[0]
				})
			},
			submitComment() {
				this.comment.comBodyId = this.bookDetail.bookId
				comment(this.comment).then(res => {
					this.comment.commentText = ''
					this.$modal.showToast('谢谢评论~')
					let parms = {
						comBodyId: this.comment.comBodyId,
						comBodyType: 1
					}
					listComment(parms).then(res => {
						this.commentList = res.rows
					})
				})
			},
			submitCommentFrom(item) {
				this.commentForm.comBodyId = item.comBodyId
				this.commentForm.commentParentId = item.commentId
				comment(this.commentForm).then(res => {
					this.commentForm.commentText = ''
					this.$modal.showToast('谢谢评论~')
					let parms = {
						comBodyId: this.commentForm.comBodyId,
						comBodyType: 1
					}
					listComment(parms).then(res => {
						this.commentList = res.rows
					})
				})
			},
			toBookDetail(bookId) {
				this.$tab.navigateTo('/pages/service/bookDetail?bookId=' + bookId)
			},
			openBook(url) {
				let pram = {
					bookId: this.bookDetail.bookId,
					readNum: 1
				}
				this.$modal.showToast('书籍较大，请耐心等待~')
				rankParm(pram).then(res => {
					const path = `/static/pdf/web/viewer.html?file=${baseUrl + url}`
					this.$tab.navigateTo(`/pages/common/webview/index?title=${this.bookDetail.bookName}&url=${path}`)
					// uni.downloadFile({
					// 	url: baseUrl + url,
					// 	success: function(res) {
					// 		var filePath = res.tempFilePath;

					// 		uni.openDocument({
					// 			filePath: filePath,
					// 			showMenu: true,
					// 			success: function(res) {
					// 				console.log('打开文档成功');
					// 			}
					// 		});
					// 	}
					// })
				})
			}
		}
	}
</script>

<style lang="scss">
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
