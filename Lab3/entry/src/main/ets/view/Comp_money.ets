// import MoneyTable from '../common/database/tables/MoneyTable';
// import MoneyData from '../viewmodel/MoneyData';
// import CommonConstants from '../common/constants/CommonConstants';
// import { DialogMoney } from '../view/DialogMoney';
// import { ImageList } from '../viewmodel/MoneyList';
// import Logger from '../common/utils/Logger';
// import AccountTable from '../common/database/tables/AccountTable';
// import AccountData from '../viewmodel/AccountData';
//
// @Component
// export default struct Comp_money {
//   @State accounts: Array<AccountData> = [];
//   @State newAccount: AccountData = { id: 0, accountType: 0, typeText: '', amount: 0 ,Date:'',remark:''};
//   private AccountTable = new AccountTable(() => {});
//   @State totalhua_month: number = 0;
//   @State totalhua_year: number = 0;
//
//   @State yusuan_month: number = 0;
//   @State yusuan_year: number = 0;
//
//   @State money: Array<MoneyData> = [];
//   @State searchText: string = '';
//   @State isInsert: boolean = false;
//   @State newMoney: MoneyData = { id: 0, accountType: 0, typeText: '', amount: 0,remark:''};
//   @State index: number = -1;
//   @State totalint: number = 0;
//   @State totalout: number = 0;
//   private MoneyTable = new MoneyTable(() => {});
//   private deleteList: Array<MoneyData> = [];
//
//   controller: TextClockController = new TextClockController();
//   searchController: SearchController = new SearchController();
//   private scrollerForList: Scroller = new Scroller()
//   dialogController: CustomDialogController = new CustomDialogController({
//     builder: DialogMoney({
//       isInsert: $isInsert,
//       newMoney: $newMoney,
//       confirm: (isInsert: boolean, newMony: MoneyData) => this.accept(isInsert, newMony)
//     }),
//     customStyle: true,
//     alignment: DialogAlignment.Bottom,
//   });
//
//   dialogController1: CustomDialogController = new CustomDialogController({
//     builder: Dialogshuiwu({
//     }),
//     alignment: DialogAlignment.Default,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
//   })
//   accept(isInsert: boolean, newMoney: MoneyData): void {
//     if (isInsert) {
//       Logger.info(`${CommonConstants.INDEX_TAG}`, `The account inserted is:  ${JSON.stringify(newMoney)}`);
//       this.MoneyTable.insertData(newMoney, (id: number) => {
//         newMoney.id =id;
//         this.money.push(newMoney);
//       });
//     } else {
//       this.MoneyTable.updateData(newMoney, () => {
//       });
//       let list = this.money;
//       this.money = [];
//       list[this.index] = newMoney;
//       this.money = list;
//       this.index = -1;
//     }
//   }
//   aboutToAppear() {
//     this.MoneyTable.getRdbStore(() => {
//       this.MoneyTable.query(0, (result: MoneyData[]) => {
//         this.money = result;
//       }, true);
//     });
//   }
//   selectListItem(item: MoneyData) {
//     this.isInsert = false;
//     this.index = this.money.indexOf(item);
//     this.newMoney = {
//       id: item.id,
//       accountType: item.accountType,
//       typeText: item.typeText,
//       amount: item.amount,
//       remark:item.remark,
//     };
//   }
//   deleteListItem() {
//     for (let i = 0; i < this.deleteList.length; i++) {
//       let index = this.money.indexOf(this.deleteList[i]);
//       this.money.splice(index, 1);
//       // if(this.deleteList[i].accountType === 1){
//       //   this.totalint = this.totalint - this.deleteList[i].amount;
//       // }else if(this.deleteList[i].accountType === 0){
//       //   this.totalout = this.totalout - this.deleteList[i].amount;
//       // }
//       this.MoneyTable.deleteData(this.deleteList[i], () => {
//       });
//     }
//     this.deleteList = [];
//   }
//   @Builder itemEnd(index: number,item:MoneyData) {
//     // 侧滑后尾端出现的组件
//     Button({ type: ButtonType.Circle }) {
//       Image($rawfile('delete.png'))
//     }
//     .width($r('app.float.component_size_MP'))
//     .height($r('app.float.component_size_MP'))
//     .backgroundColor($r('app.color.background_color'))
//     .onClick(() => {
//       this.deleteList.push(item);
//       this.deleteListItem();
//     })
//   }
//   findMonth(date: string): number {
//     // 获取日期字符串中的月份部分，并将其转换为数字
//     return Number(date.split('-')[1]);
//   }
//   findyear(date: string): number {
//     // 获取日期字符串中的月份部分，并将其转换为数字
//     return Number(date.split('-')[0]);
//   }
//   build() {
//     Column(){
//       Scroll(){
//         Column() {
//           Text(`资产管家`)
//             .height(`30vp`)
//             .fontSize(25)
//             .fontColor(Color.White)
//             .margin({top:'10vp'})
//           Row() {
//             Column() {
//               Text(`净资产`)
//                 .height($r('app.float.component_size_SP'))
//                 .fontSize(20)
//               Text(`${this.totalint - this.totalout}`)
//                 .height($r('app.float.component_size_SP'))
//                 .fontSize(20)
//                 .fontColor(this.totalint - this.totalout >= 0 ? $r('app.color.main_color') : $r('app.color.pay_color'))
//             }.margin({ left: ('12vp') })
//
//             Column() {
//               Text(`总资产`)
//                 .height($r('app.float.component_size_SP'))
//                 .fontSize(20)
//               Text(`${this.totalint}`)
//                 .height($r('app.float.component_size_SP'))
//                 .fontSize(20)
//                 .fontColor($r('app.color.main_color'))
//             }.margin({ left: ('12vp') })
//
//             Column() {
//               Text(`总负债`)
//                 .height($r('app.float.component_size_SP'))
//                 .fontSize(20)
//               Text(`${this.totalout}`)
//                 .height($r('app.float.component_size_SP'))
//                 .fontSize(20)
//                 .fontColor($r('app.color.pay_color'))
//             }.margin({ right: ('12vp') })
//           }
//           .width(CommonConstants.FULL_WIDTH)
//           .justifyContent(FlexAlign.SpaceBetween)
//           .margin({ top: ('5vp'), bottom: ('0vp') })
//
//           Row() {
//             List({ space: CommonConstants.FULL_SIZE, scroller: this.scrollerForList }) {
//               ForEach(this.money, (item: MoneyData) => {
//                 ListItem() {
//                   Row() {
//                     Image(ImageList[item.typeText])
//                       .width($r('app.float.component_size_M'))
//                       .aspectRatio(CommonConstants.FULL_SIZE)
//                       .margin({ right: $r('app.float.edge_size_MP') })
//
//                     Row({space:8}){
//                       Text(item.typeText)
//                         .height($r('app.float.component_size_SM'))
//                         .fontSize($r('app.float.font_size_M'))
//                       if(item.remark === ''){
//                         Text(`备注:无`)
//                           .height($r('app.float.component_size_SM'))
//                           .fontSize($r('app.float.font_size_M'))
//                       }else {
//                         Text(`备注:${item.remark}`)
//                           .height($r('app.float.component_size_SM'))
//                           .fontSize($r('app.float.font_size_M'))
//                       }
//                     }
//
//                     Blank()
//                       .layoutWeight(1)
//
//                     Text(
//                       item.accountType === 0 ? '-' + item.amount.toString() :
//                         item.accountType === 1 ? '+' + item.amount.toString() :
//                         item.amount.toString()
//
//                     )
//                       .fontSize($r('app.float.font_size_M'))
//                       .fontColor(
//                         item.accountType === 0 ? $r('app.color.pay_color') :
//                           item.accountType === 1 ? $r('app.color.main_color'):
//                           $r('app.color.black')
//                       )
//                       .align(Alignment.End)
//                       .flexGrow(CommonConstants.FULL_SIZE)
//                       .onAppear(() => {
//                         if (item.accountType === 1) {
//                           this.totalint = this.totalint + item.amount;
//                         } else if (item.accountType === 0){
//                           this.totalout = this.totalout + item.amount;
//                         }
//                       })
//                   }
//                   .width(CommonConstants.FULL_WIDTH)
//                   .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
//                 }.swipeAction({ end: () => {
//                   this.itemEnd(this.index, item)
//                 } }) // 设置侧滑属性.
//                 .width(CommonConstants.FULL_WIDTH)
//                 .height($r('app.float.component_size_LM'))
//                 .onClick(() => {
//                   this.selectListItem(item);
//                   this.dialogController.open();
//                 })
//               })
//             }
//             .height("47%")
//             .width(CommonConstants.FULL_WIDTH)
//             .borderRadius($r('app.float.radius_size_M'))
//             .backgroundColor(Color.White)
//             .divider({
//               strokeWidth: 1,
//               startMargin: 60,
//               endMargin: 10,
//               color: '#ffe9f0f0'
//             })
//           }
//           .width(CommonConstants.FULL_WIDTH)
//           .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
//           .margin({ top: $r('app.float.edge_size_SM') })
//
//           Row({space:8}){
//             Text('添加资产/预算')
//               .fontSize($r('app.float.font_size_M'))
//               .fontColor(Color.Black)
//               .borderRadius($r('app.float.radius_size_M'))
//               .textAlign(TextAlign.Center)
//               .backgroundColor(Color.White)
//               .width('72%')
//               .height($r('app.float.component_size_MP'))
//               .onClick(() => {
//                 this.isInsert = true;
//                 this.newMoney = { id: 0, accountType: 0, typeText: '', amount: 0 ,remark:''};
//                 this.dialogController.open();
//               })
//
//             Text('刷新预算')
//               .fontSize($r('app.float.font_size_M'))
//               .fontColor(Color.Black)
//               .backgroundColor(Color.White)
//               .width('20%')
//               .height($r('app.float.component_size_MP'))
//
//               .textAlign(TextAlign.Center)
//               .borderRadius($r('app.float.radius_size_M'))
//               .onClick(() => {
//                 this.yusuan_month = 0;
//                 this.yusuan_year = 0;
//                 this.totalhua_year = 0;
//                 this.totalhua_month= 0;
//                 this.AccountTable.query(0, (result: AccountData[]) => {
//                   this.accounts = result;
//                 }, true);
//                 // this.MoneyTable.query(0, (result: MoneyData[]) => {
//                 //   this.money = result;
//                 // }, true);
//                 // for (let i = 0; i < this.money.length; i++) {
//                 //   if(this.money[i].accountType === 2){
//                 //     if(this.money[i].typeText === '月度预算'){
//                 //       this.yusuan_month = 10000;
//                 //     }else{
//                 //       this.yusuan_year = 20000;
//                 //     }
//                 //   }
//                 // }
//                 this.yusuan_month = 3000;
//                 this.yusuan_year = 10000;
//                 for (let i = 0; i < this.accounts.length; i++) {
//                   if(this.findMonth(this.accounts[i].Date) === 11){
//                     if(this.accounts[i].accountType === 0) {
//                       this.totalhua_month = this.totalhua_month + this.accounts[i].amount;
//                     }
//                   }
//                   if(this.findyear(this.accounts[i].Date) === 2023) {
//                     if(this.accounts[i].accountType === 0) {
//                       this.totalhua_year = this.totalhua_year + this.accounts[i].amount;
//                     }
//
//                   }
//                 }
//
//               })
//           }.margin({ top: '8vp' })
//
//           Row({ space: 8 }) {
//             Column(){
//               Text('月度预算')
//                 .fontSize($r('app.float.font_size_M'))
//                 .fontColor(Color.Black)
//                 .textAlign(TextAlign.Center)
//                 .margin({top:'4vp'})
//               Stack() {
//                 if(this.yusuan_month === 0){
//                   DataPanel({ values: [0], max: 100, type: DataPanelType.Circle }).width(187).height(165)
//                 }else{
//                   DataPanel({ values: [this.totalhua_month], max: this.yusuan_month, type: DataPanelType.Circle }).width(187).height(168)
//                 }
//                 Column() {
//                   if(this.yusuan_month === 0){
//                     Text('0').fontSize(35).fontColor('#182431')
//                   }else{
//                     Text(`${((this.totalhua_month/this.yusuan_month)*100).toFixed(1)}`).fontSize(35).fontColor('#182431')
//                   }
//                   Text(`已花费${this.totalhua_month}`).fontSize(8.17).lineHeight(11.08).fontWeight(500).opacity(0.6)
//                 }
//
//                 Text('%')
//                   .fontSize(9.33)
//                   .lineHeight(12.83)
//                   .fontWeight(500)
//                   .opacity(0.6)
//                   .position({ x: 104.42, y: 78.17 })
//               }
//             }.backgroundColor(Color.White)
//             .borderRadius('20vp')
//             .height(168)
//             Column() {
//               Text('年度预算')
//                 .fontSize($r('app.float.font_size_M'))
//                 .fontColor(Color.Black)
//                 .textAlign(TextAlign.Center)
//                 .margin({ top: '4vp' })
//               Stack() {
//
//                 if(this.yusuan_year === 0){
//                   DataPanel({ values: [0], max:100, type: DataPanelType.Circle }).width(187).height(165)
//                 }else{
//                   DataPanel({ values: [this.totalhua_year], max:this.yusuan_year, type: DataPanelType.Circle }).width(187).height(168)
//                 }
//                 Column() {
//                   if(this.yusuan_year === 0){
//                     Text('0').fontSize(35).fontColor('#182431')
//                   }else{
//                     Text(`${((this.totalhua_year/this.yusuan_year)*100).toFixed(1)}`).fontSize(35).fontColor('#182431')
//                   }
//                   Text(`已花费${this.totalhua_year}`).fontSize(8.17).lineHeight(11.08).fontWeight(500).opacity(0.6)
//                 }
//
//                 Text('%')
//                   .fontSize(9.33)
//                   .lineHeight(12.83)
//                   .fontWeight(500)
//                   .opacity(0.6)
//                   .position({ x: 104.42, y: 78.17 })
//               }
//             }.backgroundColor(Color.White)
//             .borderRadius('20vp')
//             .height(168)
//           }
//           .margin({ top: '8vp' })
//
//           Row({ space: 8 }) {
//             Text('个人所得税计算器')
//               .fontSize($r('app.float.font_size_M'))
//               .fontColor(Color.Black)
//               .backgroundColor(Color.White)
//               .width('94%')
//               .height('48vp')
//
//               .textAlign(TextAlign.Center)
//               .borderRadius($r('app.float.radius_size_M'))
//               .onClick(() => {
//                 this.dialogController1.open()
//               })
//           }.margin({ top: '8vp' })
//         }
//         .width(CommonConstants.FULL_WIDTH)
//         .height(CommonConstants.FULL_HEIGHT)
//         .backgroundColor($r('app.color.themeColor'))
//       }
//     }
//   }
// }
//
// // xxx.ets
// @CustomDialog
// struct Dialogshuiwu {
//   controller: CustomDialogController
//   @State incometype: string = "工资(月薪)";
//   @State money: number = 0;
//
//   @State jiao_shui: number = 0;
//   @State tui_shui: number = 0;
//
//   @State shou_ru: string = '';
//   @State gong_ji: string = '';
//   @State zhuan_xiang: string = '';
//   @State selecttype: number = 0;
//
//   @State selectyeartype: number = 0;
//   @State year: string = "小于一个月";
//   private yeartype: string[] = ['小于1个月','1个月到1年','大于1年'];
//   private type: string[] = ['工资(月薪)', '年终奖(全年)', '劳务报酬', '稿酬所得', '偶然所得','利息、股息所得'];
//   private select: number = 0;
//   private select1: number = 1;
//   caculate(): void {
//     if(this.selecttype === 0){
//       this.jiao_shui = 0;
//       this.money = Number(this.shou_ru)- 5000 - Number(this.gong_ji) - Number(this.zhuan_xiang);
//       if(this.money <= 0 ){
//         this.money = 0;
//       }else if(this.money > 0 && this.money <= 3000){
//         this.jiao_shui = this.money * 0.03;
//       }else if(this.money > 3000 && this.money <= 12000){
//         this.jiao_shui = this.money * 0.10 - 210;
//       }else if(this.money > 12000 && this.money <= 25000){
//         this.jiao_shui = this.money * 0.20 - 1410;
//       }else if(this.money > 25000 && this.money <= 35000){
//         this.jiao_shui = this.money * 0.25 - 2660;
//       }else if(this.money > 35000 && this.money <= 55000){
//         this.jiao_shui = this.money * 0.30 - 4410;
//       }else if(this.money > 55000 && this.money <= 80000){
//         this.jiao_shui = this.money * 0.35 - 7160;
//       }else if(this.money > 80000){
//         this.jiao_shui = this.money * 0.45 - 15160;
//       }
//     }
//     else if(this.selecttype === 1){
//       this.jiao_shui = 0;
//       this.money = Number(this.shou_ru);
//       if(this.money > 0 && this.money <= 36000){
//         this.jiao_shui = this.money * 0.03;
//       }else if(this.money > 36000 && this.money <= 144000){
//         this.jiao_shui = this.money * 0.10 - 2520;
//       }else if(this.money > 144000 && this.money <= 300000){
//         this.jiao_shui = this.money * 0.20 - 16920;
//       }else if(this.money > 300000 && this.money <= 420000){
//         this.jiao_shui = this.money * 0.25 - 31920;
//       }else if(this.money > 420000 && this.money <= 660000){
//         this.jiao_shui = this.money * 0.30 - 52920;
//       }else if(this.money > 660000 && this.money <= 960000){
//         this.jiao_shui = this.money * 0.35 - 85920;
//       }else if(this.money > 960000){
//         this.jiao_shui = this.money * 0.45 - 181920;
//       }
//     }
//     else if(this.selecttype === 2){
//       this.jiao_shui = 0;
//       this.money = Number(this.shou_ru);
//       if(this.money <= 4000){
//         this.money = this.money - 800;
//         if(this.money > 0 && this.money <=20000 ){
//           this.jiao_shui = this.money * 0.2
//         }else if(this.money > 20000 && this.money <=50000 ){
//           this.jiao_shui = this.money * 0.3
//         }else if(this.money > 50000){
//           this.jiao_shui = this.money * 0.4
//         }
//       }else if(this.money > 4000){
//         this.money = this.money * 0.8;
//         if(this.money > 0 && this.money <=20000 ){
//           this.jiao_shui = this.money * 0.2
//         }else if(this.money > 20000 && this.money <=50000 ){
//           this.jiao_shui = this.money * 0.3 - 2000
//         }else if(this.money > 50000){
//           this.jiao_shui = this.money * 0.4 - 7000
//         }
//       }
//     }
//     else if(this.selecttype === 3){
//       this.jiao_shui = 0;
//       this.money = Number(this.shou_ru);
//       if(this.money <= 4000) {
//         this.money = (this.money - 800) * 0.2 * 0.7;
//       }else{
//         this.money = (this.money) * 0.8 * 0.2 * 0.7;
//       }
//       if(this.money > 0 && this.money <= 36000){
//         this.jiao_shui = this.money * 0.03;
//       }else if(this.money > 36000 && this.money <= 144000){
//         this.jiao_shui = this.money * 0.10 - 2520;
//       }else if(this.money > 144000 && this.money <= 300000){
//         this.jiao_shui = this.money * 0.20 - 16920;
//       }else if(this.money > 300000 && this.money <= 420000){
//         this.jiao_shui = this.money * 0.25 - 31920;
//       }else if(this.money > 420000 && this.money <= 660000){
//         this.jiao_shui = this.money * 0.30 - 52920;
//       }else if(this.money > 660000 && this.money <= 960000){
//         this.jiao_shui = this.money * 0.35 - 85920;
//       }else if(this.money > 960000){
//         this.jiao_shui = this.money * 0.45 - 181920;
//       }
//     }
//     else if(this.selecttype === 4){
//       this.jiao_shui = 0;
//       this.money = Number(this.shou_ru);
//       if(this.money <= 10000){
//         this.money =0;
//       }else{
//         this.jiao_shui = this.money * 0.2;
//       }
//     }
//     else if(this.selecttype === 5) {
//       this.jiao_shui = 0;
//       this.money = Number(this.shou_ru);
//       if(this.selectyeartype === 0){
//
//         this.jiao_shui = this.money * 0.2;
//       }else if(this.selectyeartype === 1) {
//         this.money = this.money * 0.5;
//         this.jiao_shui = this.money * 0.2;
//       }else if(this.selectyeartype === 2) {
//         this.money = this.money * 0;
//         this.jiao_shui = this.money * 0.2;
//       }
//     }
//   }
//   build() {
//     Column() {
//       Text('个税计算器').fontSize(20).margin({ top: 10, bottom: 10 })
//
//       Column({space:5}){
//         Row(){
//           Text('收入类型:')
//             .fontSize($r('app.float.font_size_M'))
//             .fontColor(Color.Black)
//             .margin({right:'20vp'})
//           Row(){
//             Text(`${this.incometype}`)
//               .margin({left:'5vp'})
//             Image($rawfile('half.png'))
//               .width('20vp')
//           }.width('35%')
//           .height('35vp')
//           .borderColor(Color.Black)
//           .borderWidth(1)
//           .onClick(() => {
//             TextPickerDialog.show({
//               range: this.type,
//               selected: this.select,
//               onAccept: (value: TextPickerResult) => {
//                 if (typeof  value.index == "number"){
//                   this.incometype = this.type[value.index];
//                   this.selecttype = value.index;
//                 }
//               }
//             })
//           })
//         }
//         Row(){
//           Text('收入数额:')
//             .fontSize($r('app.float.font_size_M'))
//             .fontColor(Color.Black)
//             .margin({right:'20vp'})
//           TextInput({
//             placeholder: $r('app.string.input_text'),
//           })
//             .width('35%')
//             .height('35vp')
//             .borderRadius(CommonConstants.MINIMUM_SIZE)
//             .backgroundColor(Color.White)
//             .borderWidth(1)
//             .borderColor(Color.Black)
//             .type(InputType.Number)
//             .onChange((value: string) => {
//               this.shou_ru = value;
//             })
//         }
//         if (this.selecttype === 0){
//           Row(){
//             Text('社保、公积金:')
//               .fontSize($r('app.float.font_size_M'))
//               .fontColor(Color.Black)
//               .margin({right:'20vp'})
//             TextInput({
//               placeholder: $r('app.string.input_text'),
//             })
//               .width('35%')
//               .height('35vp')
//               .borderRadius(CommonConstants.MINIMUM_SIZE)
//               .backgroundColor(Color.White)
//               .borderWidth(1)
//               .borderColor(Color.Black)
//               .type(InputType.Number)
//               .onChange((value: string) => {
//                 this.gong_ji = value;
//               })
//           }
//
//           Row(){
//             Text('专项附加扣除:')
//               .fontSize($r('app.float.font_size_M'))
//               .fontColor(Color.Black)
//               .margin({right:'20vp'})
//             TextInput({
//               placeholder: $r('app.string.input_text'),
//             })
//               .width('35%')
//               .height('35vp')
//               .borderRadius(CommonConstants.MINIMUM_SIZE)
//               .backgroundColor(Color.White)
//               .borderWidth(1)
//               .borderColor(Color.Black)
//               .type(InputType.Number)
//               .onChange((value: string) => {
//                 this.zhuan_xiang = value;
//               })
//           }
//         }
//
//         if (this.selecttype === 5){
//           Row(){
//             Text('持股时间:')
//               .fontSize($r('app.float.font_size_M'))
//               .fontColor(Color.Black)
//               .margin({right:'20vp'})
//             Row(){
//               Text(`${this.year}`)
//                 .margin({left:'5vp'})
//               Image($rawfile('half.png'))
//                 .width('20vp')
//             }.width('35%')
//             .height('35vp')
//             .borderColor(Color.Black)
//             .borderWidth(1)
//             .onClick(() => {
//               TextPickerDialog.show({
//                 range: this.yeartype,
//                 selected: this.select1,
//                 onAccept: (value: TextPickerResult) => {
//                   if (typeof value.index == "number") {
//                     this.year = this.yeartype[value.index];
//                     this.selectyeartype = value.index;
//                   }
//                 }
//               })
//             })
//           }
//         }
//
//         Row(){
//           Text('计税税额:')
//             .fontSize($r('app.float.font_size_M'))
//             .fontColor(Color.Black)
//             .margin({right:'20vp'})
//           Text(`${(this.money).toFixed(1)}`)
//             .fontSize($r('app.float.font_size_M'))
//             .fontColor(Color.Black)
//             .width('35%')
//             .height('35vp')
//         }
//
//         Row(){
//           Text('应缴税额:')
//             .fontSize($r('app.float.font_size_M'))
//             .fontColor(Color.Black)
//             .margin({right:'20vp'})
//           Text(`${(this.jiao_shui).toFixed(1)}`)
//             .fontSize($r('app.float.font_size_M'))
//             .fontColor(Color.Black)
//             .width('35%')
//             .height('35vp')
//         }
//       }.alignItems(HorizontalAlign.End)
//
//       Flex({ justifyContent: FlexAlign.SpaceAround }) {
//         Button('退出')
//           .width("40%")
//           .onClick(() => {
//             this.controller.close()
//           }).backgroundColor(Color.Orange).fontColor(Color.White)
//         Button('计算')
//           .width("40%")
//           .onClick(() => {
//             this.caculate();
//           }).backgroundColor(Color.Orange).fontColor(Color.White)
//       }.margin({ bottom: 10 })
//     }
//   }
// }