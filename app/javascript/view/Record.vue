<template>
  <div>
    <Header :title="title"></Header>
    <h3>{{ thisWeekDate() }}</h3>
    <!-- circle progress bar -->
    <div class="circle-position">
      <!-- 右側の180度分の領域 -->
      <div class="square position-right_0">
        <transition>
        <div :style="rightAngle" class="square square-transform-right" v-if="this.goals.target_time">
          <div class="circle position-left_0"></div>
        </div>
        </transition>
      </div>
      <!-- ここまで -->
      <!-- 円中心のテキスト -->
      <div class="circle-position-center">
        <div class="margin-top_5">
          <h2 :style="overHundred">{{ percentAchivement || 0 }}%</h2>
          <h3 class="until-achivement-text">{{ untilAchivement }}h</h3>
          <h3>week：{{ calcThisWeekTotal }}h</h3>
          <h3>total：{{ userTotal.total }}h</h3>
        </div>
      </div>
      <!-- ここまで -->
      <!-- 左側の180度分の領域 -->
      <div class="square position-left_0">
        <transition>
        <div :style="leftAngle" class="square square-transform-left" v-if="this.goals.target_time">
          <div class="circle position-right_0"></div>
        </div>
        </transition>
      </div>
      <!-- ここまで -->
    </div>
    <!-- ここまで -->
    <div><font-awesome-icon :icon="['fab', 'twitter-square']"/></div>
    <div class="button-section margin-top_3">
      <form @submit.prevent="postStudyTime">
        <div class="select">
          <select id="time" v-model="study.time" required="required">
            <option value="">choose study time</option>
            <option value="0.5">0:30</option>
            <option value="1">1:00</option>
            <option value="1.5">1:30</option>
            <option value="2">2:00</option>
            <!-- <option v-for="option in options" :key="option.text" :value="option.value">{{option.text}}</option> -->
          </select>
        </div>
        <button type="submit" class="study-time-button margin-top_1_half">register</button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Header from '../components/Header';
import Const from '../const/const';

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
      goals: '',
      studies: [],   // response.data格納用配列
      userTotal: '', // 最新のtotal
      study: {       // v-model
        time: '',
        total: ''
      },
      errors: '',
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      // 今週の学習時間を取得
      this.$http.secured.get('/api/v1/studies')
        .then(response => {
          this.studies = response.data
          if( this.studies.length == Const.INT_ZERO ) { // データが無い場合
            this.userTotal = [] // 空の配列を返す
            this.userTotal.total = Const.INT_ZERO // totalに初期値「0」をセット
          } else {
            this.userTotal = response.data.slice(-1)[Const.INT_ZERO] //最新のstudies.total取得
          }
        });
      // ユーザーが登録している目標学習時間を取得
      this.$http.secured.get('/api/v1/goals')
        .then(response => {
          this.goals = response.data
          if (this.goals.length == Const.INT_ZERO) {
            this.goals = []
            this.goals.target_time = Const.INT_ZERO
          }else {
            this.goals = response.data[Const.INT_ZERO]
          }
        });
    }
  },
  computed: {
    // 今週の合計時間
    calcThisWeekTotal() {
      var total = Const.INT_ZERO;
      const length = this.studies.length; // jsonで受けった配列の数
      // 取得データの日付
      var data_date = new Date(this.userTotal.created_at); // 最新のレコードの作成日を日付型で取得
      var today = new Date();
      var this_year = today.getFullYear();
      var this_month = today.getMonth();
      var date = today.getDate();
      var day_num = today.getDay();
      var this_sunday = date - day_num;
      var start_date = new Date(this_year, this_month, this_sunday);
      // 日付を比較
      if (data_date < start_date) {
        return total
      } else {
        for(let i = Const.INT_ZERO; i < length; i++) { // 配列の数分ループ処理をする
          total += this.studies[i].time //studies[配列の数].timeをtotalに代入
        }
        return total
      }
    },
    // 学習時間（h）=> 達成率（%）への計算
    // return 現在の達成度 = 今週の学習時間 / 目標学習時間 * 100
    percentAchivement() {
      // NaN対策
      if(this.goals.target_time == undefined) {
        return Const.INT_ZERO
      }
      var percent = this.calcThisWeekTotal / this.goals.target_time * 100;
      // 小数点第1位までを返す(近似値)
      return percent.toFixed(Const.INT_ONE)
    },
    // 学習時間による角度の計算
    // 返り値 現在の角度 = 360 * 現在の達成度 / 100
    currentAngle() {
      return Math.floor(360 * this.percentAchivement / 100);
    },
    // 半円(右側の180度分)への角度の適用
    rightAngle() {
      var angle = Math.min(this.currentAngle, 180);
      return {
        "transform": "rotate(" + angle + "deg)",
      }
    },
    // 左側の半円(左側の180度分)
    leftAngle() {
      var angle = Math.min(Math.max(this.currentAngle-180, Const.INT_ZERO), 180);
      return {
        "transform": "rotate(" + angle +"deg)",
      }
    },
    // 達成まで残り時間数を計算
    untilAchivement() {
      // NaN対策
      if(this.goals.target_time == undefined) {
        return Const.INT_ZERO
      }
      var leftStudyTime = this.calcThisWeekTotal - this.goals.target_time;
      // 残り学習時間が0以上の時は「+」を頭に付ける
      if(leftStudyTime > Const.INT_ZERO) {
        return "+" + leftStudyTime
      }
      return leftStudyTime
    },
    // 達成率100%以上はstyle変更
    overHundred() {
      if(this.percentAchivement >= 100 ) {
        return {
          "color": "#0066FF",
        }
      }
    },
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    // 学習時間を登録する
    postStudyTime() {
      // 入力した学習時間と最新の合計時間を計算
      var calcTotalValue = parseFloat(this.userTotal.total) + parseFloat(this.study.time);
      // 計算結果を変数に格納し、study.totalに代入する
      this.study.total = calcTotalValue;
      this.$http.secured.post('/api/v1/studies', this.study)
      .then(response => {
        // let e = response.data
        this.studies.push(response.data)
        // 合計時間の最新を取得 セレクトボックス初期化の為リロードする
        // this.$router.go({path: this.$router.currentRoute.path, force: true})
      })
      .catch(error => this.setError(error, 'Cant not create'));
    },
    // 今週の日付・曜日取得メソッド
    thisWeekDate() {
      var today = new Date(); //今日の時刻
      var this_year = today.getFullYear(); //今年
      var this_month = today.getMonth(); //今月
      var date = today.getDate(); //今日の日付
      var day_num = today.getDay(); //今日の曜日 => 添字[0,1,2,3,4,5,6] 日~土
      var this_sunday = date - day_num; //12 - 4 = 8(日)
      var this_saturday = this_sunday + Const.INT_SIX; // 9 + 5 = 14(土)
      var day = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']; // day_numを文字列に変換
      // 月曜日 11/9(Mon)
      var start_date = new Date(this_year, this_month, this_sunday);
      start_date = (start_date.getMonth() + Const.INT_ONE) + "/" + start_date.getDate() + " (" + day[start_date.getDay()] + ")"
      // 日曜日 11/15(Sun)
      let end_date = new Date(this_year, this_month, this_saturday);
      end_date =  (end_date.getMonth() + Const.INT_ONE) + "/" + end_date.getDate() + " (" + day[end_date.getDay()] +")"
      // 戻り値 11/9(Mon) ~ 11/15(Sun)
      var thisWeekDate = start_date + " ～ " + end_date;
      return thisWeekDate
    }
  }
}
</script>
<style>
:root {
  --px-10: 10px;
  --px-200: 200px;
  --percent-50: 50%;
  --percent-100: 100%;
  --main-color: #0066FF;
}
.v-enter {
  opacity: 0;
}
.v-enter-to {
  opacity: 1;
}
.v-enter-active {
  transition: all 500ms;
}
/* progress bar */
.circle-position {
  position: relative;
  width: var(--px-200);
  height: var(--px-200);
  margin: 3em auto;
}
.square{
  position: absolute;
  width:100px;
  height: var(--px-200);
  overflow:hidden;
}
.square-transform-right {
  right: var(--percent-100);
  transform-origin: var(--percent-100) var(--percent-50);
}
.square-transform-left {
  left: var(--percent-100);
  transform-origin: 0 var(--percent-50);
}
.circle{
  position:absolute;
  width: var(--px-200);
  height: var(--px-200);
  border-radius: var(--percent-50);
  border: var(--px-10) solid var(--main-color);
  box-sizing: border-box;
}
.circle-position-center {
  position: absolute;
  width: var(--px-200);
  text-align: center;
  font-weight: bold;
}
h3.until-achivement-text {
  color: grey;
}
.fa-twitter-square {
  font-size: 3.8em;
  color: rgba(29,161,242,1.00);
}
.button-section {
  width: 30em;
  margin: 0 auto;
}
.study-time-button {
  width: 9em;
  border: .15em solid var(--main-color);
  background: white;
  color: black;
  font-size: 1.8em;
  padding: .4em;
  border-radius: .2em;
}
/* セレクトボックスレイアウト */
.select {
  position: relative;
  width: 25em;
  border: .2em solid var(--main-color);
  border-radius: .3em;
  margin: auto;
}
.select::after {
  position: absolute;
  top: var(--percent-50);
  right: .3em;
  margin-top: -.6em;
  content: "▼";
  color: var(--main-color);
  font-size: 1.5em;
  z-index: -1;
}
.select > select {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  display: block;
  width: var(--percent-100);
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