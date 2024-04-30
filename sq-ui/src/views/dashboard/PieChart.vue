<template>
  <div :class="className" :style="{height:height,width:width}"/>
</template>

<script>
import echarts from 'echarts'

require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'
import {bookRankAPI} from '@/api/echarts/echarts'

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
      bookRank: [],
    }
  },
  computed: {
    sortedItems() {
      return this.bookRank.sort((b, a) => a.value - b.value);
    },
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
          let j = {
            value: item.readNum,
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
          trigger: 'item',
          formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
          left: 'center',
          bottom: '10',
          // data: ['Industries', 'Technology', 'Forex', 'Gold', 'Forecasts']
        },

        series: [
          {
            name: '阅读总数',
            type: 'pie',
            roseType: 'radius',
            radius: [15, 95],
            center: ['50%', '38%'],
            data: this.sortedItems,
            animationEasing: 'cubicInOut',
            animationDuration: 2600
          }
        ]
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
