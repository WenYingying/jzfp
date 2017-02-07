

$(document).ready(function() {
	var myChart = echarts.init(document.getElementById('bar'));
//	app.title = '环形图';
	
	option = {
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b}: {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        x: 'left',
//	        data:['直接访问','邮件营销']
	    },
	    color: ['#ff7d29','#3b94e1'],
	    series: [
	        {
	            name:'访问来源',
	            type:'pie',
	            radius: ['50%', '70%'],
	            avoidLabelOverlap: false,
	            label: {
	                normal: {
	                    show: false,
	                    position: 'center'
	                },
	                emphasis: {
	                    show: true,
	                    textStyle: {
	                        fontSize: '16',
	                        fontWeight: 'bold'
	                    }
	                }
	            },
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data:[
	                {value:100, name:'直接访问'},
	                {value:20, name:'邮件营销'},
	            ]
	        }
	    ]
	};
	myChart.setOption(option);
	
	
	
	
	var myChart2 = echarts.init(document.getElementById('bar2'));
//	app.title = '环形图';
	
	option = {
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b}: {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        x: 'left',
//	        data:['直接访问','邮件营销']
	    },
	    color: ['#3b94e1','#ff7d29'],
	    series: [
	        {
	            name:'访问来源',
	            type:'pie',
	            radius: ['50%', '70%'],
	            avoidLabelOverlap: false,
	            label: {
	                normal: {
	                    show: false,
	                    position: 'center'
	                },
	                emphasis: {
	                    show: true,
	                    textStyle: {
	                        fontSize: '16',
	                        fontWeight: 'bold'
	                    }
	                }
	            },
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data:[
	                {value:100, name:'直接访问'},
	                {value:20, name:'邮件营销'},
	            ]
	        }
	    ]
	};
	myChart2.setOption(option);
	
	
	
	
	
	
	
	
	
	
	

})