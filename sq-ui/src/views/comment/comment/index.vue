<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="120px">
      <el-form-item label="被评论id" prop="comBodyId">
        <el-input
            v-model="queryParams.comBodyId"
            placeholder="请输入评论体"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="评论内容" prop="commentText">
        <el-input
            v-model="queryParams.commentText"
            placeholder="请输入评论内容"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="评论主体类型" prop="comBodyType">
        <el-select v-model="queryParams.comBodyType" placeholder="请选择评论主体类型" clearable size="small">
          <el-option label="书籍" :value="1"/>
          <el-option label="社区" :value="2"/>
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker
            v-model="daterangeCreateDate"
            size="small"
            style="width: 240px"
            value-format="yyyy-MM-dd"
            type="daterange"
            range-separator="-"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="点赞数" prop="likeNum">
        <el-input
            v-model="queryParams.likeNum"
            placeholder="请输入点赞数"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否违规" prop="isVio">
        <el-select v-model="queryParams.isVio" placeholder="请选择是否违规" clearable size="small">
          <el-option label="是" :value="0"/>
          <el-option label="否" :value="1"/>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <!--      <el-col :span="1.5">
              <el-button
                  type="primary"
                  plain
                  icon="el-icon-plus"
                  size="mini"
                  @click="handleAdd"
                  v-hasPermi="['comment:comment:add']"
              >新增</el-button>
            </el-col>-->
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="el-icon-edit"
            size="mini"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['comment:comment:edit']"
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
            v-hasPermi="['comment:comment:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="el-icon-download"
            size="mini"
            :loading="exportLoading"
            @click="handleExport"
            v-hasPermi="['comment:comment:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="commentList" @selection-change="handleSelectionChange" row-key="commentId"
              :tree-props="{children: 'children'}">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="评论用户名" align="center" prop="sysUser.nickName"/>
      <el-table-column label="评论体" align="center" prop="comBodyId"/>
      <el-table-column label="评论内容" align="center" prop="commentText"/>
      <el-table-column label="评论主体类型" align="center" prop="comBodyType">
        <template slot-scope="scope">
          <span>{{ scope.row.comBodyType == 1 ? "书籍" : "社区" }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createDate, '{y}-{m}-{d} {h}:{mm}:{ss}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="点赞数" align="center" prop="likeNum"/>
      <el-table-column label="是否违规" align="center" prop="isVio">
        <template slot-scope="scope">
          <span>{{ scope.row.isVio != 1 ? "是" : "否" }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['comment:comment:edit']"
          >修改
          </el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['comment:comment:remove']"
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

    <!-- 添加或修改评论对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <!--        <el-form-item label="父级id" prop="commentParentId">
                  <el-input v-model="form.commentParentId" placeholder="请输入父级id" />
                </el-form-item>
                <el-form-item label="用户id" prop="userId">
                  <el-input v-model="form.userId" placeholder="请输入用户id" />
                </el-form-item>
                <el-form-item label="评论体" prop="comBodyId">
                  <el-input v-model="form.comBodyId" placeholder="请输入评论体" />
                </el-form-item>
                <el-form-item label="评论内容" prop="commentText">
                  <el-input v-model="form.commentText" placeholder="请输入评论内容" />
                </el-form-item>
                <el-form-item label="评论主体类型，1书，2社区" prop="comBodyType">
                  <el-select v-model="form.comBodyType" placeholder="请选择评论主体类型，1书，2社区">
                    <el-option label="请选择字典生成" value="" />
                  </el-select>
                </el-form-item>
                <el-form-item label="创建时间" prop="createDate">
                  <el-date-picker clearable size="small"
                                  v-model="form.createDate"
                                  type="date"
                                  value-format="yyyy-MM-dd"
                                  placeholder="选择创建时间">
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="点赞数" prop="likeNum">
                  <el-input v-model="form.likeNum" placeholder="请输入点赞数" />
                </el-form-item>-->
        <el-form-item label="是否违规" prop="isVio">
          <el-select v-model="form.isVio" placeholder="请选择是否违规" clearable size="small">
            <el-option label="是" :value="0"/>
            <el-option label="否" :value="1"/>
          </el-select>
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
import {listComment, getComment, delComment, addComment, updateComment, exportComment} from "@/api/comment/comment";

export default {
  name: "Comment",
  data() {
    return {
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
      // 评论表格数据
      commentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 创建时间时间范围
      daterangeCreateDate: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        commentParentId: null,
        userId: null,
        comBodyId: null,
        commentText: null,
        comBodyType: 1,
        createDate: null,
        likeNum: null,
        isVio: null
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
    /** 查询评论列表 */
    getList() {
      this.loading = true;
      this.queryParams.params = {};
      if (null != this.daterangeCreateDate && '' != this.daterangeCreateDate) {
        this.queryParams.params["beginCreateDate"] = this.daterangeCreateDate[0];
        this.queryParams.params["endCreateDate"] = this.daterangeCreateDate[1];
      }
      listComment(this.queryParams).then(response => {
        this.commentList = response.rows;
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
        commentId: null,
        commentParentId: null,
        userId: null,
        comBodyId: null,
        commentText: null,
        comBodyType: null,
        createDate: null,
        likeNum: null,
        isVio: null
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
      this.daterangeCreateDate = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.commentId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加评论";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const commentId = row.commentId || this.ids
      getComment(commentId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改评论";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.commentId != null) {
            updateComment(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addComment(this.form).then(response => {
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
      const commentIds = row.commentId || this.ids;
      this.$confirm('是否确认删除评论编号为"' + commentIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function () {
        return delComment(commentIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      }).catch(() => {
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有评论数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.exportLoading = true;
        return exportComment(queryParams);
      }).then(response => {
        this.download(response.msg);
        this.exportLoading = false;
      }).catch(() => {
      });
    }
  }
};
</script>
