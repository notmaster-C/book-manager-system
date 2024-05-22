<template>
  <div class="search_container">
    <!-- 面包屑导航区域 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
      <el-breadcrumb-item>预约管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card shadow="always">
      <!-- 搜索内容和导出区域 -->
      <el-row>
        <el-col :span="6"
        >条件搜索:
          <el-select
              v-model="queryInfo.condition"
              filterable
              placeholder="请选择"
              style="margin-left: 15px"
          >
            <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
            >
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="4">
          <el-input
              placeholder="请输入内容"
              v-model="queryInfo.query"
              class="input-with-select"
              @keyup.enter.native="getBorrowStatement"
          >
            <el-button
                slot="append"
                icon="el-icon-search"
                @click="getBorrowStatement"
            ></el-button>
          </el-input
          >
        </el-col>
        <el-col :span="2" style="float: right">
          <download-excel
              class="export-excel-wrapper"
              :data="tableData"
              :fields="json_fields"
              :header="title"
              name="预约信息.xls"
          >
            <!-- 上面可以自定义自己的样式，还可以引用其他组件button -->
            <el-button type="primary" class="el-icon-printer" size="mini"
            >导出Excel
            </el-button
            >
          </download-excel>
        </el-col>
        <el-col :span="2" style="float: right">
          <el-button
              type="primary"
              class="el-icon-printer"
              size="mini"
              @click="downLoad"
          >导出PDF
          </el-button
          >
        </el-col>
        <el-col :span="2" style="float: right">

          <el-button type="success" class="el-icon-full-screen" size="mini" @click="fullScreen"
          >全屏
          </el-button
          >
        </el-col>
      </el-row>
      <!-- 表格区域 -->
      <el-table
          :data="tableData"
          border
          style="width: 100%"
          stripe
          id="pdfDom"
          :default-sort="{ prop: 'cardNumber', order: 'ascending' }"
          v-loading="loading"
          element-loading-text="拼命加载中"
          element-loading-spinner="el-icon-loading"
          element-loading-background="rgba(0, 0, 0, 0.8)"
      >
        <el-table-column prop="cardNumber" label="借阅证编号" sortable>
        </el-table-column>
        <el-table-column prop="bookNumber" label="图书编号" sortable>
        </el-table-column>
        <el-table-column prop="reverseDate" label="预约借阅日期" sortable>
        </el-table-column>
        <el-table-column prop="closeDate" label="实际借阅日期" sortable>
        </el-table-column>
        <el-table-column prop="createTime" label="创建日期" sortable>
        </el-table-column>
        <el-table-column label="操作" fixed="right">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="借阅" placement="top" :enterable="false">
              <el-button type="primary" icon="el-icon-aim" size="mini"
                         @click="borrowReverseBook(scope.row.id)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除" placement="top" :enterable="false">
              <el-button type="danger" icon="el-icon-delete" size="mini"
                         @click="removeReverse(scope.row.id)"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页查询区域 -->
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryInfo.pageNum"
          :page-sizes="[5, 10, 20, 50, 100]"
          :page-size="queryInfo.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="this.total"
      >
      </el-pagination>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      options: [
        {
          value: "card_number",
          label: "借阅证号",
        },
        {
          value: "book_number",
          label: "图书编号",
        },
        {
          value: "reverse_date",
          label: "预约借阅日期",
        },
        {
          value: "close_date",
          label: "实际借阅日期",
        },
        {
          value: "create_time",
          label: "创建日期",
        },
      ],
      tableData: [],
      queryInfo: {
        pageNum: 1,
        pageSize: 5,
        condition: "",
        query: "",
      },
      borrowBook: {
        bookNumber: "",
        cardNumber: "",
      },
      total: 0,
      title: "预约信息",
      json_fields: {
        借阅证编号: "cardNumber",
        图书编号: "bookNumber",
        预约借阅日期: "reverseDate",
        实际借阅日期: "closeDate",
        创建日期: "createTime",
      },
      loading: true
    };
  },
  methods: {
    handleSizeChange(val) {
      this.queryInfo.pageSize = val;

      this.getBorrowStatement();
    },
    handleCurrentChange(val) {
      this.queryInfo.pageNum = val;

      this.getBorrowStatement();
    },
    async borrowReverseBook(id) {
      const confirmResult = await this.$confirm(
          "确定要借阅此记录吗?",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning",
          }
      ).catch((error) => {
        return error;
      });
      if (confirmResult !== "confirm") {
        this.reverseDialogVisible = false
        return this.$message.info("已经取消借阅");
      }
      const {data: res} = await this.$http.get(
          "bookadmin/reverse_book/"+id
      );
      if (res.status !== 200) {
        return this.$message.error(res.msg);
      }
      this.$message.success({
        message: res.msg,
        duration: 1000,
      });
      await this.getBorrowStatement()
    },
    async removeReverse(id) {
      const confirmResult = await this.$confirm(
          "确定要删除此记录吗?",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning",
          }
      ).catch((error) => {
        return error;
      });
      if (confirmResult !== "confirm") {
        this.reverseDialogVisible = false
        return this.$message.info("已经取消删除");
      }
      const {data: res} = await this.$http.get(
          "bookadmin/del_reverse/" + id
      );
      if (res.status !== 200) {
        return this.$message.error(res.msg);
      }
      this.$message.success({
        message: res.msg,
        duration: 1000,
      });
      await this.getBorrowStatement()
    },
    async getBorrowStatement() {
      this.loading = true;
      const {data: res} = await this.$http.post(
          "bookadmin/reverse_list",
          this.queryInfo
      );
      // console.log(res);
      this.tableData = [];
      if (res.status !== 200) {
        this.total = 0;
        this.loading = false;
        return this.$message.error(res.msg);
      }
      this.$message.success({
        message: res.msg,
        duration: 1000,
      });
      this.tableData = res.data.records;
      this.total = parseInt(res.data.total);
      this.loading = false;
    },
    downLoad() {
      this.getPdf(this.title); //参数是下载的pdf文件名
    },
    fullScreen() {
      // Dom对象的一个属性: 可以用来判断当前是否为全屏模式(trueORfalse)
      let full = document.fullscreenElement;
      // 切换为全屏模式
      if (!full) {
        // 文档根节点的方法requestFullscreen实现全屏模式
        document.documentElement.requestFullscreen();
      } else {
        // 退出全屏模式
        document.exitFullscreen();
      }
    }
  },
  created() {
    this.getBorrowStatement();
  },
};
</script>

<style>
</style>
