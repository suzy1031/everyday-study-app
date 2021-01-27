<template>
  <div>
    <Header :title="title"></Header>
    <div class="tab-contents margin-top_3">
      <!-- todo tab クリックイベントでactiveクラスを付与する -->
      <span class="tab-text active">Week</span>
      <span class="tab-text">Month</span>
      <span class="tab-text">Year</span>
    </div>
    <Chart class="chart" v-if="loaded" :chartData="chartData" :options="options"/>
  </div>
</template>

<script>
import Header from '../components/Header';
import Chart from '../components/Chart';
import Const from '../const/const';

export default {
  components: {
    Header,
    Chart
  },
  data() {
    return {
      title: "History",
      histories: [],
      loaded: false,
      chartData: { labels: [], datasets: [] },
      options: {
        responsive: true,
        maintainAspectTatio: false,
        legend: {
          display: false
        },
        scales: {
          xAxes: [{
            display: true,
            stacked: false,
            gridLines: {
              display: false
            }
          }],
          yAxes: [{
            ticks: {
              beginAtZero: true,
              stepSize: 0.5
            },
            gridLines: {
              drawBorder: false
            }
          }]
        }
      }
    }
  },
  mounted () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/histories')
      .then(response => {
        this.histories = response.data
        this.fillData()
      })
      .catch(error => {
        this.setError(error, 'Something went wrong')
        delete localStorage.csrf
        delete localStorage.signedIn
        this.$router.replace('/')
      })
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    // グラフのデータ加工
    arrayData () {
      var getData = this.histories;
      if(getData.length < Const.INT_SEVEN) {
        // (A)比較用の配列を作成する
        const arrayDayOfWeek = getData.map(item => item.day_of_week)
        // (B)比較対象の配列を用意する
        const arraySeven = [0, 1, 2, 3, 4, 5, 6]
        // (A)と(B)を比較して差分を求める
        var resultArray = arraySeven.filter(i => arrayDayOfWeek.indexOf(i) == -1)
        // 差分として返ってきた結果をindexに当てはめる
        for(var i = 0; i < resultArray.length; i++) {
          getData.splice(resultArray[i], 0, {time: 0})
        };
      }
      const times = getData.map(item => item.time)
      return times
    },
    // グラフデータを表示
    fillData () {
      this.loaded = false
      var data = this.arrayData()
      this.chartData = {
        labels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        datasets: [
          {
            barPercentage: 0.8,
            backgroundColor: '#0066FF',
            data: data
          }
        ]
      }
      this.loaded = true
    },
  }
}
</script>

<style>
.tab-contents {
  margin: 0 auto;
}
.tab-text {
  font-size: 1.8em;
  padding: 0 1em;
}
.active {
  border: .15em solid #0066FF;
  border-radius: .2em;
}
.chart {
  padding: 3em;
}
</style>