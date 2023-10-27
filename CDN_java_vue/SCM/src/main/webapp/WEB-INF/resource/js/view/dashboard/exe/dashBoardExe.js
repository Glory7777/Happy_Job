
$(function() {

	// 세가지 차트에 쓸 데이터 가져오기
	fn_ChartData();

});

function fn_ChartData(){
	
	var resultCallback = function(data) {
		
		fn_lineChart(data.lineChart);
		fn_barChart(data.barChart);		
	};
	
	callAjax("/dashboard/exe/dashboardExe.do", "post", "json", true, null, resultCallback);
	
}

//이번 달의 년도와 월 가져오기
var currentDate = new Date();

var currentYear = currentDate.getFullYear();
var currentMonth = currentDate.getMonth() + 1;

function fn_lineChart(data) {

	var profit = new Array();
	
	profit = data;

    var totalProfit = 0;
	// month_profit 값들의 평균 계산
	for(var i = 0; i< profit.length; i++){
		totalProfit += parseInt(profit[i].month_profit,10);
		console.log(totalProfit);
	}
	
	var averageProfit = totalProfit / profit.length;
	averageProfit = averageProfit.toFixed(0); // 소수점 0자리까지 반올림
	console.log("평균값" + JSON.stringify(averageProfit));
	
	var averageString = "평균매출" + averageProfit + "(만원)"
	
	
	// 최고 최저치 기록한 달 찾기 
	
	var minProfit = parseInt(profit[0].month_profit, 10); // 초기값 설정
	var maxProfit = parseInt(profit[0].month_profit, 10); // 초기값 설정
	var minMonth = profit[0].month;
	var maxMonth = profit[0].month;

	for (var i = 1; i < profit.length; i++) {
	    var currentProfit = parseInt(profit[i].month_profit, 10);

	    // 최소값 찾기
	    if (currentProfit < minProfit) {
	        minProfit = currentProfit;
	        minMonth = profit[i].month;
	    }

	    // 최대값 찾기
	    if (currentProfit > maxProfit) {
	        maxProfit = currentProfit;
	        maxMonth = profit[i].month;
	    }
	}

	console.log("최소값:", minProfit, "월:", minMonth);
	console.log("최대값:", maxProfit, "월:", maxMonth);

    
	var options = {
            series: [{
              name: "월간 매출",
              data: [10, 41, 35, 51, 49, 62, 69, 91, 148]
          }],
            chart: {
            height: 350,
            type: 'line',
            zoom: {
              enabled: false
            }
          },
          dataLabels: {
            enabled: false
          },
          stroke: {
            curve: 'straight'
          },
          title: {
            text: '총 매출',
            align: 'left'
          },
          subtitle: {
              text: '단위(만원)',
              align: 'right',
          },
          grid: {
            row: {
              colors: ['#f3f3f3', 'transparent'],
              opacity: 0.5
            },
          },
          xaxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
          },
          annotations: {
              yaxis: [{
                y: averageProfit,
                borderColor: '#0802A3',
                label: {
                  borderColor: '#0802A3',
                  style: {
                    color: '#fff',
                    background: '#0802A3',
                  },
                  text: averageString,
                }
              },
              {
              y: maxProfit,
              borderColor: '#A2CDB0',
              label: {
                borderColor: '#A2CDB0',
                style: {
                  color: '#fff',
                  background: '#A2CDB0',
                },
                text: "최고매출",
              }
            }],
              xaxis: [{
                  x: minMonth,
                  strokeDashArray: 0,
                  borderColor: '#C63D2F',
                  label: {
                    borderColor: '#C63D2F',
                    style: {
                      color: '#fff',
                      background: '#C63D2F',
                    },
                    text: '최저매출',
                  }
                }],
           },
          colors: [ '#546E7A' , '#FF9800', '#E91E63'  ]
           
     };
	
	options.series[0].data = [];
	options.xaxis.categories = [];
	
    
	for(var i = 0; i< profit.length; i++){
		options.series[0].data.push(profit[i].month_profit);
		options.xaxis.categories.push(profit[i].month);
		
	}
	
	
    var chart = new ApexCharts(document.querySelector("#salesChart"), options);
    chart.render();
}


function fn_barChart(data) {

	var company = new Array();
	
	company = data;

    
    var options = {
      series: [{
      data: [400, 430, 448, 470, 540, 580, 690, 1100, 1200, 1380]
    }],
      chart: {
      type: 'bar',
      height: 380,
    },
    plotOptions: {
      bar: {
        barHeight: '100%',
        distributed: true,
        horizontal: true,
        dataLabels: {
          position: 'bottom'
        },
      }
    },
    colors: ['#33b2df', '#546E7A', '#d4526e', '#13d8aa', '#A5978B', '#2b908f', '#f9a3a4', '#90ee7e',
      '#f48024', '#69d2e7'
    ],
    dataLabels: {
      enabled: true,
      textAnchor: 'start',
      style: {
        colors: ['#fff']
      },
      formatter: function (val, opt) {
        return opt.w.globals.labels[opt.dataPointIndex] + " :  " + val
      },
      offsetX: 0,
      dropShadow: {
        enabled: true
      }
    },
    stroke: {
      width: 1,
      colors: ['#fff']
    },
    xaxis: {
      categories: ['South Korea', 'Canada', 'United Kingdom', 'Netherlands', 'Italy', 'France', 'Japan',
        'United States', 'China', 'India'
      ],
    },
    yaxis: {
      labels: {
        show: false
      }
    },
    title: {
        text: currentMonth + '월 제품별 매출',
        align: 'left',
        floating: true
    },
    subtitle: {
        text: '단위(만원)',
        align: 'right',
    },
    tooltip: {
      theme: 'dark',
      x: {
        show: false
      },
      y: {
        title: {
          formatter: function () {
            return ''
          }
        }
      }
    },
    events: {
        dataPointSelection: function (event, chartContext, config) {
            console.log(config.dataPointIndex + " " + config.seriesIndex);
        },
        click: function (event, chartContext, config) {
            console.log(config.dataPointIndex + " " + config.seriesIndex);
        }
    }
    };

	options.series[0].data = [];
	options.xaxis.categories = [];
	
	for(var i = 0; i< company.length; i++){
		options.series[0].data.push(parseInt(company[i].total_sales,10));
		options.xaxis.categories.push(company[i].pro_nm);
	}
	
	
    var chart = new ApexCharts(document.querySelector("#barChart"), options);
    chart.render();
}



