<template>
  <form id="myForm" action="" method="">
    <div id="noticePop" style="width: 600px">
      <dl>
        <dt>
          <strong>공지사항 등록</strong>
        </dt>
        <dd class="content">
          <!-- s : 여기에 내용입력 -->
          <table class="row">
            <caption>
              caption
            </caption>
            <colgroup>
              <col width="120px" />
              <col width="*" />
              <col width="120px" />
              <col width="*" />
            </colgroup>

            <tbody>
              <tr>
                <th scope="row">등록 일자</th>
                <td id="regdate" v-text="regdate"></td>
                <th scope="row">조회수</th>
                <td id="viewcnt" v-text="viewcnt"></td>
              </tr>
              <tr>
                <th scope="row">공지 제목 <span class="font_red">*</span></th>
                <td colspan="3">
                  <input
                    type="text"
                    class="inputTxt p100"
                    name="brd_title"
                    id="brd_title"
                    :readonly="!isreadonly"
                    v-model="brd_title"
                  />
                </td>
              </tr>
              <tr>
                <th scope="row">공지내용 <span class="font_red">*</span></th>
                <td colspan="3">
                  <textarea
                    name="brd_ctt"
                    id="brd_ctt"
                    rows="5"
                    cols="30"
                    :readonly="!isreadonly"
                    v-model="brd_ctt"
                  ></textarea>
                </td>
              </tr>
              <tr>
                <th scope="row">첨부파일 <span class="font_red">*</span></th>
                <td>
                  <input
                    type="file"
                    id="selfile"
                    name="selfile"
                    @change="selimg"
                  />
                </td>
                <td colspan="">
                  <div
                    id="preview"
                    @click="download()"
                    v-html="previewhtml"
                  ></div>
                </td>
              </tr>
            </tbody>
          </table>

          <!-- e : 여기에 내용입력 -->

          <div class="btn_areaC mt30">
            <a class="btnType blue" id="btnSave" name="btn" @click="save()"
              ><span>저장</span></a
            >
            <a
              class="btnType blue"
              id="btnDelete"
              name="btn"
              v-show="delflag"
              @click="deletenot()"
              ><span>삭제</span></a
            >
            <a class="btnType gray" id="btnClose" name="btn" @click="closeopup"
              ><span>취소</span></a
            >
          </div>
        </dd>
      </dl>
      <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
  </form>
</template>

<script>
import { closeModal } from 'jenesius-vue-modal';

export default {
  props: { brdno: String, action: String },
  data: function () {
    return {
      brd_title: '',
      brd_ctt: '',
      selnoticecd: '',
      regdate: '',
      viewcnt: '',
      selfile: '',
      delflag: false,
      isreadonly: false,
      usertype: this.$store.state.loginInfo.userType,
      swriter: this.$store.state.loginInfo.loginId,
      previewhtml: '',
      sm_file_extend: '',
      sm_file_logicalpath: '',
      sm_file_nm: '',
      sm_file_size: 0,
      paction: this.action,
    };
  },
  computed: {},
  components: {},
  mounted() {
    console.log(' action : ' + this.action + ' brdno : ' + this.brdno);

    if (this.action == 'I') {
      this.init();
    } else {
      let vm = this;

      let params = new URLSearchParams();
      params.append('brd_no', this.brdno);

      this.axios
        .post('/notice/selectNotice.do', params)
        .then(function (response) {
          //console.log(response);

          vm.init(response.data.sectInfo);
        })
        .catch(function (error) {
          alert('에러! API 요청에 오류가 있습니다. ' + error);
        });
    }
  },
  methods: {
    deletenot: function () {
      this.paction = 'D';
      this.save();
    },
    validation: function () {
      if (this.brd_title == '' || this.brd_title == null) {
        alert('제목을 입력해 주세요.');
        return false;
      }

      if (this.brd_ctt == '' || this.brd_ctt == null) {
        alert('내용을 입력해 주세요.');
        return false;
      }

      return true;
    },
    save: function () {
      if (this.validation()) {
        //let params = new URLSearchParams();
        //params.append('brd_no', this.selnoticecd);

        let frm = document.getElementById('myForm');
        frm.enctype = 'multipart/form-data';
        let fileData = new FormData(frm);

        if (this.paction == 'D') {
          fileData.append('action', this.paction);
        } else {
          fileData.append('action', this.action);
        }

        fileData.append('brd_no', this.selnoticecd);

        this.axios({
          url: '/notice/noticedownload.do', // File URL Goes Here
          data: fileData,
          method: 'POST',
          responseType: 'blob',
        }).then((res) => {
          console.log(JSON.stringify(res));

          if (res.status == '200') {
            alert(res.data.resultMsg + ' 되었습니다.');
            closeModal();
          }
        });
      }
    },
    download: function () {
      let params = new URLSearchParams();
      params.append('brd_no', this.selnoticecd);

      this.axios({
        url: '/notice/noticedownload.do', // File URL Goes Here
        data: params,
        method: 'POST',
        responseType: 'blob',
      }).then((res) => {
        console.log(res);
        var FILE = window.URL.createObjectURL(new Blob([res.data]));
        console.log('FILE : ' + FILE);
        var docUrl = document.createElement('a');
        docUrl.href = FILE;
        docUrl.setAttribute('download', this.sm_file_nm);
        document.body.appendChild(docUrl);
        docUrl.click();
      });
    },
    closeopup: function () {
      closeModal();
    },
    selimg: function (event) {
      let image = event.target;
      console.log(image);

      if (image.files[0]) {
        let filePath = image.value;

        //전체경로를 \ 나눔.
        let filePathSplit = filePath.split('\\');

        //전체경로를 \로 나눈 길이.
        let filePathLength = filePathSplit.length;
        //마지막 경로를 .으로 나눔.
        let fileNameSplit = filePathSplit[filePathLength - 1].split('.');
        //파일명 : .으로 나눈 앞부분
        let fileName = fileNameSplit[0];
        //파일 확장자 : .으로 나눈 뒷부분
        let fileExt = fileNameSplit[1];
        //파일 크기
        let fileSize = image.files[0].size;

        console.log('파일 경로 : ' + filePath);
        console.log('파일명 : ' + fileName);
        console.log('파일 확장자 : ' + fileExt);
        console.log('파일 크기 : ' + fileSize);

        if (
          fileExt == 'jpg' ||
          fileExt == 'png' ||
          fileExt == 'gif' ||
          fileExt == 'jpeg'
        ) {
          this.previewhtml =
            "<img src='" +
            window.URL.createObjectURL(image.files[0]) +
            "'  style='width: 100px; height: 100px;' />";
        } else {
          this.previewhtml = '';
        }
      }
    },
    init: function (obj) {
      if (this.action == 'I') {
        this.brd_title = '';
        this.brd_ctt = '';
        this.selnoticecd = this.brdno;
        this.regdate = '';
        this.viewcnt = '';
        this.selfile = '';
        this.delflag = false;
        this.isreadonly = false;
        this.previewhtml = '';
      } else {
        console.log(obj);

        this.brd_title = obj.brd_title;
        this.brd_ctt = obj.brd_ctt;
        this.selnoticecd = this.brdno;
        this.regdate = obj.brd_reg_date;
        this.viewcnt = obj.brd_veiws_cnt;
        this.selfile = '';
        this.delflag = false;
        this.isreadonly = false;
        this.sm_file_extend = obj.sm_file_extend;
        this.sm_file_logicalpath = obj.sm_file_logicalpath;
        this.sm_file_nm = obj.sm_file_nm;
        this.sm_file_size = obj.sm_file_size;

        //obj.sm_file_extend;
        //obj.sm_file_logicalpath;
        //obj.sm_file_nm;
        //obj.sm_file_size;

        let inhtml = '';

        if (obj.sm_file_nm == '' || obj.sm_file_nm == null) {
          inhtml += '';
        } else {
          if (
            obj.sm_file_extend == 'jpg' ||
            obj.sm_file_extend == 'png' ||
            obj.sm_file_extend == 'gif' ||
            obj.sm_file_extend == 'jpeg'
          ) {
            inhtml +=
              "<img src='" +
              obj.sm_file_logicalpath +
              "'  style='width: 100px; height: 100px;' />";
          } else {
            //console.log("이미지 파일 아님 : " + data.sm_file_nm);
            inhtml += obj.sm_file_nm;
            inhtml += '(' + obj.sm_file_size + ')';
          }
        }

        this.previewhtml = inhtml;
      }
    },
  },
};
</script>
