<template>
  <div>
    <p id="searcharea" class="conTitle">
      <span>공지사항</span>
      <span class="fr">
        <ComCombo
          group_code="EQULIST"
          selectid="equsel"
          type="all"
          selvalue=""
          eventid="noticeequevent"
          v-model="equsel"
        />

        <ComCombo
          group_code="LECROOM"
          selectid="lecsel"
          type="all"
          selvalue=""
          eventid="lecevent"
          v-model="lecsel"
        />

        <select id="searchSel" name="searchSel" v-model="searchSel">
          <option value="">전체</option>
          <option value="title">제목</option>
          <option value="regname">등록자</option>
        </select>
        <input
          type="text"
          id="searchText"
          name="searchText"
          v-model="searchText"
          style="width: 150px; height: 25px"
        />
        <a class="btnType blue" @click="fnSearchList()" name="modal"
          ><span>검색</span></a
        >
        <template v-if="usertype == 'B' || usertype == 'C'">
          <a class="btnType blue" name="modal" @click="fnSelectNotice()"
            ><span>신규등록</span></a
          >
        </template>
      </span>
    </p>

    <div id="divNoticeList" class="divNoticeList">
      <table class="col">
        <caption>
          caption
        </caption>

        <colgroup>
          <col width="10%" />
          <col width="35%" />
          <col width="20%" />
          <col width="20%" />
          <col width="15%" />
        </colgroup>
        <thead>
          <tr>
            <th scope="col">공지 번호</th>
            <th scope="col">공지 제목</th>
            <th scope="col">조회수</th>
            <th scope="col">작성자</th>
            <th scope="col">공지 날짜</th>
          </tr>
        </thead>
        <tbody>
          <template v-if="totalcnt == 0">
            <tr>
              <td colspan="5">데이터가 업습니다.</td>
            </tr>
          </template>
          <template v-else v-for="one in datalist" :key="one.brd_no">
            <tr @click="fnSelectNotice(one.brd_no)">
              <td>{{ one.brd_no }}</td>
              <td>{{ one.brd_title }}</td>
              <td>{{ one.brd_veiws_cnt }}</td>
              <td>{{ one.brd_wt }}</td>
              <td>{{ one.brd_reg_date }}</td>
            </tr>
          </template>
        </tbody>
      </table>
    </div>

    <!-- 페이징 처리  -->
    <div class="paging_area" id="pagingnavi">
      <paginate
        class="justify-content-center"
        v-model="currntPage"
        :page-count="page()"
        :page-range="5"
        :margin-pages="0"
        :click-handler="fnSearchList"
        :prev-text="'Prev'"
        :next-text="'Next'"
        :container-class="'pagination'"
        :page-class="'page-item'"
      >
      </paginate>
    </div>
  </div>
</template>

<script>
import ComCombo from '@/components/common/ComCombo.vue';

import { openModal } from 'jenesius-vue-modal';
import noticepop from './noticePop.vue';
import Paginate from 'vuejs-paginate-next';

export default {
  data: function () {
    return {
      searchSel: '',
      searchText: '',
      usertype: this.$store.state.loginInfo.userType,
      datalist: [],
      totalcnt: 0,
      currntPage: 1,
      pageSize: 10,
      action: '',
      equsel: '',
      lecsel: '',
      popupreturn: '',
    };
  },
  computed: {},
  components: { Paginate, ComCombo },
  mounted() {
    this.fnSearchList();

    console.log('usertype : ' + this.usertype);
  },
  methods: {
    fnSelectNotice: async function (brdno) {
      console.log('fnSelectNotice : ' + brdno);

      if (brdno == null || brdno == '') {
        this.action = 'I';

        const modal = await openModal(noticepop, {
          brdno: '',
          action: this.action,
          handleRequest: (value) => {
            console.log(value);
            this.popupreturn = value;
          },
        });

        modal.onclose = () => {
          //alert('등록 닫음');
          this.fnSearchList();
          //return false; //Modal will not be closed
        };
      } else {
        console.log(brdno);

        this.action = 'U';
        const modal = await openModal(noticepop, {
          brdno: brdno,
          action: this.action,
          handleRequest: (value) => {
            console.log(value);
            this.popupreturn = value;
          },
        });

        modal.onclose = () => {
          //alert('수정 닫음');
          this.fnSearchList();

          if (this.popupreturn == 'U') {
            console.log('수정 조회');
            this.fnSearchList(this.currentPage);
          } else {
            console.log('삭제 조회');
            this.fnSearchList(this.currentPage);
          }

          //return false; //Modal will not be closed
        };
      }
    },
    fnSearchList: function () {
      this.equsel = '3';

      this.lecsel = '3';

      console.log('equsel : ' + this.equsel);

      this.emitter.emit('noticeequevent', this.equsel);

      this.emitter.emit('lecevent', this.lecsel);

      let vm = this;

      // for 페이징 넘버 클릭시를 위함
      let params = new URLSearchParams();
      params.append('searchSel', this.searchSel);
      params.append('searchText', this.searchText);
      params.append('searchDel', '');
      params.append('currntPage', this.currntPage);
      params.append('pageSize', this.pageSize);

      this.axios
        .post('/notice/listNoticevue.do', params)
        .then(function (response) {
          console.log(response);

          vm.datalist = response.data.listNotice;
          vm.totalcnt = response.data.totalCnt;
        })
        .catch(function (error) {
          alert('에러! API 요청에 오류가 있습니다. ' + error);
        });
    },
    page: function () {
      let total = this.totalcnt;
      let page = this.pageSize;
      let xx = total % page;
      let result = parseInt(total / page);

      if (xx == 0) {
        return result;
      } else {
        result = result + 1;
        return result;
      }
    },
  },
  beforeUnmount() {
    alert('beforeUnmount');
    this.emitter.off('noticeequevent');
    this.emitter.off('lecevent');
  },
};
</script>
