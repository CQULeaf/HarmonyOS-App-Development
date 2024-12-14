import CommonConstants from '../common/constants/CommonConstants';
import { ImageList } from '../viewmodel/AccountList';
import { recordDelete, recordList } from '../api/record';

interface ResponseRecordList extends Array<AccountData> {}

interface ResponseRecordDelete {
  id: number;
}

interface AccountData {
  id: number;
  username: string;
  category: string;
  amount: number;
  description?: string;
  date: Date;
  type: number;
  createdAt: string;
}

@Component
export default struct Comp_account {
  @StorageProp('CurrentUsername') username: string = '';
  @State total_out: number = 0;
  @State total_in: number = 0;
  @State totalCount: number = 0;
  @State totalDays: number = 0;
  @State searchText: string = '';
  @State index: number = -1;
  @State accounts: Array<AccountData> = [];
  controller: TextClockController = new TextClockController();
  searchController: SearchController = new SearchController();
  private scrollerForList: Scroller = new Scroller()

  async recordDelete(id: number) {
    try {
      const response = await recordDelete<ResponseRecordDelete>(id);
      console.log('删除成功:', response);
    } catch (error) {
      console.log(error);
    }
  }

  async recordList() {
    try {
      const response = await recordList<ResponseRecordList>(this.username);
      this.accounts = response;
      console.log('查询成功:', response);

      this.total_in = 0;
      this.total_out = 0;

      // 用于存储不同的记账日期
      const uniqueDates = new Set<string>();

      // 先进行数据过滤
      const filteredAccounts = this.accounts.filter(account => {
        const lowerSearchText = this.searchText.toLowerCase(); // 将搜索文本转为小写，避免大小写问题
        const accountDate = new Date(account.date);

        // 调整为上海时间（UTC+8），即加上8小时
        accountDate.setHours(accountDate.getHours() + 8);

        // 获取格式化后的日期字符串（YYYY-MM-DD）
        const accountDateStr = accountDate.toISOString().split('T')[0];

        return (
          account.category.toLowerCase().includes(lowerSearchText) || // 按类别匹配
            (account.description && account.description.toLowerCase().includes(lowerSearchText)) || // 按描述匹配
          account.amount.toString().includes(this.searchText) || // 按金额匹配
          accountDateStr.includes(this.searchText)                         // 按日期匹配（YYYY-MM-DD）
        );
      });

      this.accounts = filteredAccounts;

      for (let i = 0; i < this.accounts.length; i++) {
        if (this.accounts[i].type === 0) {
          this.total_out = this.total_out + this.accounts[i].amount;
        } else {
          this.total_in = this.total_in + this.accounts[i].amount;
        }

        // 提取日期部分并加入 uniqueDates 中去重
        const dateStr = new Date(this.accounts[i].date).toISOString().split('T')[0]; // 获取年月日部分
        uniqueDates.add(dateStr);
      }
      // 对账单进行排序
      this.accounts.sort((a, b) => {
        return new Date(b.date).getTime() - new Date(a.date).getTime();
      });

      // 记账总笔数
      this.totalCount = this.accounts.length;

      // 记账总天数
      this.totalDays = uniqueDates.size;
      console.log('记账总天数:', this.totalDays);

      AppStorage.setOrCreate('totalCount', this.totalCount);
      AppStorage.setOrCreate('totalDays', this.totalDays);
      AppStorage.setOrCreate('accountList', this.accounts);
    } catch (error) {
      console.log(error);
    }
  }

  aboutToAppear() {
    this.recordList();
  }

  @Builder
  itemEnd(index: number, item: AccountData) {
    // 侧滑后尾端出现的组件
    Button({ type: ButtonType.Circle }) {
      Image($rawfile('delete.png'))
    }
    .width($r('app.float.component_size_MP'))
    .height($r('app.float.component_size_MP'))
    .backgroundColor($r('app.color.background_color'))
    .onClick(() => {
      this.recordDelete(item.id);
      this.recordList();
    })
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Text(`Money Up`)
            .height(`30vp`)
            .fontSize(25)
            .fontColor('#9B0000')
            .margin({ top: '10vp', left: 140 })
        }.width('100%')

        Row() {
          Search({
            value: this.searchText,
            placeholder: CommonConstants.SEARCH_TEXT,
            controller: this.searchController
          })
            .width(CommonConstants.FULL_WIDTH)
            .borderRadius($r('app.float.radius_size_M'))
            .borderWidth($r('app.float.border_size_S'))
            .borderColor($r('app.color.border_color'))
            .placeholderFont({ size: $r('app.float.font_size_M') })
            .textFont({ size: $r('app.float.font_size_M') })
            .backgroundColor(Color.White)
            .onChange((searchValue: string) => {
              this.searchText = searchValue;
              this.recordList();
            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
        .margin({ top: ('0vp'), bottom: ('2vp') })

        Row() {
          Column() {
            Text(`收入`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
            Text(`${this.total_in}`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor('#9B0000')
          }.margin({ right: ('8vp') })

          Column() {
            Text(`支出`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
            Text(`${this.total_out}`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor('#3E4A7B')
          }.margin({ right: ('12vp') })

          Column() {
            Text(`结余`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
            Text(`${this.total_in - this.total_out}`)
              .height($r('app.float.component_size_SP'))
              .fontSize(20)
              .fontColor('#021E30')
          }
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ top: ('5vp'), bottom: ('0vp') })

        Row() {
          List({ space: CommonConstants.FULL_SIZE, scroller: this.scrollerForList }) {
            ForEach(this.accounts, (item: AccountData) => {
              ListItem() {
                Row() {
                  Image(ImageList[item.category])
                    .width($r('app.float.component_size_M'))
                    .aspectRatio(CommonConstants.FULL_SIZE)
                    .margin({ right: $r('app.float.edge_size_MP') })

                  Column() {
                    Row({ space: 8 }) {
                      Text(item.category)
                        .height($r('app.float.component_size_SM'))
                        .fontSize($r('app.float.font_size_M'))
                      if (item.description === '') {
                        Text(`备注: 无`)
                          .height($r('app.float.component_size_SM'))
                          .fontSize($r('app.float.font_size_M'))
                      } else {
                        Text(`备注: ${item.description}`)
                          .height($r('app.float.component_size_SM'))
                          .fontSize($r('app.float.font_size_M'))
                      }
                    }

                    Text(new Date(item.date).toLocaleDateString())
                      .height($r('app.float.component_size_SM'))
                      .fontSize($r('app.float.font_size_M'))
                  }.alignItems(HorizontalAlign.Start)

                  Blank()
                    .layoutWeight(1)

                  Text(item.type === 0 ? '-' + item.amount.toString() : '+' + item.amount.toString())
                    .fontSize($r('app.float.font_size_M'))
                    .fontColor(item.type === 0 ? '#3E4A7B' : '#9B0000')
                    .align(Alignment.End)
                    .flexGrow(CommonConstants.FULL_SIZE)
                }
                .width(CommonConstants.FULL_WIDTH)
                .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
              }.swipeAction({
                end: () => {
                  this.itemEnd(this.index, item)
                }
              })
              .width(CommonConstants.FULL_WIDTH)
              .height($r('app.float.component_size_LM'))
              .onClick(() => {
              })
            })
          }
          .height("71%")
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius($r('app.float.radius_size_M'))
          .backgroundColor(Color.White)
          .divider({
            strokeWidth: 1,
            startMargin: 60,
            endMargin: 10,
            color: '#ffe9f0f0'
          })
        }
        .width(CommonConstants.FULL_WIDTH)
        .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
        .margin({ top: '2vp' })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.themeColor'))
  }
}