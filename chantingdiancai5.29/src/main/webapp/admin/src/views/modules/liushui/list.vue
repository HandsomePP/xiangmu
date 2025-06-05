<template>
    <div class="main-content">
        <!-- 统计页面 -->
        <div v-if="showFlag">
            <!-- 搜索条件 -->
            <el-form :inline="true" :model="searchForm" class="form-content">
                <el-row :gutter="20" class="slt" :style="{justifyContent:contents.searchBoxPosition=='1'?'flex-start':contents.searchBoxPosition=='2'?'center':'flex-end'}">
                    <el-form-item :label="contents.inputTitle == 1 ? '订单状态' : ''">
                        <el-select v-model="searchForm.status" placeholder="请选择订单状态">
                            <el-option label="=-请选择-=" value=""></el-option>
                            <el-option label="已支付" value="已支付"></el-option>
                            <el-option label="已完成" value="已完成"></el-option>
                            <el-option label="已退款" value="已退款"></el-option>
                        </el-select>
                    </el-form-item>
                                                 
                    <el-form-item :label="contents.inputTitle == 1 ? '统计时间' : ''">
                        <div class="block">
                            <el-date-picker v-model="searchForm.createTimeStart" value-format="yyyy-MM-dd" type="date" placeholder="选择开始日期"></el-date-picker> ->
                            <el-date-picker v-model="searchForm.createTimeEnd" value-format="yyyy-MM-dd" type="date" placeholder="选择结束日期"></el-date-picker>
                        </div>
                    </el-form-item>
                    <el-form-item>
                        <el-button v-if="contents.searchBtnIcon == 1 && contents.searchBtnIconPosition == 1" icon="el-icon-search" type="success" @click="search()">{{ contents.searchBtnFont == 1?'查询统计':'' }}</el-button>
                        <el-button v-if="contents.searchBtnIcon == 1 && contents.searchBtnIconPosition == 2" type="success" @click="search()">{{ contents.searchBtnFont == 1?'查询统计':'' }}<i class="el-icon-search el-icon--right"/></el-button>
                        <el-button v-if="contents.searchBtnIcon == 0" type="success" @click="search()">{{ contents.searchBtnFont == 1?'查询统计':'' }}</el-button>
                    </el-form-item>
                </el-row>
            </el-form>

            <!-- 统计卡片 -->
            <div class="statistics-cards">
                <el-row :gutter="20">
                    <el-col :span="6">
                        <el-card class="stat-card">
                            <div class="stat-content">
                                <div class="stat-icon total-icon">
                                    <i class="el-icon-s-order"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-number">{{ statistics.totalOrders }}</div>
                                    <div class="stat-label">总订单数</div>
                                </div>
                            </div>
                        </el-card>
                    </el-col>
                    <el-col :span="6">
                        <el-card class="stat-card">
                            <div class="stat-content">
                                <div class="stat-icon paid-icon">
                                    <i class="el-icon-success"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-number">{{ statistics.paidOrders }}</div>
                                    <div class="stat-label">已支付订单</div>
                                </div>
                            </div>
                        </el-card>
                    </el-col>
                    <el-col :span="6">
                        <el-card class="stat-card">
                            <div class="stat-content">
                                <div class="stat-icon completed-icon">
                                    <i class="el-icon-circle-check"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-number">{{ statistics.completedOrders }}</div>
                                    <div class="stat-label">已完成订单</div>
                                </div>
                            </div>
                        </el-card>
                    </el-col>
                    <el-col :span="6">
                        <el-card class="stat-card">
                            <div class="stat-content">
                                <div class="stat-icon amount-icon">
                                    <i class="el-icon-coin"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-number">¥{{ statistics.totalAmount }}</div>
                                    <div class="stat-label">总金额</div>
                                </div>
                            </div>
                        </el-card>
                    </el-col>
                </el-row>
            </div>

            <!-- 图表区域 -->
            <div class="charts-container">
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-card class="chart-card">
                            <div slot="header" class="chart-header">
                                <span>订单状态统计</span>
                            </div>
                            <div id="paymentStatusChart" style="width:100%;height:300px;"></div>
                        </el-card>
                    </el-col>
                    <el-col :span="12">
                        <el-card class="chart-card">
                            <div slot="header" class="chart-header">
                                <span>商品销售统计</span>
                            </div>
                            <div id="tableOrdersChart" style="width:100%;height:300px;"></div>
                        </el-card>
                    </el-col>
                </el-row>
                <el-row :gutter="20" style="margin-top: 20px;">
                    <el-col :span="24">
                        <el-card class="chart-card">
                            <div slot="header" class="chart-header">
                                <span>时间趋势统计</span>
                            </div>
                            <div id="timeTrendChart" style="width:100%;height:400px;"></div>
                        </el-card>
                    </el-col>
                </el-row>
            </div>

            <!-- 详细数据表格 -->
            <div class="table-content" style="margin-top: 20px;">
                <el-card>
                    <div slot="header" class="chart-header">
                        <span>订单详细列表</span>
                        <el-button v-if="isAuth('liushui','报表')" type="text" @click="exportData" style="float: right; padding: 3px 0">导出数据</el-button>
                    </div>
                    <el-table class="tables" :size="contents.tableSize" :show-header="contents.tableShowHeader"
                              :header-row-style="headerRowStyle" :header-cell-style="headerCellStyle"
                              :border="contents.tableBorder"
                              :fit="contents.tableFit"
                              :stripe="contents.tableStripe"
                              :row-style="rowStyle"
                              :cell-style="cellStyle"
                              :style="{width: '100%',fontSize:contents.tableContentFontSize,color:contents.tableContentFontColor}"
                              v-if="isAuth('liushui','查看')"
                              :data="dataList"
                              v-loading="dataListLoading">
                        <el-table-column label="索引" v-if="contents.tableIndex" type="index" width="50" />
                        <el-table-column  :sortable="contents.tableSortable" :align="contents.tableAlign"
                                          prop="orderid"
                                          header-align="center"
                                          label="订单号">
                            <template slot-scope="scope">
                                {{scope.row.orderid}}
                            </template>
                        </el-table-column>
                        <el-table-column  :sortable="contents.tableSortable" :align="contents.tableAlign"
                                          prop="goodname"
                                          header-align="center"
                                          label="商品名称">
                            <template slot-scope="scope">
                                {{scope.row.goodname}}
                            </template>
                        </el-table-column>
                        <el-table-column  :sortable="contents.tableSortable" :align="contents.tableAlign"
                                          prop="buynumber"
                                          header-align="center"
                                          label="数量">
                            <template slot-scope="scope">
                                {{scope.row.buynumber}}
                            </template>
                        </el-table-column>
                        <el-table-column  :sortable="contents.tableSortable" :align="contents.tableAlign"
                                          prop="discounttotal"
                                          header-align="center"
                                          label="订单金额">
                            <template slot-scope="scope">
                                ¥{{scope.row.discounttotal}}
                            </template>
                        </el-table-column>
                        <el-table-column  :sortable="contents.tableSortable" :align="contents.tableAlign"
                                          prop="status"
                                          header-align="center"
                                          label="订单状态">
                            <template slot-scope="scope">
                                <el-tag :type="getStatusType(scope.row.status)">
                                    {{scope.row.status}}
                                </el-tag>
                            </template>
                        </el-table-column>
                        <el-table-column  :sortable="contents.tableSortable" :align="contents.tableAlign"
                                          prop="addtime"
                                          header-align="center"
                                          label="下单时间">
                            <template slot-scope="scope">
                                {{scope.row.addtime}}
                            </template>
                        </el-table-column>
                        <el-table-column width="200" :align="contents.tableAlign"
                                         header-align="center"
                                         label="操作">
                            <template slot-scope="scope">
                                <el-button v-if="isAuth('liushui','查看')" type="success" size="mini" @click="addOrUpdateHandler(scope.row.orderid,'info')">详情</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                    <el-pagination
                            clsss="pages"
                            :layout="layouts"
                            @size-change="sizeChangeHandle"
                            @current-change="currentChangeHandle"
                            :current-page="pageIndex"
                            :page-sizes="[10, 20, 50, 100]"
                            :page-size="Number(contents.pageEachNum)"
                            :total="totalPage"
                            :small="contents.pageStyle"
                            class="pagination-content"
                            :background="contents.pageBtnBG"
                            :style="{textAlign:contents.pagePosition==1?'left':contents.pagePosition==2?'center':'right'}"
                    ></el-pagination>
                </el-card>
            </div>
        </div>
        <!-- 添加/修改页面 -->
        <add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>
    </div>
</template>
<script>

    import AddOrUpdate from "./add-or-update";
    export default {
        data() {
            return {
                searchForm: {
                    key: ""
                },
                dataList: [],
                pageIndex: 1,
                pageSize: 50, // 增加每页数量
                totalPage: 0,
                dataListLoading: false,
                dataListSelections: [],
                showFlag: true,
                sfshVisiable: false,
                shForm: {},
                chartVisiable: false,
                addOrUpdateFlag:false,
                // 统计数据
                statistics: {
                    totalOrders: 0,
                    paidOrders: 0,
                    completedOrders: 0,
                    totalAmount: 0
                },
                contents:{"searchBtnFontColor":"rgba(19, 20, 20, 1)","pagePosition":"1","inputFontSize":"14px","inputBorderRadius":"4px","tableBtnDelFontColor":"rgba(255, 73, 73, 1)","tableBtnIconPosition":"2","searchBtnHeight":"40px","inputIconColor":"#C0C4CC","searchBtnBorderRadius":"4px","tableStripe":true,"btnAdAllWarnFontColor":"rgba(30, 136, 229, 1)","tableBtnDelBgColor":"rgba(255, 255, 255, 1)","searchBtnIcon":"1","tableSize":"medium","searchBtnBorderStyle":"solid","tableSelection":true,"searchBtnBorderWidth":"1px","tableContentFontSize":"14px","searchBtnBgColor":"rgba(38, 198, 218, 1)","inputTitleSize":"14px","btnAdAllBorderColor":"#DCDFE6","pageJumper":true,"btnAdAllIconPosition":"1","searchBoxPosition":"1","tableBtnDetailFontColor":"rgba(38, 198, 218, 1)","tableBtnHeight":"40px","pagePager":true,"searchBtnBorderColor":"rgba(255, 255, 255, 1)","tableHeaderFontColor":"#909399","inputTitle":"1","tableBtnBorderRadius":"10px","btnAdAllFont":"1","btnAdAllDelFontColor":"rgba(255, 73, 73, 1)","tableBtnIcon":"1","btnAdAllHeight":"40px","btnAdAllWarnBgColor":"rgba(255, 255, 255, 1)","btnAdAllBorderWidth":"1px","tableStripeFontColor":"#606266","tableBtnBorderStyle":"solid","inputHeight":"40px","btnAdAllBorderRadius":"4px","btnAdAllDelBgColor":"rgba(255, 255, 255, 1)","pagePrevNext":true,"btnAdAllAddBgColor":"rgba(255, 255, 255, 1)","searchBtnFont":"1","tableIndex":true,"btnAdAllIcon":"1","tableSortable":false,"pageSizes":true,"tableFit":true,"pageBtnBG":true,"searchBtnFontSize":"14px","tableBtnEditBgColor":"rgba(255, 255, 255, 1)","inputBorderWidth":"1px","inputFontPosition":"1","inputFontColor":"#333","pageEachNum":10,"tableHeaderBgColor":"#fff","inputTitleColor":"#333","btnAdAllBoxPosition":"1","tableBtnDetailBgColor":"rgba(255, 255, 255, 1)","inputIcon":"1","searchBtnIconPosition":"1","btnAdAllFontSize":"14px","inputBorderStyle":"solid","inputBgColor":"#fff","pageStyle":false,"pageTotal":true,"btnAdAllAddFontColor":"rgba(38, 198, 218, 1)","tableBtnFont":"1","tableContentFontColor":"#606266","inputBorderColor":"#DCDFE6","tableShowHeader":true,"tableBtnFontSize":"10px","tableBtnBorderColor":"#DCDFE6","inputIconPosition":"1","tableBorder":true,"btnAdAllBorderStyle":"solid","tableBtnBorderWidth":"1px","tableStripeBgColor":"#F5F7FA","tableBtnEditFontColor":"rgba(30, 136, 229, 1)","tableAlign":"center"},
                layouts: "",
            };
        },
        created() {
            this.init();
            this.getDataList();
            this.contentStyleChange()
        },
        mounted() {

        },
        filters: {
            htmlfilter: function (val) {
                return val.replace(/<[^>]*>/g).replace(/undefined/g,"");
            }
        },
        components: {
            AddOrUpdate,
        },
        methods: {
            // 获取状态标签类型
            getStatusType(status) {
                switch(status) {
                    case '已支付': return 'success';
                    case '已完成': return 'primary';
                    case '已退款': return 'danger';
                    default: return 'info';
                }
            },
            contentStyleChange() {
                this.contentSearchStyleChange()
                this.contentBtnAdAllStyleChange()
                this.contentSearchBtnStyleChange()
                this.contentTableBtnStyleChange()
                this.contentPageStyleChange()
            },
            contentSearchStyleChange() {
                this.$nextTick(()=>{
                    document.querySelectorAll(".form-content .slt .el-input__inner").forEach(el=>{
                    let textAlign = "left"
                    if(this.contents.inputFontPosition == 2) textAlign = "center"
                if(this.contents.inputFontPosition == 3) textAlign = "right"
                el.style.textAlign = textAlign
                el.style.height = this.contents.inputHeight
                el.style.lineHeight = this.contents.inputHeight
                el.style.color = this.contents.inputFontColor
                el.style.fontSize = this.contents.inputFontSize
                el.style.borderWidth = this.contents.inputBorderWidth
                el.style.borderStyle = this.contents.inputBorderStyle
                el.style.borderColor = this.contents.inputBorderColor
                el.style.borderRadius = this.contents.inputBorderRadius
                el.style.backgroundColor = this.contents.inputBgColor
            })
            if(this.contents.inputTitle) {
                    document.querySelectorAll(".form-content .slt .el-form-item__label").forEach(el=>{
                        el.style.color = this.contents.inputTitleColor
                    el.style.fontSize = this.contents.inputTitleSize
                    el.style.lineHeight = this.contents.inputHeight
                })
                }
                setTimeout(()=>{
                    document.querySelectorAll(".form-content .slt .el-input__prefix").forEach(el=>{
                    el.style.color = this.contents.inputIconColor
                el.style.lineHeight = this.contents.inputHeight
            })
                document.querySelectorAll(".form-content .slt .el-input__suffix").forEach(el=>{
                    el.style.color = this.contents.inputIconColor
                el.style.lineHeight = this.contents.inputHeight
            })
                document.querySelectorAll(".form-content .slt .el-input__icon").forEach(el=>{
                    el.style.lineHeight = this.contents.inputHeight
            })
            },10)

            })
            },
             // 搜索按钮
            contentSearchBtnStyleChange() {
                this.$nextTick(()=>{
                    document.querySelectorAll(".form-content .slt .el-button--success").forEach(el=>{
                    el.style.height = this.contents.searchBtnHeight
                el.style.color = this.contents.searchBtnFontColor
                el.style.fontSize = this.contents.searchBtnFontSize
                el.style.borderWidth = this.contents.searchBtnBorderWidth
                el.style.borderStyle = this.contents.searchBtnBorderStyle
                el.style.borderColor = this.contents.searchBtnBorderColor
                el.style.borderRadius = this.contents.searchBtnBorderRadius
                el.style.backgroundColor = this.contents.searchBtnBgColor
            })
            })
            },
            // 新增、批量删除
            contentBtnAdAllStyleChange() {
                this.$nextTick(()=>{
                    document.querySelectorAll(".form-content .ad .el-button--success").forEach(el=>{
                    el.style.height = this.contents.btnAdAllHeight
                el.style.color = this.contents.btnAdAllAddFontColor
                el.style.fontSize = this.contents.btnAdAllFontSize
                el.style.borderWidth = this.contents.btnAdAllBorderWidth
                el.style.borderStyle = this.contents.btnAdAllBorderStyle
                el.style.borderColor = this.contents.btnAdAllBorderColor
                el.style.borderRadius = this.contents.btnAdAllBorderRadius
                el.style.backgroundColor = this.contents.btnAdAllAddBgColor
            })
                document.querySelectorAll(".form-content .ad .el-button--danger").forEach(el=>{
                    el.style.height = this.contents.btnAdAllHeight
                el.style.color = this.contents.btnAdAllDelFontColor
                el.style.fontSize = this.contents.btnAdAllFontSize
                el.style.borderWidth = this.contents.btnAdAllBorderWidth
                el.style.borderStyle = this.contents.btnAdAllBorderStyle
                el.style.borderColor = this.contents.btnAdAllBorderColor
                el.style.borderRadius = this.contents.btnAdAllBorderRadius
                el.style.backgroundColor = this.contents.btnAdAllDelBgColor
            })
                document.querySelectorAll(".form-content .ad .el-button--warning").forEach(el=>{
                    el.style.height = this.contents.btnAdAllHeight
                el.style.color = this.contents.btnAdAllWarnFontColor
                el.style.fontSize = this.contents.btnAdAllFontSize
                el.style.borderWidth = this.contents.btnAdAllBorderWidth
                el.style.borderStyle = this.contents.btnAdAllBorderStyle
                el.style.borderColor = this.contents.btnAdAllBorderColor
                el.style.borderRadius = this.contents.btnAdAllBorderRadius
                el.style.backgroundColor = this.contents.btnAdAllWarnBgColor
            })
            })
            },
            // 表格
            rowStyle({ row, rowIndex}) {
                if (rowIndex % 2 == 1) {
                    if(this.contents.tableStripe) {
                        return {color:this.contents.tableStripeFontColor}
                    }
                } else {
                    return ""
                }
            },
            cellStyle({ row, rowIndex}){
                if (rowIndex % 2 == 1) {
                    if(this.contents.tableStripe) {
                        return {backgroundColor:this.contents.tableStripeBgColor}
                    }
                } else {
                    return ""
                }
            },
            headerRowStyle({ row, rowIndex}){
                return {color: this.contents.tableHeaderFontColor}
            },
            headerCellStyle({ row, rowIndex}){
                return {backgroundColor: this.contents.tableHeaderBgColor}
            },
            // 表格按钮
            contentTableBtnStyleChange(){

            },
            // 分页
            contentPageStyleChange(){
                let arr = []

                if(this.contents.pageTotal) arr.push("total")
                if(this.contents.pageSizes) arr.push("sizes")
                if(this.contents.pagePrevNext){
                    arr.push("prev")
                    if(this.contents.pagePager) arr.push("pager")
                    arr.push("next")
                }
                if(this.contents.pageJumper) arr.push("jumper")
                this.layouts = arr.join()
                this.contents.pageEachNum = 10
            },
            // 计算统计数据
            calculateStatistics() {
                if (this.dataList.length === 0) {
                    this.statistics = {
                        totalOrders: 0,
                        paidOrders: 0,
                        completedOrders: 0,
                        totalAmount: 0
                    };
                    return;
                }

                this.statistics.totalOrders = this.dataList.length;
                this.statistics.paidOrders = this.dataList.filter(item => item.status === '已支付').length;
                this.statistics.completedOrders = this.dataList.filter(item => item.status === '已完成').length;
                this.statistics.totalAmount = this.dataList.reduce((sum, item) => {
                    return sum + (parseFloat(item.discounttotal) || 0);
                }, 0).toFixed(2);
            },
            // 绘制图表
            drawCharts() {
                this.$nextTick(() => {
                    this.drawPaymentStatusChart();
                    this.drawTableOrdersChart();
                    this.drawTimeTrendChart();
                });
            },
            // 订单状态饼图
            drawPaymentStatusChart() {
                var chart = this.$echarts.init(document.getElementById("paymentStatusChart"), 'macarons');
                
                // 统计各状态订单数
                const statusStats = {};
                this.dataList.forEach(item => {
                    const status = item.status || '未知状态';
                    statusStats[status] = (statusStats[status] || 0) + 1;
                });
                
                const statusData = Object.keys(statusStats).map(status => ({
                    value: statusStats[status],
                    name: status
                }));
                
                var option = {
                    tooltip: {
                        trigger: 'item',
                        formatter: '{b}: {c} ({d}%)'
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left'
                    },
                    series: [
                        {
                            type: 'pie',
                            radius: ['40%', '70%'],
                            center: ['50%', '60%'],
                            data: statusData,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };
                chart.setOption(option);
                window.addEventListener('resize', () => {
                    chart.resize();
                });
            },
            // 商品销售统计柱图
            drawTableOrdersChart() {
                var chart = this.$echarts.init(document.getElementById("tableOrdersChart"), 'macarons');
                
                // 统计各商品销售数量
                const goodStats = {};
                this.dataList.forEach(item => {
                    const goodName = item.goodname || '未知商品';
                    goodStats[goodName] = (goodStats[goodName] || 0) + parseInt(item.buynumber || 0);
                });
                
                // 取前10名
                const sortedGoods = Object.entries(goodStats)
                    .sort(([,a], [,b]) => b - a)
                    .slice(0, 10);
                
                const goodNames = sortedGoods.map(([name]) => name);
                const goodValues = sortedGoods.map(([,value]) => value);
                
                var option = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'category',
                        data: goodNames,
                        axisTick: {
                            alignWithLabel: true
                        },
                        axisLabel: {
                            rotate: 45
                        }
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        {
                            name: '销售数量',
                            type: 'bar',
                            barWidth: '60%',
                            data: goodValues
                        }
                    ]
                };
                chart.setOption(option);
                window.addEventListener('resize', () => {
                    chart.resize();
                });
            },
            // 时间趋势图
            drawTimeTrendChart() {
                var chart = this.$echarts.init(document.getElementById("timeTrendChart"), 'macarons');
                
                // 按日期统计订单数
                const dateStats = {};
                this.dataList.forEach(item => {
                    if (item.addtime) {
                        const date = item.addtime.split(' ')[0]; // 取日期部分
                        if (!dateStats[date]) {
                            dateStats[date] = { total: 0, paid: 0, completed: 0, refunded: 0 };
                        }
                        dateStats[date].total++;
                        if (item.status === '已支付') {
                            dateStats[date].paid++;
                        } else if (item.status === '已完成') {
                            dateStats[date].completed++;
                        } else if (item.status === '已退款') {
                            dateStats[date].refunded++;
                        }
                    }
                });
                
                const dates = Object.keys(dateStats).sort();
                const totalData = dates.map(date => dateStats[date].total);
                const paidData = dates.map(date => dateStats[date].paid);
                const completedData = dates.map(date => dateStats[date].completed);
                const refundedData = dates.map(date => dateStats[date].refunded);
                
                var option = {
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data: ['总订单', '已支付', '已完成', '已退款']
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: dates
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        {
                            name: '总订单',
                            type: 'line',
                            data: totalData
                        },
                        {
                            name: '已支付',
                            type: 'line',
                            data: paidData
                        },
                        {
                            name: '已完成',
                            type: 'line',
                            data: completedData
                        },
                        {
                            name: '已退款',
                            type: 'line',
                            data: refundedData
                        }
                    ]
                };
                chart.setOption(option);
                window.addEventListener('resize', () => {
                    chart.resize();
                });
            },
            init () {
            },
            search() {
                this.pageIndex = 1;
                this.getDataList();
            },
            selectUpdate(){
                var bbb = this.dataList;
                var select= {};
				
                var czTypesSelect = this.czTypesSelectSearch;
                for(var i=0 ; i< czTypesSelect.length ; i++){
                    select[ czTypesSelect[i].id] =  czTypesSelect[i].name;
                }
                for(var i=0 ; i<bbb.length ; i++){
                    bbb[i].czTypes = select[bbb[i].canzhuoId];
                }
                select = {};
                
                var yhTypesSelect = this.yhTypesSelectSearch;
                for(var i=0 ; i< yhTypesSelect.length ; i++){
                    select[ yhTypesSelect[i].id] =  yhTypesSelect[i].name;
                }
                for(var i=0 ; i<bbb.length ; i++){
                    bbb[i].yhTypes = select[bbb[i].userid];
                }
                select = {};
                
                var sfTypesSelect = this.sfTypesSelectSearch;
                for(var i=0 ; i< sfTypesSelect.length ; i++){
                    select[ sfTypesSelect[i].codeIndex] =  sfTypesSelect[i].indexName;
                }
                for(var i=0 ; i<bbb.length ; i++){
                    bbb[i].sfTypes = select[bbb[i].sfTypes];
                }
                select = {};
            },
            // 获取数据列表
            getDataList() {
                this.dataListLoading = true;
                let params = {
                    page: this.pageIndex,
                    limit: 100, // 增加limit数值
                }
                                                                                                          
                if(this.searchForm.status!='' && this.searchForm.status!=undefined){
                    params['status'] = this.searchForm.status
                }
                           
                if(this.searchForm.createTimeStart!='' && this.searchForm.createTimeStart!=undefined){
                    params['createTimeStart'] = this.searchForm.createTimeStart
                }
                if(this.searchForm.createTimeEnd!='' && this.searchForm.createTimeEnd!=undefined){
                    params['createTimeEnd'] = this.searchForm.createTimeEnd
                }

                // 使用订单接口获取数据
                this.$http({
                    url: "orders/page",
                    method: "get",
                    params: params
                }).then(({ data }) => {
                    if (data && data.code === 0) {
                        this.dataList = data.data.list;
                        this.totalPage = data.data.total;
                        // 计算统计数据并绘制图表
                        this.calculateStatistics();
                        this.drawCharts();
                    } else {
                        this.dataList = [];
                        this.totalPage = 0;
                        this.calculateStatistics();
                    }
                    this.dataListLoading = false;
                }).catch(error => {
                    console.error('获取订单数据失败:', error);
                    this.dataList = [];
                    this.totalPage = 0;
                    this.calculateStatistics();
                    this.dataListLoading = false;
                });
            },
            // 每页数
            sizeChangeHandle(val) {
                this.pageSize = val;
                this.pageIndex = 1;
                this.getDataList();
            },
            // 当前页
            currentChangeHandle(val) {
                this.pageIndex = val;
                this.getDataList();
            },
            // 多选
            selectionChangeHandler(val) {
                this.dataListSelections = val;
            },
            // 添加/修改
            addOrUpdateHandler(id) {
                this.$router.push({
                        path:"dingdanxiangqing",
                        query:{
                            "orderid":id,
                        },
                    });
            },
            // 下载
            download(file){
                window.open(`${file}`)
            },
            // 导出数据
            exportData() {
                // 这里可以实现导出功能
                this.$message.success('导出功能开发中...');
            },
            gaiwei(id) {
                this.$confirm(`确定进行修改操作?`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$http({
                    url: "orders/gaiwei?ids="+id,
                     method: "get",
                }).then(({ data }) => {
                    if (data && data.code === 0) {
                    this.$message({
                        message: "操作成功",
                        type: "success",
                        duration: 1500,
                        onClose: () => {
                        this.search();
                }
                });
                } else {
                    this.$message.error(data.msg);
                }
            });
            });
            },
        }
    };
</script>
<style lang="scss" scoped>
    .slt {
        margin: 0 !important;
        display: flex;
    }

    .ad {
        margin: 0 !important;
        display: flex;
    }

    .pages {
    & /deep/ el-pagination__sizes{
    & /deep/ el-input__inner {
          height: 22px;
          line-height: 22px;
      }
    }
    }

    .el-button+.el-button {
        margin:0;
    }

    .tables {
    & /deep/ .el-button--success {
          height: 40px;
          color: rgba(38, 198, 218, 1);
          font-size: 10px;
          border-width: 1px;
          border-style: solid;
          border-color: #DCDFE6;
          border-radius: 10px;
          background-color: rgba(255, 255, 255, 1);
      }

    & /deep/ .el-button--primary {
          height: 40px;
          color: rgba(30, 136, 229, 1);
          font-size: 10px;
          border-width: 1px;
          border-style: solid;
          border-color: #DCDFE6;
          border-radius: 10px;
          background-color: rgba(255, 255, 255, 1);
      }

    & /deep/ .el-button--danger {
          height: 40px;
          color: rgba(255, 73, 73, 1);
          font-size: 10px;
          border-width: 1px;
          border-style: solid;
          border-color: #DCDFE6;
          border-radius: 10px;
          background-color: rgba(255, 255, 255, 1);
      }

    & /deep/ .el-button {
          margin: 4px;
      }
    }

    /* 统计卡片样式 */
    .statistics-cards {
        margin: 20px 0;
        
        .stat-card {
            .stat-content {
                display: flex;
                align-items: center;
                padding: 10px 0;
                
                .stat-icon {
                    width: 60px;
                    height: 60px;
                    border-radius: 50%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    margin-right: 20px;
                    
                    i {
                        font-size: 24px;
                        color: white;
                    }
                    
                    &.total-icon {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    }
                    
                    &.paid-icon {
                        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                    }
                    
                    &.completed-icon {
                        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                    }
                    
                    &.amount-icon {
                        background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
                    }
                }
                
                .stat-info {
                    flex: 1;
                    
                    .stat-number {
                        font-size: 28px;
                        font-weight: bold;
                        color: #303133;
                        line-height: 1;
                        margin-bottom: 5px;
                    }
                    
                    .stat-label {
                        font-size: 14px;
                        color: #909399;
                    }
                }
            }
        }
    }

    /* 图表区域样式 */
    .charts-container {
        margin: 20px 0;
        
        .chart-card {
            .chart-header {
                font-weight: bold;
                color: #303133;
            }
        }
    }

    /* 响应式布局 */
    @media (max-width: 768px) {
        .statistics-cards {
            .stat-card {
                margin-bottom: 10px;
            }
        }
        
        .charts-container {
            .el-col {
                margin-bottom: 20px;
            }
        }
    }
</style>
