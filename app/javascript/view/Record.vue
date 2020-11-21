<template>
  <div>
    <Title :title="title"></Title>
    <h3>{{ thisWeekDate() }}</h3>
    <div class="study-time-circle">
      <h3 class="page-title">{{ latestTotal }}h</h3>
    </div>
    <div><font-awesome-icon :icon="['fab', 'twitter-square']"/></div>
    <!-- todo formに変更 -->
    <div class="button-section">
      <div v-if="errors.length != 0">
        <ul v-for=" e in errors" :key="e">
          <li><font color="red">{{ e }}</font></li>
        </ul>
      </div>
      <form @submit="postStudyTime">
        <v-select v-model="study.time"
          :options="options"
          label="text"
          :reduce="options => options.value"
          placeholder="select study time"
          class="style-chooser"
          id="time">
        </v-select>
        <button type="submit" class="study-time-button">register</button>
      </form>
      <!-- todo <input type="hidden">totalをもたせる -->
    </div>
    <!-- ここまで -->
  </div>
</template>

<script>
import axios from 'axios';
import Title from '../components/Title';

export default {
  components: {
    Title
  },
  data() {
    return {
      title: 'This Week Study Record',
      options: [
        { text: '0:30', value: '0.5'},
        { text: '1:00', value: '1'},
        { text: '1:30', value: '1.5'},
        { text: '2:00', value: '2'}
      ],
      latestTotal: '',
      study: {
        time: '',
        total: '19'
      },
      errors: ''
    }
  },
  mounted () {
    // 最新の合計時間をjsonで取得
    axios
      .get(
        'api/v1/studies.json'
      )
      .then(response => {
        this.latestTotal = response.data
      });
  },
  methods: {
    // 学習時間を登録する
    postStudyTime() {
      axios.post('/api/v1/studies', this.study)
      .then(response => {
        let e = response.data
        this.$router.push('/');
      })
      .catch(error => {
        console.log(error);
        if (error.response.data && error.response.data.erros) {
          this.error = error.response.data.errors;
        }
      });
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
  width: 24em;
  height: 24em;
  background: #0066FF;
  border-radius: 50%;
  margin: 2em auto;
  text-align:center;
  line-height: 24em;
}
h3.page-title {
  font-size: 3.2em;
  color: white;
}
.fa-twitter-square {
  font-size: 3.8em;
  color: rgba(29,161,242,1.00);
}
.button-section {
  width: 30em;
  margin: auto;
  margin-top: 3em;
}
.study-time-button {
  width: 9em;
  background: #0066FF;
  color: white;
  font-size: 1.8em;
  font-weight: bold;
  padding: .9em;
  border-radius: .5em;
  margin-top: 1em;
}
/* セレクトボックスレイアウト */
.style-chooser .vs__search::placeholder, /*プレースホルダー*/
.style-chooser .vs__dropdown-toggle, /*セレクトボックス全体*/
.style-chooser .vs__dropdown-menu /*ドロップダウンメニュー*/{
  background: #0066FF;
  color: white;
  font-weight: bold;
  font-size: 1.2em;
  text-align: center;
  border: none;
}
.style-chooser .vs__dropdown-menu {
  background: white;
  opacity: 0.9;
  font-size: 1.6em;
}
.style-chooser .vs__clear /* × */,
.style-chooser .vs__open-indicator/* ▽ */ {
  fill: white;
}
.style-chooser .vs__selected /*選んだオプション*/ {
  color: white;
}
/* ここまで */
</style>