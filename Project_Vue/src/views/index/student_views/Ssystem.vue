<template>
  <div class="setting">
    <el-tabs type="border-card" style="margin: 20px; height: 500px">
      <el-tab-pane label="账户管理">
        <el-upload
          class="avatar-uploader"
          action="https://jsonplaceholder.typicode.com/posts/"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
        >
          <img v-if="imageUrl" :src="imageUrl" class="avatar" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
        <p style="margin-left: 25px">账号：{{ global.isNum }}</p>
        <el-button
          @click="(dialogVisible = true), (in_password = null)"
          style="margin: 20px"
        >
          修改密码
        </el-button>
      </el-tab-pane>
      <el-tab-pane label="其他">其他</el-tab-pane>
      <el-tab-pane label="其他">其他</el-tab-pane>
      <el-tab-pane label="其他">其他</el-tab-pane>
    </el-tabs>
    <el-dialog
      title="修改密码"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose"
    >
      <el-row>
        <el-col :span="6">
          <el-row><p>新密码:</p></el-row>
          <el-row>
            <el-input v-model="in_password"></el-input>
          </el-row>
        </el-col>
      </el-row>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="(dialogVisible = false), toUpdate()">
          确 定
        </el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  margin: 20px;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  line-height: 100px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>

<script>
import global from "../../Index.vue";
export default {
  data() {
    return {
      imageUrl: "",
      tableData: [],
      pageNo: 1,
      currentPage: 1,
      loading: true,
      value: 50,
      dialogVisible: false,
      in_password: null,
      httpurl: global.httpurl,
      global,
    };
  },
  methods: {
    getData() {
      this.loading = true;
      let self = this;
      this.axios
        .get(self.httpurl + "/power/findAll/" + self.currentPage)
        .then(function (res) {
          self.tableData = res.data.content;
          self.loading = false;
        })
        .catch(function (err) {
          console.log(err);
          self.tableData = [];
        });
      console.log("ok");
    },
    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === "image/jpeg";
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error("上传头像图片只能是 JPG 格式!");
      }
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 2MB!");
      }
      return isJPG && isLt2M;
    },
    formatTooltip(val) {
      return val / 100;
    },
    toUpdate() {
      let self = this;
      this.axios({
        method: "PUT",
        url: self.httpurl + "/power/update",
        data: { num: global.isNum, password: this.in_password },
      }).then(function (res) {
        console.log(res);
        if (res.data == "error") {
          alert("修改失败！");
        } else {
          alert("修改成功！");
        }
      });
    },
    handleClose(done) {
      this.$confirm("确认关闭？")
        .then((_) => {
          done();
        })
        .catch((_) => {});
    },
  },
  mounted() {
    this.getData();
  },
};
</script>