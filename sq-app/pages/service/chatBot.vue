<template>
	<view>
		<view class="cu-chat" v-html="content"></view>
		<u-loading-icon mode="circle" text="思考问题中~~~稍等" size="36" :vertical="true" :show="loading"></u-loading-icon>
		<u-gap height="60"></u-gap>
		<view class="cu-bar foot input">
			<input class="solid-bottom" v-model="comment" :adjust-position="false" :focus="false" maxlength="300"
				cursor-spacing="10"></input>
			<button class="cu-btn bg-green shadow" @click="submit">发送</button>
		</view>


	</view>
</template>

<script>
	import {
		chatRecords
	} from '@/api/service/private'
	import config, {
		baseUrl,
		chatApiIP
	} from '@/config'
	let socketTask;
	export default {
		data() {
			return {
				avatarSelf: this.$store.state.user.avatar,
				content: '',
				comment: '',
				baseUrl: config.baseUrl,
				loading: false
			}
		},

		onLoad: function(option) {
			uni.setNavigationBarTitle({
				title: option.nickName
			});
			this.init()
		},

		methods: {

			init() {
				let item = {
					content: '我是你的助手，你可以问我一些问题。比如：推荐几本书或者写一首诗等等！',
					time: ''
				}
				this.createContent(1, null, item)
			},
			linkify(text) {
				const urlRegex = /https?:\/\/[^\s]+/g
				return text.replace(urlRegex, url => `<a href="${url}" target="_blank">${url}</a>`)
			},
			submit() {
				this.loading = true 
				uni.request({
					url: config.chatApiIP,
					data: {
						userinput: this.comment
					},
					method: 'POST',
					success: (res) => {
						this.loading = false
						let item1 = {
							content: this.linkify(res.data.response.response),
							time: ''
						}
						// 推荐几本书带书名号带链接
						this.createContent(1, null, item1)
					}
				});
				let item = {
					content: this.comment,
					time: ''
				}
				this.createContent(null, 1, item)
				this.comment = ''
			},

			createContent(remoteUser, nowUser, item) { // 这个方法是用来将 json的聊天消息数据转换成 html的。
				let html
				// 当前用户消息
				if (nowUser) { // nowUser 表示是否显示当前用户发送的聊天消息，绿色气泡
					html = "<view class=\"cu-item self\">\n" +
						"<view class=\"main\">\n" +
						"<view class=\"content bg-green shadow\">\n" +
						"<text>" + item.content + "</text>\n" +
						"</view>\n" +
						"</view>\n" +
						`<view class=\"cu-avatar radius\" style=\"background-image:url(${this.avatarSelf});\">\n` +
						"</view>\n" +
						"<view class=\"date\">" + item.time + "</view>\n" +
						"</view>";
				} else if (remoteUser) { // remoteUser表示远程用户聊天消息，蓝色的气泡
					html = "<view class=\"cu-item\">\n" +
						`<view class=\"cu-avatar radius\" style=\"background-image:url(/static/logo.png);\">\n` +
						"</view>\n" +
						"<view class=\"main\">\n" +
						"<view class=\"content shadow\">\n" +
						"<text>" + item.content + "</text>\n" +
						"</view>\n" +
						"</view>\n" +
						"<view class=\"date\">" + item.time + "</view>\n" +
						"</view>";
				}
				this.content += html;
				this.$nextTick(() => {
					uni.pageScrollTo({
						scrollTop: 2000000, //滚动到页面的目标位置（单位px）
						duration: 0 //滚动动画的时长，默认300ms，单位 ms
					})
				})
			}
		}
	}
</script>

<style>

</style>
