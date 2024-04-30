// 应用全局配置
module.exports = {
	// prod
	baseUrl: 'http://localhost:8080',
	wssUrl: 'ws://localhost:8080/websocket/',
	// dev
	// baseUrl: 'http://localhost:8080',
	// wssUrl: 'ws://localhost:8080/websocket/',
	// 拾柒助手服务器
	chatApiIP: 'http://193.122.146.85:2000',

	// 应用信息
	appInfo: {
		// 应用名称
		name: "拾柒爱阅读",
		// 应用版本
		version: "1.0.2.4",
		// 应用logo
		logo: "/static/logo.png",
		// 官方网站
		site_url: "https://cxq21.gitee.io/",
		// 政策协议
		agreements: [{
				title: "隐私政策",
				url: "https://cxq21.gitee.io/posts/6b5b190a.html"
			},
			{
				title: "用户服务协议",
				url: "https://cxq21.gitee.io/posts/3dc898ff.html"
			}
		]
	}
}
