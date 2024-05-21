<template>
  <div class="information_container">
    <div class="backgroundImg">
      <img
          src="https://s.cn.bing.net/th?id=OHR.CheetahRain_ZH-CN6722375507_1920x1080.webp&qlt=50"
          alt="背景图片"
      />
    </div>
    <div class="information_header">
      <p>个人信息</p>
      <p>
        <i class="el-icon-s-flag"></i> By reading we enrich the mind, by
        conversation we polish it.
      </p>
    </div>
    <div class="information_banner"
         v-loading="loading"
         element-loading-text="拼命加载中"
         element-loading-spinner="el-icon-loading"
         element-loading-background="rgba(0, 0, 0, 0.8)">
      <div class="information_banner_left">
        <div class="banner_left_main" v-if="show">
          <div class="number">
            <i class="el-icon-collection-tag"></i> 借阅证编号:
            {{ this.user.cardNumber }}
          </div>
          <div class="name">
            <i class="iconfont icon-gerenxinxi"></i> 借阅证姓名:
            {{ this.user.cardName }}
          </div>
          <div class="rule">
            <i class="iconfont icon-guizeshezhi"></i> 规则编号:
            {{ this.user.ruleNumber }}
          </div>
          <div class="amt">
            <i class="el-icon-goods"></i> 账户余额:
            {{ this.user.accountAmt }}元
          </div>
          <div class="status">
            <i class="el-icon-refresh"></i> 状态:
            {{ this.user.status === 1 ? "可用" : "禁用" }}
          </div>
        </div>
      </div>
      <div class="information_banner_right">
        <el-button type="primary" class="changePWD" @click="showEditDialog" v-if="show"
        >修改密码
        </el-button
        >
        <el-button type="primary" class="changePWD" @click="showPayDialog" v-if="show"
        >钱包充值
        </el-button
        >
      </div>
      <el-dialog
          title="修改密码"
          :visible.sync="editDialogVisible"
          width="30%"
          @close="editDialogClosed"
      >
        <el-form
            :model="editForm"
            ref="editFormRef"
            :rules="editFormRules"
            label-width="120px"
        >
          <el-form-item label="新密码" prop="password">
            <el-input v-model="editForm.password" type="password" show-password placeholder="请输入新密码"></el-input>
          </el-form-item>
          <el-form-item label="新密码" prop="confirmPassword">
            <el-input v-model="editForm.confirmPassword" type="password" placeholder="请再次输入新密码"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="editDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="changePassword"
          >确 定</el-button
          >
        </span>
      </el-dialog>

      <el-dialog title="扫码支付" :visible.sync="payDialogVisible" width="300px" :close-on-click-modal="false">
        <div v-if="!pay.status">
          <p style="text-align: center;line-height: 20px;">{{ pay.payType }}扫一扫付款（元）</p>
          <p style="text-align: center;font-size: 24px;color: #fa920e;padding: 5px 0px;font-weight: bold;">
            {{ pay.money }}</p>
          <div class="codeBox">
            <img id="qrcode" :src="pay.url" @click="payment" style="display: flex;margin: 0 auto;"/>
            <div class="clearfix" style="margin: 0 auto; width: 130px;font-size: 12px;">
              <div style="float: left;">
                <svg t="1561615212373" class="icon" viewBox="0 0 1024 1024" version="1.1"
                     xmlns="http://www.w3.org/2000/svg" p-id="976" data-spm-anchor-id="a313x.7781069.0.i3" width="40"
                     height="40">
                  <path
                      d="M295.7312 111.52384h-83.95776c-56.80128 0-103.00416 46.20288-103.00416 103.00416v83.968c0 10.496 8.54016 19.0464 19.0464 19.0464h0.01024c10.50624 0 19.0464-8.5504 19.0464-19.0464v-83.968a64.9728 64.9728 0 0 1 64.91136-64.91136h83.95776c10.50624 0 19.0464-8.5504 19.0464-19.0464s-8.5504-19.0464-19.05664-19.0464zM812.22656 108.99456H728.2688a21.6064 21.6064 0 0 0-21.57568 21.57568 21.6064 21.6064 0 0 0 21.57568 21.58592h83.95776a62.464 62.464 0 0 1 62.38208 62.38208v83.968a21.6064 21.6064 0 0 0 21.58592 21.57568 21.6064 21.6064 0 0 0 21.57568-21.57568v-83.968c0-58.19392-47.34976-105.53344-105.54368-105.54368zM896.19456 703.93856a21.6064 21.6064 0 0 0-21.57568 21.57568v83.95776a62.464 62.464 0 0 1-62.38208 62.38208h-83.968a21.6064 21.6064 0 0 0-21.57568 21.58592 21.6064 21.6064 0 0 0 21.57568 21.57568h83.95776c58.19392 0 105.53344-47.33952 105.53344-105.53344v-83.95776a21.58592 21.58592 0 0 0-21.56544-21.58592z"
                      fill="#fa920e" p-id="977" data-spm-anchor-id="a313x.7781069.0.i4" class="selected"></path>
                  <path
                      d="M295.7312 108.99456h-83.95776c-58.19392 0-105.53344 47.34976-105.53344 105.53344v83.968a21.6064 21.6064 0 0 0 21.58592 21.57568 21.6064 21.6064 0 0 0 21.57568-21.57568v-83.968a62.464 62.464 0 0 1 62.38208-62.38208h83.95776a21.6064 21.6064 0 0 0 21.57568-21.58592 21.61664 21.61664 0 0 0-21.58592-21.56544zM295.7312 871.84384h-83.95776a62.464 62.464 0 0 1-62.38208-62.38208V725.504a21.6064 21.6064 0 0 0-21.58592-21.57568 21.6064 21.6064 0 0 0-21.57568 21.57568v83.95776c0 58.19392 47.34976 105.53344 105.53344 105.53344h83.95776a21.6064 21.6064 0 0 0 21.58592-21.57568 21.6064 21.6064 0 0 0-21.57568-21.57568zM812.22656 111.52384H728.2688c-10.50624 0-19.0464 8.54016-19.0464 19.0464s8.54016 19.0464 19.0464 19.0464h83.95776a64.9728 64.9728 0 0 1 64.91136 64.91136v83.968c0 10.50624 8.5504 19.0464 19.0464 19.0464 10.50624 0 19.0464-8.54016 19.0464-19.0464v-83.968c0-56.79104-46.20288-102.99392-103.00416-103.00416z"
                      fill="#fa920e" p-id="978" data-spm-anchor-id="a313x.7781069.0.i0" class="selected"></path>
                  <path
                      d="M265.19552 297.13408h64.95232v208.39424h-64.95232zM369.11104 297.13408h38.97344v208.39424h-38.97344zM447.04768 297.13408H512v208.39424h-64.95232zM550.97344 297.13408h103.91552v208.39424H550.97344zM693.85216 297.13408h64.95232v208.39424h-64.95232zM265.19552 614.7584h64.95232v112.10752h-64.95232zM369.11104 614.7584h38.97344v112.10752h-38.97344zM447.04768 614.7584H512v112.10752h-64.95232zM550.97344 614.7584h103.91552v112.10752H550.97344zM693.85216 614.7584h64.95232v112.10752h-64.95232zM852.20352 538.79808H171.79648c-11.04896 0-20.00896 10.0352-20.00896 22.40512 0 12.36992 8.96 22.40512 20.00896 22.40512h680.3968c11.04896 0 20.00896-10.0352 20.00896-22.40512 0.01024-12.38016-8.94976-22.40512-19.99872-22.40512z"
                      fill="#fa920e" p-id="979" data-spm-anchor-id="a313x.7781069.0.i1" class="selected"></path>
                </svg>
              </div>
              <div><!--            style="float: left;line-height: 20px;margin-left: 5px;"-->
                <p>打开手机{{ pay.payType }}</p>
                <p>扫一扫继续付款</p>
              </div>
            </div>
          </div>
        </div>
        <div id="alipay" v-if="pay.status" v-html="pay.url"
             v-loading="pay.loading"
             element-loading-text="拼命加载中"
             element-loading-spinner="el-icon-loading"
             element-loading-background="rgba(0, 0, 0, 0.8)"
        >

        </div>

      </el-dialog>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    var validatePass2 = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.editForm.password) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    return {
      user: {
        ruleNumber: Number,
        cardNumber: Number,
        status: Number,
        userId: Number,
        cardName: "",
        username: "",
        password: "",
        createTime: "",
        updateTime: "",
      },
      payDialogVisible: false,
      pay: {
        money: 50,
        payType: '微信',
        url: 'https://tse1-mm.cn.bing.net/th/id/OIP-C.dunx9PthoCa-p_15YtIAFQHaHj?w=176&h=180&c=7&r=0&o=5&pid=1.7',
        status: false,
        loading: true
      },
      editForm: {
        password: "",
        confirmPassword: "",
      },
      editFormRules: {
        password: [
          {required: true, message: "请输入新密码", trigger: "blur"},
          {min: 6, max: 15, message: "新密码长度在6-15个字符", trigger: "blur"}
        ],
        confirmPassword: [
          {validator: validatePass2, trigger: "blur"}
        ]

      },
      editDialogVisible: false,
      show: false,
      loading: true,
    };
  },
  methods: {
    //让修改公告的对话框可见,并从数据库中回显数据
    showEditDialog() {
      // 让修改公告的对话框可见
      this.editDialogVisible = true;
    },
    showPayDialog() {
      // 让修改公告的对话框可见
      this.payDialogVisible = true;
    },
    async payment() {
      const userId =window.sessionStorage.getItem('userId')
      const {data: res} = await this.$http.get('user/payment/'+userId,)
      if (res.status !== 200) {
        return this.$message.error(res.msg);
      }
      this.$message.success({
        message: "充值50元成功!",
        duration: 1000,
      });
      this.payDialogVisible=false
      this.getUserInformaton()
    },
    //监听修改对话框的关闭，一旦对话框关闭，就重置表单，回显数据
    editDialogClosed() {
      this.$refs.editFormRef.resetFields();
    },
    async getUserInformaton() {
      // 先从sessionStorage中获取用户id
      const userId = window.sessionStorage.getItem("userId");
      // 发送axios请求，携带用户id，获取个人信息
      this.loading = true;
      const {data: res} = await this.$http.get(
          "user/get_information/" + userId
      );
      if (res.status !== 200) {
        return this.$message.error(res.msg);
      }
      this.$message.success({
        message: res.msg,
        duration: 1000,
      });
      this.user = res.data;
      this.show = true;
      this.loading = false;

    },
    async changePassword() {
      const {data: res} = await this.$http.post('user/update_password', {
        password: this.editForm.password,
        userId: window.sessionStorage.getItem('userId')
      })
      if (res.status !== 200) {
        return this.$message.error(res.msg);
      }
      this.$message.success(res.msg)
      this.editDialogVisible = false;
      this.$refs.editFormRef.resetFields();
      window.sessionStorage.clear();
      this.$router.push("/login");
    }
  },
  created() {
    this.getUserInformaton();
  },
};
</script>

<style lang="less" scoped>
.information_container {
  position: relative;
  height: 100%;
}

.backgroundImg {
  position: absolute;
  width: 100%;
  height: 100%;

  img {
    width: 100%;
    height: 100%;
    opacity: 0.3;
  }
}

.information_header {
  height: 200px;
  // background-color: pink;
  text-align: center;

  p:nth-child(1) {
    line-height: 140px;
    color: black;
    font-size: 36px;
  }

  p:nth-child(2) {
    color: black;
    font-size: 24px;
  }
}

.information_banner {
  display: flex;
  flex-direction: row;
  height: 400px;
  // background-color: pink;
  .information_banner_left {
    flex: 0.5;
    // background-color: brown;
    text-align: center;
  }

  .information_banner_right {
    flex: 0.5;
    // background-color: skyblue;
    text-align: left;
    line-height: 400px;
  }
}

.banner_left_main {
  margin-top: 120px;
  color: black;
  font-size: 20px;

  div {
    margin-top: 15px;
  }
}

.changePWD {
  position: sticky;
  top: 50%;
  left: 50%;
}
</style>
