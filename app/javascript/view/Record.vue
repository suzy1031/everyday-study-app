<template>
  <div>
    <Header :title="title"></Header>
    <h3>{{ thisWeekDate() }}</h3>
    <div class="study-time-circle">
      <div>
        <h3 class="page-title">{{ calcThisWeekTotal }}h</h3>
        <h3 class="page-sub-title">total：{{ userTotal.total }}h</h3>
      </div>
    </div>
    <div><font-awesome-icon :icon="['fab', 'twitter-square']"/></div>
    <div class="button-section">
      <form @submit.prevent="postStudyTime">
        <div class="select">
          <select id="time" v-model="study.time">
            <option value="">choose study time</option>
            <option value="0.5">0:30</option>
            <option value="1">1:00</option>
            <option value="1.5">1:30</option>
            <option value="2">2:00</option>
            <!-- <option v-for="option in options" :key="option.text" :value="option.value">{{option.text}}</option> -->
          </select>
        </div>
        <button v-if="this.study.time" type="submit" class="study-time-button">register</button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Header from '../components/Header';

export default {
  components: {
    Header
  },
  data() {
    return {
      title: 'Record',
      options: [
        // todo ユーザーがカスタムできるようにする時に使用
        { text: '0:30', value: '0.5'},
        { text: '1:00', value: '1'},
        { text: '1:30', value: '1.5'},
        { text: '2:00', value: '2'}
      ],
      studies: [],   // response.data格納用配列
      userTotal: '', // 最新のtotal
      study: {       // v-model
        time: '',
        total: ''
      },
      errors: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/studies')
        .then(response => {
          this.studies = response.data
          if( this.studies.length == 0 ) { // データが無い場合
            this.userTotal = [] // 空の配列を返す
            this.userTotal.total = 0 // totalに初期値「0」をセット
          } else {
            this.userTotal = response.data.slice(-1)[0] //最新のstudies.total取得
          }
        });
    }
  },
  computed: {
    // 今週の合計時間
    calcThisWeekTotal() {
      var total = 0
      const length = this.studies.length // jsonで受けった配列の数
      // 取得データの日付
      var data_date = new Date(this.userTotal.created_at) // 最新のレコードの作成日を日付型で取得
      // todo 共通処理化 今週日曜日の日付
      var today = new Date() // 日付インスタンス作成
      var this_year = today.getFullYear(); //今年
      var this_month = today.getMonth(); //今月
      var date = today.getDate(); //今日の日付
      var day_num = today.getDay(); //今日の曜日 => 添字[0,1,2,3,4,5,6] 日~土
      var this_sunday = date - day_num; //12 - 4 = 8(日)
      var start_date = new Date(this_year, this_month, this_sunday);
      // 日付を比較
      if (data_date < start_date) {
        return total
      } else {
        for(let i = 0; i < length; i++) { // 配列の数分ループ処理をする
          total += this.studies[i].time //studies[配列の数].timeをtotalに代入
        }
        return total
      }
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    // 学習時間を登録する
    postStudyTime() {
      // 入力した学習時間と最新の合計時間を計算
      var calcTotalValue = parseFloat(this.userTotal.total) + parseFloat(this.study.time)
      // 計算結果を変数に格納し、study.totalに代入する
      this.study.total = calcTotalValue;
      this.$http.secured.post('/api/v1/studies', this.study)
      .then(response => {
        let e = response.data
        // 合計時間の最新を取得 セレクトボックス初期化の為リロードする
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      })
      .catch(error => this.setError(error, 'Cantnot create'));
    },
    // 今週の日付・曜日取得メソッド
    thisWeekDate() {
      var today = new Date(); //今日の時刻
      var this_year = today.getFullYear(); //今年
      var this_month = today.getMonth(); //今月
      var date = today.getDate(); //今日の日付
      var day_num = today.getDay(); //今日の曜日 => 添字[0,1,2,3,4,5,6] 日~土
      var this_sunday = date - day_num; //12 - 4 = 8(日)
      var this_saturday = this_sunday + 6; // 9 + 5 = 14(土)
      var day = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']; // day_numを文字列に変換
      // 月曜日 11/9(Mon)
      var start_date = new Date(this_year, this_month, this_sunday);
      start_date = (start_date.getMonth() + 1) + "/" + start_date.getDate() + " (" + day[start_date.getDay()] + ")"
      // 日曜日 11/15(Sun)
      let end_date = new Date(this_year, this_month, this_saturday);
      end_date =  (end_date.getMonth() + 1) + "/" + end_date.getDate() + " (" + day[end_date.getDay()] +")"
      // 戻り値 11/9(Mon) ~ 11/15(Sun)
      var thisWeekDate = start_date + " ～ " + end_date;
      return thisWeekDate;
    }
  }
}
</script>
<style>
.study-time-circle {
  width: 22em;
  height: 22em;
  background: #0066FF;
  border-radius: 50%;
  margin: auto;
  margin-top: 1.5em;
  /* 子要素「h3」を真ん中中央揃えにする */
  display: flex;
  justify-content: center;
  align-items: center;
  /* ここまで */
}
h3.page-title {
  font-size: 3.2em;
  color: white;
}
h3.page-sub-title {
  font-size: 1.8em;
  color: white;
}
.fa-twitter-square {
  font-size: 3.8em;
  color: rgba(29,161,242,1.00);
  margin-top: .5em;
}
.button-section {
  width: 30em;
  margin: auto;
  margin-top: 2.5em;
}
.study-time-button {
  width: 9em;
  border: .15em solid #0066FF;
  background: white;
  color: black;
  font-size: 1.8em;
  padding: .4em;
  border-radius: .2em;
  margin-top: 1.5em;
}
/* セレクトボックスレイアウト */
.select {
  position: relative;
  width: 25em;
  border: #0066FF solid .2em;
  border-radius: .3em;
  margin: auto;
}
.select::after {
  position: absolute;
  top: 50%;
  right: .3em;
  margin-top: -.6em;
  content: "▼";
  color: #0066FF;
  font-size: 1.5em;
  z-index: -1;
}
.select > select {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  display: block;
  width: 100%;
  height: 2.5em;
  line-height: 2.5em;
  font-size: 1.6em;
  box-sizing: border-box;
  padding-left: .6em;
  border: none;
  background-color: transparent;
  border-radius: 0;
  outline: none;
}
/* ここまで */
</style>