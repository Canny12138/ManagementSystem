<template>
  <div class="table">
    <el-card shadow="hover">
      <el-button
        style="float: right; margin-top: -10px; margin-bottom: 10px"
        @click="
          (dialogVisible = true),
            (in_sno = null),
            (in_sname = null),
            (in_cno = null)
        "
      >
        添加数据
      </el-button>
      <el-table
        v-loading="loading"
        :data="tableData"
        stripe
        border
        style="width: 100%"
      >
        <el-table-column prop="sno" label="学号" width="200"> </el-table-column>
        <el-table-column prop="sname" label="姓名" width="200">
        </el-table-column>
        <el-table-column prop="cno" label="班级" width="150"> </el-table-column>
        <el-table-column prop="zhuanye" label="专业" width="200">
        </el-table-column>
        <el-table-column prop="sdept" label="系部" width="200">
        </el-table-column>
        <el-table-column prop="update">
          <template slot-scope="scope">
            <el-button
              @click="
                (dialogVisible2 = true),
                  (in_sno = scope.row.sno),
                  (in_sname = scope.row.sname),
                  (in_cno = scope.row.cno)
              "
            >
              修改
            </el-button>
          </template>
        </el-table-column>
        <el-table-column prop="delete">
          <template slot-scope="scope">
            <el-popover placement="top" width="160" :ref="scope.$index">
              <p>确定删除吗？</p>
              <div style="text-align: right; margin: 0">
                <el-button
                  size="mini"
                  type="text"
                  @click="scope._self.$refs[scope.$index].doClose()"
                >
                  取消
                </el-button>
                <el-button
                  type="primary"
                  size="mini"
                  @click="
                    scope._self.$refs[scope.$index].doClose(),
                      toDelete(scope.row)
                  "
                >
                  确定
                </el-button>
              </div>
              <el-button slot="reference">删除</el-button>
            </el-popover>
          </template>
        </el-table-column>
      </el-table>
      <el-dialog
        title="添加数据"
        :visible.sync="dialogVisible"
        width="30%"
        :before-close="handleClose"
      >
        <el-row>
          <el-col :span="7" style="margin-right: 20px">
            <el-row><p>学号:</p></el-row>
            <el-row>
              <el-input v-model="in_sno"></el-input>
            </el-row>
          </el-col>
          <el-col :span="7" style="margin-right: 20px">
            <el-row><p>姓名:</p></el-row>
            <el-row>
              <el-input v-model="in_sname"></el-input>
            </el-row>
          </el-col>
          <el-col :span="6">
            <el-row><p>班级:</p></el-row>
            <el-row>
              <el-input v-model="in_cno"></el-input>
            </el-row>
          </el-col>
        </el-row>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button
            type="primary"
            @click="(dialogVisible = false), toAdd()"
          >
            确 定
          </el-button>
        </span>
      </el-dialog>
      <el-dialog
        title="修改"
        :visible.sync="dialogVisible2"
        width="30%"
        :before-close="handleClose"
      >
        <el-row>
          <el-col :span="7" style="margin-right: 20px">
            <el-row><p>学号:</p></el-row>
            <el-row>
              <el-input disabled="false" v-model="in_sno"></el-input>
            </el-row>
          </el-col>
          <el-col :span="7" style="margin-right: 20px">
            <el-row><p>姓名:</p></el-row>
            <el-row>
              <el-input v-model="in_sname"></el-input>
            </el-row>
          </el-col>
          <el-col :span="6">
            <el-row><p>班级:</p></el-row>
            <el-row>
              <el-input v-model="in_cno"></el-input>
            </el-row>
          </el-col>
        </el-row>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible2 = false">取 消</el-button>
          <el-button
            type="primary"
            @click="(dialogVisible2 = false), toUpdate()"
          >
            确 定
          </el-button>
        </span>
      </el-dialog>
      <div
        class="block"
        @click="getData()"
        @change="getData()"
        style="margin-top: 20px"
      >
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page.sync="currentPage"
          :page-size="10"
          layout="prev, pager, next, jumper"
          :total="100"
        >
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>
<script>
import global from "../../Index.vue";
export default {
  data() {
    return {
      tableData: [],
      pageNo: 1,
      currentPage: 1,
      loading: true,
      dialogVisible: false,
      dialogVisible2: false,
      in_sno: null,
      in_sname: null,
      in_cno: null,
      httpurl: global.httpurl,
    };
  },
  methods: {
    getData() {
      this.loading = true;
      let self = this;
      this.axios
        .get(self.httpurl + "/student_view/findAll/" + self.currentPage)
        .then(function (res) {
          self.tableData = res.data.content;
          self.loading = false;
        })
        .catch(function (err) {
          console.log(err);
          self.tableData = [];
        });
    },
    toDelete(row) {
      this.sno = row.sno;
      let self = this;
      this.axios
        .get(self.httpurl + "/student/delete/" + this.sno)
        .then(function (res) {
          console.log(res);
          self.getData();
        });
    },
    toAdd() {
      let self = this;
      this.axios({
        method: "POST",
        url: self.httpurl + "/student/save",
        data: { sno: this.in_sno, sname: this.in_sname, cno: this.in_cno },
      }).then(function (res) {
        console.log(res);
        if (res.data == "error") {
          alert("添加失败！");
        }
        self.getData();
      });
    },
    toUpdate() {
      let self = this;
      this.axios({
        method: "PUT",
        url: self.httpurl + "/student/update",
        data: { sno: this.in_sno, sname: this.in_sname, cno: this.in_cno },
      }).then(function (res) {
        console.log(res);
        if (res.data == "error") {
          alert("修改失败！");
        }
        self.getData();
      });
    },
    handleClose(done) {
      this.$confirm("确认关闭？")
        .then((_) => {
          done();
        })
        .catch((_) => {});
    },
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
    },
  },
  mounted() {
    this.getData();
  },
};
</script>