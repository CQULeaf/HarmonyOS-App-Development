// import AccountData from '../viewmodel/AccountData';
// import CommonConstants from '../common/constants/CommonConstants';
//
//
// @Component
// export default struct Comp_graph {
//
//   @State monthDatas_out: number[] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//   @State monthDatas_int: number[] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
//   @State day_int: number[] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
//     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0];
//   @State day_out: number[] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
//     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0];
//   @State labels: string[] = ['tab1', 'tab2', 'tab3', 'tab4'];
//   findMax(): number {
//     let max = this.monthDatas_out[0];
//     for (let i = 1; i < this.monthDatas_out.length; i++) {
//       if (this.monthDatas_out[i] > max) {
//         max = this.monthDatas_out[i];
//       }
//     }
//     return max;
//   }
//   findMax1(): number {
//     let max = this.monthDatas_int[0];
//     for (let i = 1; i < this.monthDatas_int.length; i++) {
//       if (this.monthDatas_int[i] > max) {
//         max = this.monthDatas_int[i];
//       }
//     }
//     return max;
//   }
//   findMaxday(): number {
//     let max = this.day_out[0];
//     for (let i = 1; i < this.day_out.length; i++) {
//       if (this.day_out[i] > max) {
//         max = this.day_out[i];
//       }
//     }
//     return max;
//   }
//   findMaxday1(): number {
//     let max = this.day_int[0];
//     for (let i = 1; i < this.day_int.length; i++) {
//       if (this.day_int[i] > max) {
//         max = this.day_int[i];
//       }
//     }
//     return max;
//   }
//   findyear(date: string): string {
//     // 读取字符串前四位获取年份
//     return date.substring(0, 4);
//   }
//   findMonth(date: string): number {
//     // 获取日期字符串中的月份部分，并将其转换为数字
//     return Number(date.split('-')[1]);
//   }
//   findDay(date: string): number {
//     // 获取日期字符串中的月份部分，并将其转换为数字
//     return Number(date.split('-')[2]);
//   }
//   setvalue(month:number){
//     this.AccountTable.query(0, (result: AccountData[]) => {
//       this.accounts = result;
//     }, true);
//     for (let i = 0; i < 31; i++) {
//       this.day_out[i] = 0;
//       this.day_int[i] = 0;
//     }
//     for (let i = 0; i < this.accounts.length; i++) {
//       if(this.findyear(this.accounts[i].Date) === this.selectyear ){
//         if(this.findMonth(this.accounts[i].Date) === month){
//           if(this.accounts[i].accountType === 0) {
//             let y = this.findDay(this.accounts[i].Date) - 1;
//             this.day_out[y] = this.day_out[y] + this.accounts[i].amount;
//           }else if (this.accounts[i].accountType === 1) {
//             let y = this.findDay(this.accounts[i].Date) - 1;
//             this.day_int[y] = this.day_int[y] + this.accounts[i].amount;
//           }
//         }
//       }
//     }
//   }
//   @State accounts: Array<AccountData> = [];
//   @State searchText: string = '';
//   @State newAccount: AccountData = { id: 0, accountType: 0, typeText: '', amount: 0 ,Date:'',remark:''};
//   @State selectyear: string = "2024";
//   @State totalint: number = 0;
//   @State totalout: number = 0;
//
//   private AccountTable = new AccountTable(() => {});
//   private select: number = 12
//   private years: string[] = ['2035', '2034', '2033', '2032','2031', '2030', '2029', '2028','2027', '2026', '2025', '2024','2023', '2022', '2021', '2020', '2019', '2018', '2017', '2016'
//   ,'2015', '2014', '2013', '2012', '2011', '2010', '2009', '2008', '2007', '2006', '2005', '2004', '2003', '2002', '2001', '2000']
//   @State clickyear: string = '';
//   @State clickmonth: number = -1;
//   @State clicktype: number = -1;
//   @State daymax: number = -1;
//   dialogController: CustomDialogController = new CustomDialogController({
//     builder: MonthgraphDialog({
//       daymax: $daymax,
//       day_out: $day_out,
//       clickyear: $clickyear,
//       clickmonth: $clickmonth,
//       clicktype: $clicktype,
//       cancel: this.onCancel,
//       confirm: this.onAccept,
//     }),
//     customStyle: true,
//     alignment: DialogAlignment.Default,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
//   })
//   onCancel() {
//     console.info('Callback when the first button is clicked')
//   }
//   onAccept() {
//     console.info('Callback when the second button is clicked')
//   }
//
//   dialogController1: CustomDialogController = new CustomDialogController({
//     builder: MonthgraphDialog1({
//       daymax: $daymax,
//       day_int: $day_int,
//       clickyear: $clickyear,
//       clickmonth: $clickmonth,
//       clicktype: $clicktype,
//       cancel: this.onCancel,
//       confirm: this.onAccept,
//     }),
//     customStyle: true,
//     alignment: DialogAlignment.Default,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
//   })
//
//
//   aboutToAppear(): void {
//     this.AccountTable.query(0, (result: AccountData[]) => {
//       this.accounts = result;
//     }, true);
//     for (let i = 0; i < 12; i++) {
//       this.monthDatas_out[i] = 0;
//       this.monthDatas_int[i] = 0;
//     }
//     this.totalout = 0;
//     this.totalint = 0;
//     for (let i = 0; i < this.accounts.length; i++) {
//       if(this.findyear(this.accounts[i].Date) === this.selectyear ){
//         if(this.accounts[i].accountType === 0) {
//           let x = this.findMonth(this.accounts[i].Date) - 1;
//           this.monthDatas_out[x] = this.monthDatas_out[x] + this.accounts[i].amount;
//           this.totalout = this.totalout + this.accounts[i].amount
//
//           // let y = this.findDay(this.accounts[i].Date) - 1;
//           // this.day_out[y] = this.day_out[y] + this.accounts[i].amount;
//         }else if (this.accounts[i].accountType === 1) {
//           let x = this.findMonth(this.accounts[i].Date) - 1;
//           this.monthDatas_int[x] = this.monthDatas_int[x] + this.accounts[i].amount;
//           this.totalint = this.totalint + this.accounts[i].amount
//
//           // let y = this.findDay(this.accounts[i].Date) - 1;
//           // this.day_int[y] = this.day_int[y] + this.accounts[i].amount;
//         }
//       }
//     }
//   }
//
//
//   private timerId: number | null = null;
//
//   // 刷新数据的逻辑
//   refreshData() {
//     this.AccountTable.query(0, (result: AccountData[]) => {
//       this.accounts = result;
//     }, true);
//
//     // 重置每月数据
//     for (let i = 0; i < 12; i++) {
//       this.monthDatas_out[i] = 0;
//       this.monthDatas_int[i] = 0;
//     }
//     this.totalout = 0;
//     this.totalint = 0;
//
//     // 重新计算每月数据
//     for (let i = 0; i < this.accounts.length; i++) {
//       if (this.findyear(this.accounts[i].Date) === this.selectyear) {
//         if (this.accounts[i].accountType === 0) {
//           let x = this.findMonth(this.accounts[i].Date) - 1;
//           this.monthDatas_out[x] += this.accounts[i].amount;
//           this.totalout += this.accounts[i].amount;
//         } else if (this.accounts[i].accountType === 1) {
//           let x = this.findMonth(this.accounts[i].Date) - 1;
//           this.monthDatas_int[x] += this.accounts[i].amount;
//           this.totalint += this.accounts[i].amount;
//         }
//       }
//     }
//   }
//
//   // 启动定时器
//   startAutoRefresh() {
//     this.stopAutoRefresh(); // 防止重复启动
//     this.timerId = setInterval(() => {
//       this.refreshData();
//     }, 5000); // 每5秒刷新一次
//   }
//
//   // 停止定时器
//   stopAutoRefresh() {
//     if (this.timerId !== null) {
//       clearInterval(this.timerId);
//       this.timerId = null;
//     }
//   }
//
//   // 页面加载时启动定时器
//   onPageShow() {
//     this.startAutoRefresh();
//   }
//
//   // 页面卸载时清理定时器
//   onPageHide() {
//     this.stopAutoRefresh();
//   }
//
//   // 页面销毁时清理资源
//   onDestroy() {
//     this.stopAutoRefresh();
//   }
//
//
//
//
//
//   build() {
//     Column(){
//       Scroll(){
//         Column() {
//           Text(`数据分析`)
//             .height(`30vp`)
//             .fontSize(25)
//             .fontColor(Color.White)
//             .margin({top:'10vp'})
//           Row({ space: 14 }){
//             Row(){
//               Text('刷新')
//                 .fontSize($r('app.float.font_size_M'))
//                 .fontColor(Color.Black)
//                 .height($r('app.float.component_size_MP'))
//                 .textAlign(TextAlign.Center)
//                 .margin({left:'50vp'})
//
//               Image($rawfile('shuaxing.png'))
//                 .width('30vp')
//                 .height('30vp')
//             }.onClick(() => {
//               this.AccountTable.query(0, (result: AccountData[]) => {
//                 this.accounts = result;
//               }, true);
//               for (let i = 0; i < 12; i++) {
//                 this.monthDatas_out[i] = 0;
//                 this.monthDatas_int[i] = 0;
//               }
//               this.totalout = 0;
//               this.totalint = 0;
//               for (let i = 0; i < this.accounts.length; i++) {
//                 if(this.findyear(this.accounts[i].Date) === this.selectyear ){
//                   if(this.accounts[i].accountType === 0) {
//                     let x = this.findMonth(this.accounts[i].Date) - 1;
//                     this.monthDatas_out[x] = this.monthDatas_out[x] + this.accounts[i].amount;
//                     this.totalout = this.totalout + this.accounts[i].amount
//
//                     // let y = this.findDay(this.accounts[i].Date) - 1;
//                     // this.day_out[y] = this.day_out[y] + this.accounts[i].amount;
//                   }else if (this.accounts[i].accountType === 1) {
//                     let x = this.findMonth(this.accounts[i].Date) - 1;
//                     this.monthDatas_int[x] = this.monthDatas_int[x] + this.accounts[i].amount;
//                     this.totalint = this.totalint + this.accounts[i].amount
//
//                     // let y = this.findDay(this.accounts[i].Date) - 1;
//                     // this.day_int[y] = this.day_int[y] + this.accounts[i].amount;
//                   }
//                 }
//               }
//             })
//             .borderRadius($r('app.float.radius_size_M'))
//             .backgroundColor(Color.White)
//             .width('40%')
//             .height($r('app.float.component_size_MP'))
//
//             Text(`选择年份:${this.selectyear}`)
//               .fontSize($r('app.float.font_size_M'))
//               .fontColor(Color.Black)
//               .backgroundColor(Color.White)
//               .width('40%')
//               .height($r('app.float.component_size_MP'))
//
//               .textAlign(TextAlign.Center)
//               .borderRadius($r('app.float.radius_size_M'))
//               .onClick(() => {
//                 TextPickerDialog.show({
//                   range: this.years,
//                   selected: this.select,
//                   onAccept: (value: TextPickerResult) => {
//                     // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
//                     if (typeof value.index == "number") {
//                       this.selectyear = this.years[value.index];
//                     }
//                   }
//                 })
//               })
//
//           }
//           .margin({top:'10vp'})
//
//           Row(){
//             Column(){
//               Text(`${this.selectyear}年每月支出图`)
//                 .fontSize(15)
//               Text(`总支出:${this.totalout}`)
//                 .fontSize(15)
//             }.alignItems(HorizontalAlign.Center)
//           }.margin({top:'10vp'})
//
//           Row({ space: 5 }){
//             Column(){
//               Text(`${this.monthDatas_out[0]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[0] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('1月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 1;
//               this.clicktype =0;
//               this.setvalue(1);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[1]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[1] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('2月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 2;
//               this.clicktype =0;
//               this.setvalue(2);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[2]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[2] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('3月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 3;
//               this.clicktype =0;
//               this.setvalue(3);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[3]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[3] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('4月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 4;
//               this.clicktype =0;
//               this.setvalue(4);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[4]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[4] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('5月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 5;
//               this.clicktype =0;
//               this.setvalue(5);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[5]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[5] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('6月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 6;
//               this.clicktype =0;
//               this.setvalue(6);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[6]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[6] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('7月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 7;
//               this.clicktype =0;
//               this.setvalue(7);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[7]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[7] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('8月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 8;
//               this.clicktype =0;
//               this.setvalue(8);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[8]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[8] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('9月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 9;
//               this.clicktype =0;
//               this.setvalue(9);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[9]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[9] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('10月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 10;
//               this.clicktype =0;
//               this.setvalue(10);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[10]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[10] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('11月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 11;
//               this.clicktype =0;
//               this.setvalue(11);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_out[11]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_out[11] * (250/this.findMax())
//               }).fill($r('app.color.pay_color'))
//               Text('12月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 12;
//               this.clicktype =0;
//               this.setvalue(12);
//               this.daymax = this.findMaxday();
//               this.dialogController.open();
//             })
//           }
//           .alignItems(VerticalAlign.Bottom)
//           .backgroundColor(Color.White)
//           .height(275)
//           .width(CommonConstants.FULL_WIDTH)
//           .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
//           .margin({ top: $r('app.float.edge_size_SM') ,bottom: "15vp"})
//           .borderRadius($r('app.float.radius_size_M'))
//
//           Row(){
//             Column() {
//               Text(`${this.selectyear}年每月收入图`)
//                 .fontSize(15)
//               Text(`总收入:${this.totalint}`)
//                 .fontSize(15)
//             }.alignItems(HorizontalAlign.Center)
//           }
//
//           Row({ space: 5 }){
//             Column(){
//               Text(`${this.monthDatas_int[0]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[0] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('1月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 1;
//               this.clicktype =1;
//               this.setvalue(1);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[1]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[1] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('2月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 2;
//               this.clicktype =1;
//               this.setvalue(2);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[2]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[2] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('3月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 3;
//               this.clicktype =1;
//               this.setvalue(3);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[3]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[3] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('4月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 4;
//               this.clicktype =1;
//               this.setvalue(4);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[4]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[4] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('5月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 5;
//               this.clicktype =1;
//               this.setvalue(5);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[5]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[5] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('6月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 6;
//               this.clicktype =1;
//               this.setvalue(6);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[6]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[6] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('7月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 7;
//               this.clicktype =1;
//               this.setvalue(7);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[7]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[7] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('8月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 8;
//               this.clicktype =1;
//               this.setvalue(8);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[8]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[8] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('9月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 9;
//               this.clicktype =1;
//               this.setvalue(9);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[9]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[9] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('10月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 10;
//               this.clicktype =1;
//               this.setvalue(10);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[10]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[10] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('11月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 11;
//               this.clicktype =1;
//               this.setvalue(11);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//             Column(){
//               Text(`${this.monthDatas_int[11]}`)
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//               Rect({
//                 width: '7%',
//                 height: this.monthDatas_int[11] * (250/this.findMax1())
//               }).fill($r('app.color.main_color'))
//               Text('12月')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.onClick(() => {
//               this.clickyear = this.selectyear;
//               this.clickmonth = 12;
//               this.clicktype =1;
//               this.setvalue(12);
//               this.daymax = this.findMaxday1();
//               this.dialogController1.open();
//             })
//
//
//           }.alignItems(VerticalAlign.Bottom)
//           .backgroundColor(Color.White)
//           .height(275)
//           .width(CommonConstants.FULL_WIDTH)
//           .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
//           .margin({ top: $r('app.float.edge_size_SM') })
//           .borderRadius($r('app.float.radius_size_M'))
//         }.width("94%").alignItems(HorizontalAlign.Center)
//       }
//     }.backgroundColor($r('app.color.themeColor')).width("100%").height("100%")
//
//   }
// }
//
//
// @CustomDialog
// struct MonthgraphDialog {
//   controller: CustomDialogController
//   @Link daymax: number;
//   @Link clickyear: string;
//   @Link clickmonth: number;
//   @Link clicktype: number;
//   @Link day_out: number[];
//   scroller: Scroller = new Scroller()
//   cancel: () => void = () => {console.log("cancel")}
//   confirm: () => void= () => {console.log("confirm")}
//
//   build() {
//     Column() {
//       Text(`${this.clickyear}年${this.clickmonth}月支出图`)
//         .fontSize(20)
//         .margin({ bottom: $r('app.float.edge_size_SM') })
//       // Text(`${this.clicktype}`)
//       //   .fontSize(20)
//       // Text(`${this.daymax}`)
//       //   .fontSize(20)
//       // Text(`${this.day_out[0]}`)
//       //   .fontSize(20)
//       Scroll(this.scroller) {
//         Row() {
//           Column() {
//             Polyline({ width: 750, height: 220 })
//               .points(
//                 [
//                 [0, 200 - this.day_out[0] * (200 / this.daymax)],
//                 [25, 200 - this.day_out[1] * (200 / this.daymax)],
//                 [50, 200 - this.day_out[2] * (200 / this.daymax)],
//                 [75, 200 - this.day_out[3] * (200 / this.daymax)],
//                 [100, 200 - this.day_out[4] * (200 / this.daymax)],
//                 [125, 200 - this.day_out[5] * (200 / this.daymax)],
//                 [150, 200 - this.day_out[6] * (200 / this.daymax)],
//                 [175, 200 - this.day_out[7] * (200 / this.daymax)],
//                 [200, 200 - this.day_out[8] * (200 / this.daymax)],
//                 [225, 200 - this.day_out[9] * (200 / this.daymax)],
//                 [250, 200 - this.day_out[10] * (200 / this.daymax)],
//                 [275, 200 - this.day_out[11] * (200 / this.daymax)],
//                 [300, 200 - this.day_out[12] * (200 / this.daymax)],
//                 [325, 200 - this.day_out[13] * (200 / this.daymax)],
//                 [350, 200 - this.day_out[14] * (200 / this.daymax)],
//                 [375, 200 - this.day_out[15] * (200 / this.daymax)],
//                 [400, 200 - this.day_out[16] * (200 / this.daymax)],
//                 [425, 200 - this.day_out[17] * (200 / this.daymax)],
//                 [450, 200 - this.day_out[18] * (200 / this.daymax)],
//                 [475, 200 - this.day_out[19] * (200 / this.daymax)],
//                 [500, 200 - this.day_out[20] * (200 / this.daymax)],
//                 [525, 200 - this.day_out[21] * (200 / this.daymax)],
//                 [550, 200 - this.day_out[22] * (200 / this.daymax)],
//                 [575, 200 - this.day_out[23] * (200 / this.daymax)],
//                 [600, 200 - this.day_out[24] * (200 / this.daymax)],
//                 [625, 200 - this.day_out[25] * (200 / this.daymax)],
//                 [650, 200 - this.day_out[26] * (200 / this.daymax)],
//                 [675, 200 - this.day_out[27] * (200 / this.daymax)],
//                 [700, 200 - this.day_out[28] * (200 / this.daymax)],
//                 [725, 200 - this.day_out[29] * (200 / this.daymax)],
//                 [750, 200 - this.day_out[30] * (200 / this.daymax)]
//               ]
//
//               )
//               .fillOpacity(0)
//               .stroke($r('app.color.pay_color'))
//               .strokeWidth(1)
//
//             Row({ space: 5 }){
//               Text('1号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('2号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('3号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('4号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('5号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('6号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('7号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('8号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('9号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('10号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('11号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('12号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('13号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('14号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('15号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('16号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('17号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('18号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('19号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('20号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('21号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('22号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('23号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('24号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('25号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('26号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('27号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('28号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('29号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('30号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('31号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.margin({bottom:"5vp"})
//           }
//         }
//       }
//       .scrollable(ScrollDirection.Horizontal) // 滚动方向纵向
//       .scrollBar(BarState.On) // 滚动条常驻显示
//       .scrollBarColor(Color.Gray) // 滚动条颜色
//       .scrollBarWidth(1) // 滚动条宽度
//       .edgeEffect(EdgeEffect.None)
//
//
//       Flex({ justifyContent: FlexAlign.SpaceAround }) {
//         Button('关闭')
//           .onClick(() => {
//             this.controller.close()
//             this.cancel()
//           }).backgroundColor(0xffffff).fontColor(Color.Black)
//       }.margin({ bottom: 10 })
//     }.backgroundColor(0xffffff).width("95%").borderRadius("20vp")
//   }
// }
//
// @CustomDialog
// struct MonthgraphDialog1 {
//   controller?: CustomDialogController;
//   @Link daymax: number;
//   @Link clickyear: string;
//   @Link clickmonth: number;
//   @Link clicktype: number;
//   @Link day_int: number[];
//   scroller: Scroller = new Scroller()
//   cancel: () => void = () => {console.log("cancel")}
//   confirm: () => void = () => {console.log("confirm")}
//
//
//   build() {
//     Column() {
//       Text(`${this.clickyear}年${this.clickmonth}月收入图`)
//         .fontSize(20)
//
//       // Text(`${this.clicktype}`)
//       //   .fontSize(20)
//       // Text(`${this.daymax}`)
//       //   .fontSize(20)
//       Scroll(this.scroller) {
//         Row() {
//           Column() {
//             Polyline({ width: 750, height: 220 })
//               .points([
//                 [0, 200 - this.day_int[0] * (200 / this.daymax)],
//                 [25, 200 - this.day_int[1] * (200 / this.daymax)],
//                 [50, 200 - this.day_int[2] * (200 / this.daymax)],
//                 [75, 200 - this.day_int[3] * (200 / this.daymax)],
//                 [100, 200 - this.day_int[4] * (200 / this.daymax)],
//                 [125, 200 - this.day_int[5] * (200 / this.daymax)],
//                 [150, 200 - this.day_int[6] * (200 / this.daymax)],
//                 [175, 200 - this.day_int[7] * (200 / this.daymax)],
//                 [200, 200 - this.day_int[8] * (200 / this.daymax)],
//                 [225, 200 - this.day_int[9] * (200 / this.daymax)],
//                 [250, 200 - this.day_int[10] * (200 / this.daymax)],
//                 [275, 200 - this.day_int[11] * (200 / this.daymax)],
//                 [300, 200 - this.day_int[12] * (200 / this.daymax)],
//                 [325, 200 - this.day_int[13] * (200 / this.daymax)],
//                 [350, 200 - this.day_int[14] * (200 / this.daymax)],
//                 [375, 200 - this.day_int[15] * (200 / this.daymax)],
//                 [400, 200 - this.day_int[16] * (200 / this.daymax)],
//                 [425, 200 - this.day_int[17] * (200 / this.daymax)],
//                 [450, 200 - this.day_int[18] * (200 / this.daymax)],
//                 [475, 200 - this.day_int[19] * (200 / this.daymax)],
//                 [500, 200 - this.day_int[20] * (200 / this.daymax)],
//                 [525, 200 - this.day_int[21] * (200 / this.daymax)],
//                 [550, 200 - this.day_int[22] * (200 / this.daymax)],
//                 [575, 200 - this.day_int[23] * (200 / this.daymax)],
//                 [600, 200 - this.day_int[24] * (200 / this.daymax)],
//                 [625, 200 - this.day_int[25] * (200 / this.daymax)],
//                 [650, 200 - this.day_int[26] * (200 / this.daymax)],
//                 [675, 200 - this.day_int[27] * (200 / this.daymax)],
//                 [700, 200 - this.day_int[28] * (200 / this.daymax)],
//                 [725, 200 - this.day_int[29] * (200 / this.daymax)],
//                 [750, 200 - this.day_int[30] * (200 / this.daymax)]
//               ]
//
//               )
//               .fillOpacity(0)
//               .stroke($r('app.color.main_color'))
//               .strokeWidth(1)
//
//             Row({ space: 5 }){
//               Text('1号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('2号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('3号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('4号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('5号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('6号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('7号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('8号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('9号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('10号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('11号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('12号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('13号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('14号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('15号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('16号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('17号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('18号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('19号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('20号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('21号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('22号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('23号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('24号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('25号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('26号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('27号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('28号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('29号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('30号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//
//               Text('31号')
//                 .fontSize("10vp")
//                 .fontColor(Color.Black)
//             }.margin({bottom:"5vp"})
//           }
//         }
//       }
//       .scrollable(ScrollDirection.Horizontal) // 滚动方向纵向
//       .scrollBar(BarState.On) // 滚动条常驻显示
//       .scrollBarColor(Color.Gray) // 滚动条颜色
//       .scrollBarWidth(2) // 滚动条宽度
//       .edgeEffect(EdgeEffect.None)
//
//
//       Flex({ justifyContent: FlexAlign.SpaceAround }) {
//         Button('关闭')
//           .onClick(() => {
//             if (this.controller) {
//               this.controller.close();
//             } else {
//               console.error("Controller is undefined");
//             }
//             this.cancel();
//           }).backgroundColor(0xffffff).fontColor(Color.Black)
//       }.margin({ bottom: 10 })
//     }.backgroundColor(0xffffff).width("95%").borderRadius("20vp")
//   }
// }
