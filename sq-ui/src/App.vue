<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
import DevicePixelRatio from "./utils/devicePixelRatio";
import {computerIp} from './config'
export default {
  name: 'App',
  metaInfo() {
    return {
      title: this.$store.state.settings.dynamicTitle && this.$store.state.settings.title,
      titleTemplate: title => {
        return title ? `${title} - ${process.env.VUE_APP_TITLE}` : process.env.VUE_APP_TITLE
      }
    }
  },
  created() {
    new DevicePixelRatio().init()
  },
  mounted() {
    this.isMobile()
  },
  methods: {
    // 添加判断方法
    isMobile() {
      this.flag = navigator.userAgent.match(
          /(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i
      );
      if(this.flag === null) {
        console.log("pc端");
      }else {
        console.log("移动端");
        window.location.href = "http://"+computerIp+":81/#/pages/index"
      }
    }
  },

}
</script>
