<template>
	<view>
		<view class="cu-chat" v-html="content"></view>

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
		baseUrl
	} from '@/config'
	let socketTask;
	export default {
		data() {
			return {
				avatar: '',
				chatUserId: '',
				userIdSelf: '',
				avatarSelf: this.$store.state.user.avatar,
				content: '',
				comment: '',
				baseUrl: config.baseUrl,
				wssUrl: config.wssUrl,
			}
		},

		onLoad: function(option) {
			uni.setNavigationBarTitle({
				title: option.nickName
			});
			this.avatar = option.avatar
			this.chatUserId = option.userId
			this.userIdSelf = option.fromId
			this.getChatRecords(option.userId)
			
			this.init()
		},
		methods: {

			init() {
				
				socketTask = uni.connectSocket({
					url: this.wssUrl + this.userIdSelf, //仅为示例，并非真实接口地址。
					complete: (res)=> {console.log("WebSocket连接成功",res)}
				});
				socketTask.onOpen((res) => {})

				socketTask.onMessage((res) => {
					let data = JSON.parse(res.data)
					// console.log(data)
					let item = {
						content: data.text,
						time: ''
					}
					if (!data.users) {
						this.createContent(data.from, null, item)
					}
				})
			},


			getChatRecords(id) {
				chatRecords(id).then(res => {
					for (let i = 0; i < res.data.length; i++) {
						let item = res.data[i]
						if (item.userId == id) {
							this.createContent(id, null, item)
						} else {
							this.createContent(null, item.userId, item)
						}
					}
				})
			},

			submit() {
				let item = {
					content: this.comment,
					time: ''
				}
				let message = {
					userId: this.userIdSelf,
					to: this.chatUserId,
					text: this.comment
				}
				socketTask.send({
					data: JSON.stringify(message)
				})
				this.createContent(null, this.userIdSelf, item)
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
						`<view class=\"cu-avatar radius\" style=\"background-image:url(${this.baseUrl +this.avatar});\">\n` +
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
