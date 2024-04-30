<template>
  <el-main>
    <router-view :key="key"/>
    <el-backtop :bottom="100" :visibility-height="100">
      <div
          style="{
        height: 100%;
        width: 100%;
        background-color: #f2f5f6;
        box-shadow: 0 0 6px rgba(0,0,0, .12);
        text-align: center;
        line-height: 40px;
        color: rgb(48, 176, 143);
      }"
      >
        <i class="el-icon-s-promotion"></i>
      </div>
    </el-backtop>
  </el-main>
</template>

<script>
export default {
  name: 'cmsMain',
  computed: {
    key() {
      return this.$route.path
    }
  }
}
</script>

<style scoped>
.el-main {
  min-height: 80vh;
}
</style>
