<template>
  <div :class="className" :style="{height:height,width:width}"/>
</template>

<script>
import echarts from 'echarts'

require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'
import {bookRankAPI} from '@/api/echarts/echarts'

const animationDuration = 5000

export default {
  mixins: [resize],
  props: {
    className: {
      type: String,
      default: 'chart'
    },
    width: {
      type: String,
      default: '100%'
    },
    height: {
      type: String,
      default: '400px'
    }
  },
  data() {
    return {
      chart: null,
      bookRank: []
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.getbookRank()
    })
  },
  beforeDestroy() {
    if (!this.chart) {
      return
    }
    this.chart.dispose()
    this.chart = null
  },
  methods: {
    getbookRank() {
      bookRankAPI().then(res => {
        let index = 6
        for (let i = 0; i < res.data.length; i++) {
          let item = res.data[i]
          let j = {
            value: [index--, item.readNum, item.commentNum, item.collectNum, item.applaudNum],
            name: item.bookName
          }
          this.bookRank.push(j)
        }
        this.initChart()
      })

    },
    initChart() {
      this.chart = echarts.init(this.$el, 'macarons')
      this.chart.setOption({
        tooltip: {
          trigger: 'axis',
          axisPointer: { // 坐标轴指示器，坐标轴触发有效
            type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
          }
        },
        radar: {
          radius: '66%',
          center: ['50%', '42%'],
          splitNumber: 8,
          splitArea: {
            areaStyle: {
              color: 'rgba(127,95,132,.3)',
              opacity: 1,
              shadowBlur: 45,
              shadowColor: 'rgba(0,0,0,.5)',
              shadowOffsetX: 0,
              shadowOffsetY: 15
            }
          },
          indicator: [
            {name: '排名'},
            {name: '阅读数'},
            {name: '评论数'},
            {name: '加入书架数'},
            {name: '喜欢数'}
          ]
        },
        legend: {
          left: 'center',
          bottom: '10'
        },
        series: [{
          type: 'radar',
          symbolSize: 0,
          areaStyle: {
            normal: {
              shadowBlur: 13,
              shadowColor: 'rgba(0,0,0,.2)',
              shadowOffsetX: 0,
              shadowOffsetY: 10,
              opacity: 1
            }
          },
          data: this.bookRank,
          animationDuration: animationDuration
        }]
      })
      let count = 0;
      setInterval(() => {
        this.chart.dispatchAction({
          type: 'downplay',
          seriesIndex: 0,
          dataIndex: count
        });
        count++;
        if (count === 5) {
          count = 0;
        }
        this.chart.dispatchAction({
          type: 'highlight',
          seriesIndex: 0,
          dataIndex: count
        });
      }, 3000);
    }
  }
}
</script>
