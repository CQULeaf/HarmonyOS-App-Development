import { getRankList } from '../api/Rank'
import { router } from '@kit.ArkUI'
import { AxiosError } from '@ohos/axios';

interface User {
  username: string;
  score: number;
  title: string;
}

interface RankData {
  globalRanking: Array<User>;
  rank: number;
  user: User;
}

@Entry
@Component
struct Rank {
  @StorageProp('CurrentUsername') currentUsername: string = ''
  @State rankingData: Array<User> = []
  @State currentUser: User = { username: '', score: 0, title: '' }
  @State currentRank: number = 0
  @State isLoading: boolean = false;

  aboutToAppear() {
    this.initData()
    console.log('数据已加载完毕')
  }

  async initData() {
    if (!this.currentUsername) {
      console.warn('当前用户名为空，无法加载数据');
      return;
    }

    if (this.isLoading) {
      console.log('数据加载中，跳过重复请求');
      return;
    }

    this.isLoading = true;

    try {
      const res = await getRankList<RankData>(this.currentUsername);
      if (res && res.data) {
        // 更新当前用户数据
        this.currentRank = res.data.rank;
        this.currentUser = res.data.user;

        // 更新排行榜数据
        this.rankingData = res.data.globalRanking;

        console.log('当前用户信息:', this.currentUser);
        console.log('全国排名信息:', this.rankingData);
      } else {
        console.error('未获取到排名数据');
      }
    } catch (error) {
      console.error('加载排名数据失败:', error);
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Column() {
      //导航栏
      Row() {
        Image($r('app.media.ic_arrow_left'))
          .width(30)
          .height(30)
          .onClick(() => {
            router.back()
          })

        Text('拼图华容道全国实时排名')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 40 })
      }
      .width('100%')
      .height(47)
      .justifyContent(FlexAlign.Start)
      .margin({ top: 10 })

      // 排行榜列表头
      Row() {
        Text('排名')
          .fontSize(14)
          .fontColor('#989a9c')
          .width('20%')
        Text('荣誉称号')
          .fontSize(14)
          .fontColor('#989a9c')
          .width('35%')
        Text('用户名')
          .fontSize(14)
          .fontColor('#989a9c')
          .width('35%')
        Text('积分')
          .fontSize(14)
          .fontColor('#989a9c')
          .width('20%')
      }.width('90%')
      .padding(15)

      // 排行榜列表
      Column() {
        List() {
          ForEach(this.rankingData, (item: User, index) => {
            ListItem() {
              Row() {
                Text((index + 1).toString())
                  .fontSize(20)
                  .width('20%')
                Image($r(`app.media.${item.title}`))
                  .width(30)
                  .height(30)
                  .margin({ right: 60 })
                // Text(item.title)
                //   .fontSize(20)
                //   .width('30%')
                Text(item.username)
                  .fontSize(20)
                  .width('40%')
                Text(item.score.toString())
                  .fontSize(20)
                  .width('20%')
              }
              .padding(10)
              .backgroundColor(item.username === this.currentUser.username ? '#c8c6b6' : '#f1f3f5')
            }
          })
        }
        .width('90%')
        .padding(15)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f1f3f5')
    }
  }
}