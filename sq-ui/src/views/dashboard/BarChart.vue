<template>
  <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import echarts from 'echarts'
require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'
import {bookRankAPI} from '@/api/echarts/echarts'
const animationDuration = 6000

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
      xAxisData: [],
      likeData: [],
      commentData: [],
      collectNumData: [],
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
        for (let i = 0; i < res.data.length; i++) {
          let item = res.data[i]
          this.xAxisData.push(item.bookName)
          this.likeData.push(item.applaudNum)
          this.commentData.push(item.commentNum)
          this.collectNumData.push(item.collectNum)
        }
        console.log(this.xAxisData)
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
        grid: {
          top: 10,
          left: '2%',
          right: '2%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: [{
          type: 'category',
          data: this.xAxisData,
          axisTick: {
            alignWithLabel: true
          },
          axisLabel:{
            interval: 0,
            formatter:function(value){
              let len = value.length;
              let length = 4; //控制一行显示个数
              let num = Math.ceil(len/length);//循环次数
              if(num > 1){
                let str = '';
                for(let i = 0;i<num;i++){
                  str += value.substring(i*length,(i+1)*length) + '\n';
                }
                return str;
              }else{
                return value;
              }
            }
          }
        }],
        yAxis: [{
          type: 'value',
          axisTick: {
            show: false
          }
        }],
        series: [{
          name: '评论数',
          type: 'bar',
          stack: 'vistors',
          barWidth: '40%',
          data: this.commentData,
          animationDuration
        }, {
          name: '喜欢数',
          type: 'bar',
          stack: 'vistors',
          barWidth: '40%',
          data: this.likeData,
          animationDuration
        }, {
          name: '加入书架数',
          type: 'bar',
          stack: 'vistors',
          barWidth: '40%',
          data: this.collectNumData,
          animationDuration
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
      }, 1000);
    }
  }
}
</script>
