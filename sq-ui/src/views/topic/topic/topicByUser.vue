<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="话题" prop="topicName">
        <el-input
            v-model="queryParams.topicName"
            placeholder="请输入话题"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发布时间">
        <el-date-picker
            v-model="daterangeTopicCreatedate"
            size="small"
            style="width: 240px"
            value-format="yyyy-MM-dd"
            type="daterange"
            range-separator="-"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="el-icon-plus"
            size="mini"
            @click="handleAdd"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="el-icon-edit"
            size="mini"
            :disabled="single"
            @click="handleUpdate"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="el-icon-delete"
            size="mini"
            :disabled="multiple"
            @click="handleDelete"
        >删除
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="topicList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="发布者" align="center" prop="sysUser.nickName"/>
      <el-table-column label="话题" align="center" prop="topicName"/>
      <el-table-column label="封面" align="center" prop="topicCover">
        <template slot-scope="scope">
          <el-tooltip class="item" effect="dark" placement="top">
            <el-image slot="content" :src="baseUrl+scope.row.topicCover" style="width: 200px;height: 200px"></el-image>
            <el-image :src="baseUrl+scope.row.topicCover"></el-image>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="发布时间" align="center" prop="topicCreatedate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.topicCreatedate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
          >修改
          </el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改话题对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="1000px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="话题" prop="topicName">
          <el-input v-model="form.topicName" placeholder="请输入话题"/>
        </el-form-item>
        <el-form-item label="封面">
          <imageUpload v-model="form.topicCover" :limit="1"/>
        </el-form-item>
        <el-form-item label="文章">
          <editor v-model="form.topicContent" :min-height="192"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {listTopic, getTopic, delTopic, addTopic, updateTopic, exportTopic} from "@/api/topic/topic";
import {addMineTopic, getMineTopic, listMine, updateMineTopic} from "../../../api/topic/topic";

export default {
  name: "Topic",
  data() {
    return {
      baseUrl: process.env.VUE_APP_BASE_API,
      // 遮罩层
      loading: true,
      // 导出遮罩层
      exportLoading: false,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 话题表格数据
      topicList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 发布时间时间范围
      daterangeTopicCreatedate: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        topicName: null,
        topicCreatedate: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {}
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询话题列表 */
    getList() {
      this.loading = true;
      this.queryParams.params = {};
      if (null != this.daterangeTopicCreatedate && '' != this.daterangeTopicCreatedate) {
        this.queryParams.params["beginTopicCreatedate"] = this.daterangeTopicCreatedate[0];
        this.queryParams.params["endTopicCreatedate"] = this.daterangeTopicCreatedate[1];
      }
      listMine(this.queryParams).then(response => {
        this.topicList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        topicId: null,
        userId: null,
        topicName: null,
        topicContent: null,
        topicCover: null,
        topicCreatedate: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.daterangeTopicCreatedate = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.topicId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加话题";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const topicId = row.topicId || this.ids
      getMineTopic(topicId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改话题";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.topicId != null) {
            updateMineTopic(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addMineTopic(this.form).then(response => {
              this.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const topicIds = row.topicId || this.ids;
      this.$confirm('是否确认删除话题编号为"' + topicIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return delTopic(topicIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      }).catch(() => {
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有话题数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.exportLoading = true;
        return exportTopic(queryParams);
      }).then(response => {
        this.download(response.msg);
        this.exportLoading = false;
      }).catch(() => {
      });
    }
  }
};
</script>
