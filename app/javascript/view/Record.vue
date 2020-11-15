<template>
  <div>
    <Title :title="title"></Title>
    <h3>{{ thisWeekDate() }}</h3>
    <div class="study-time-circle">
      <h3 class="page-title">10h30m</h3>
    </div>
    <div><font-awesome-icon :icon="['fab', 'twitter-square']"/></div>
    <!-- todo formに変更 -->
    <div class="button-section">
      <form>
        <div class="custom-select">
          <label for="select-choice1" class="label select-1"><span class="selection-choice">select study time</span></label>
          <select v-model="time" id="time" class="select">
            <option v-for="option in options" v-bind:value="option.value" :key="option.value">
              {{ option.text }}
            </option>
          </select>
        </div>
        <button type="submit" class="study-time-button" @click="postStudyTime">register</button>
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
      time:'0.5',
      options: [
        { text: '0:30', value: '0.5'},
        { text: '1:00', value: '1'},
        { text: '1:30', value: '1.5'},
        { text: '2:00', value: '2'}
      ],
      title: 'This Week Study Record',
    }
  },
  methods: {
    postStudyTime() {
      axios.post(
        'https://firestore.googleapis.com/v1/projects/everyday-study/databases/(default)/documents/times',
        {
          fields: {
            time: {
              doubleValue: this.time
            }
          }
        }
      ).then(response => {
        console.log(response);
      })
      .catch(error => {
        console.log(error);
      });
    },
    // 今週の日付・曜日取得メソッド
    thisWeekDate() {
      var today = new Date(); //今日の時刻
      var this_year = today.getFullYear(); //今年
      var this_month = today.getMonth(); //今月
      var date = today.getDate(); //今日の日付
      var day_num = today.getDay(); //今日の曜日 => 添字[0,1,2,3,4,5,6] 日~土
      var this_monday = date - day_num + 1; //12 - 4 + 1 = 9(月)
      var this_sunday = this_monday + 6; // 9 + 6 = 15(日)
      var day = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']; // day_numを文字列に変換
      // 月曜日 11/9(Mon)
      var start_date = new Date(this_year, this_month, this_monday);
      start_date = (start_date.getMonth() + 1) + "/" + start_date.getDate() + " (" + day[start_date.getDay()] + ")"
      // 日曜日 11/15(Sun)
      let end_date = new Date(this_year, this_month, this_sunday);
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
  width: 150px;
  height: 150px;
  background: #0066FF;
  border-radius: 50%;
  margin: 20px auto;
  text-align:center;
  line-height: 150px;
}
h3.page-title {
  font-size: 32px;
  color: white;
}
.fa-twitter-square {
  font-size: 38px;
  color: rgba(29,161,242,1.00);
}
.button-section {
  width: 300px;
  margin: auto;
  margin-top: 30px;
}
.study-time-button {
  width: 160px;
  background: #0066FF;
  color: white;
  font-size: 18px;
  font-weight: bold;
  padding: .9em;
  border-radius: .5em;
  margin-top: 10px;
}
/* セレクトボックスレイアウト */
.custom-select {
  position : relative;
  width: 100%;
  margin: 20px auto;
  cursor: pointer;
}
.select, .label {
  display: block;
}
.select {
  width: 100%;
  position: absolute;
  top: 0;
  opacity: 0;
}
.selection-choice {
  color: white;
  font-weight: bold;
  font-size: 18px;
}
.label {
  position: relative;
  padding: 0.9em;
  border-radius: .5em;
  cursor: pointer;
  color: white;
}
.label::after {
  content: "▼";
  position: absolute;
  right: 0;
  top: 0;
  padding: 1em;
  border-left: 1px solid white;
}
.select-1 {
  background: #0066FF;
}
/* ここまで */
</style>