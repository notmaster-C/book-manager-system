<template>
	<view class="normal-login-container">
		<view class="logo-content align-center justify-center flex">
			<image style="width: 100rpx;height: 100rpx;" :src="globalConfig.appInfo.logo" mode="widthFix">
			</image>
			<text class="title">拾柒爱阅读注册</text>
		</view>
		<view class="align-center justify-center flex">
			<text class="title">您即将成为这个星球第</text>
			<u-count-to :start-val="1" :end-val="userNum" :duration="4000" :useEasing="true" color="#30B08F"></u-count-to>
			<text class="title">位，加入拾柒爱阅读！</text>
		</view>
		<view class="login-form-content">
			<view class="input-item flex align-center">
				<view class="iconfont icon-user icon"></view>
				<input v-model="registerForm.username" class="input" type="text" placeholder="请输入账号" maxlength="30" />
			</view>
			<view class="input-item flex align-center">
				<view class="iconfont icon-password icon"></view>
				<input v-model="registerForm.password" type="password" class="input" placeholder="请输入密码" maxlength="20" />
			</view>
			<view class="input-item flex align-center" v-if="captchaEnabled">
				<view class="iconfont icon-code icon"></view>
				<input v-model="registerForm.code" type="number" class="input" placeholder="请输入验证码" maxlength="4" />
				<image :src="codeUrl" @click="getCode" class="login-code-img"></image>
			</view>
			<view class="action-btn">
				<button @click="handleRegiste" class="login-btn cu-btn block bg-cyan lg round">注册</button>
			</view>
		</view>
		
	</view>
</template>

<script>
	import {
		getCodeImg,
		register
	} from '@/api/login'
	import {
		getUserNum
	} from '@/api/service/public'

	export default {
		data() {
			return {
				codeUrl: "",
				captchaEnabled: true,
				globalConfig: getApp().globalData.config,
				registerForm: {
					username: "",
					password: "",
					code: "",
					uuid: ''
				},
				userNum: null
			}
		},
		created() {
			this.getCode()
			this.getUserNumber()
		},
		methods: {
			getUserNumber() {
				getUserNum().then(res => {
					this.userNum = res
				})
			},
			// 获取图形验证码
			getCode() {
				getCodeImg().then(res => {
					this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled
					if (this.captchaEnabled) {
						this.codeUrl = 'data:image/gif;base64,' + res.img
						this.registerForm.uuid = res.uuid
					}
				})
			},
			// z注册方法
			async handleRegiste() {
				if (this.registerForm.username === "") {
					this.$modal.msgError("请输入您的账号")
				} else if (this.registerForm.password === "") {
					this.$modal.msgError("请输入您的密码")
				} else if (this.registerForm.code === "" && this.captchaEnabled) {
					this.$modal.msgError("请输入验证码")
				} else {
					this.$modal.loading("注册中，请耐心等待...")
					this.pwdLogin()
				}
			},
			// 密码登录
			async pwdLogin() {
				register(this.registerForm).then(res=>{
					this.$modal.showToast('注册成功~')
					this.$tab.reLaunch('/pages/login')
				}).catch(() => {
					if (this.captchaEnabled) {
						this.getCode()
					}
				})
			}
		}
	}
</script>

<style lang="scss">
	page {
		background-color: #ffffff;
	}

	.normal-login-container {
		width: 100%;

		.logo-content {
			width: 100%;
			font-size: 21px;
			text-align: center;
			padding-top: 15%;

			image {
				border-radius: 4px;
			}

			.title {
				margin-left: 10px;
			}
		}

		.login-form-content {
			text-align: center;
			margin: 20px auto;
			margin-top: 15%;
			width: 80%;

			.input-item {
				margin: 20px auto;
				background-color: #f5f6f7;
				height: 45px;
				border-radius: 20px;

				.icon {
					font-size: 38rpx;
					margin-left: 10px;
					color: #999;
				}

				.input {
					width: 100%;
					font-size: 14px;
					line-height: 20px;
					text-align: left;
					padding-left: 15px;
				}

			}

			.login-btn {
				margin-top: 40px;
				height: 45px;
			}

			.xieyi {
				color: #333;
				margin-top: 20px;
			}
		}

		.easyinput {
			width: 100%;
		}
	}

	.login-code-img {
		height: 45px;
	}
</style>
