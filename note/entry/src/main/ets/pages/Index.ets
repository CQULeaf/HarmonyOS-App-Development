import NoteModel from '../bean/NoteModel'
import { noteList, noteDelete } from '../api/notes'
import { router } from '@kit.ArkUI'
import CommonConstants from '../common/CommonConstants'

interface ResponseNoteList extends Array<NoteModel> {}

@Entry
@Component
struct Index {
  @StorageProp('CurrentUsername') username: string = '';
  @State title: string = ''
  @State content: string = ''
  @State category: string = ''
  @State noteList: NoteModel[] = []
  @State searchText: string = ''

  private scrollerForList: Scroller = new Scroller()

  @State index: number = -1;

  formatTimestamp(timestamp: number): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');
    return `${year}年${month}月${day}日 ${hours}:${minutes}:${seconds}`;
  }

  async getNoteList() {
    try {
      const response = await noteList<ResponseNoteList>(this.username);
      this.noteList = response;

      const filteredNotes = this.noteList.filter((note) => {
        const lowerSearchText = this.searchText.toLowerCase();

        return (
          note.category.toLowerCase().includes(lowerSearchText) ||
          note.title.toLowerCase().includes(lowerSearchText) ||
          note.content.toLowerCase().includes(lowerSearchText) ||
          this.formatTimestamp(note.updatedAt).includes(lowerSearchText)
        )
      });

      this.noteList = filteredNotes;

      // // 获取用户所有的分类
      // const categorySet = new Set<string>();
      // this.noteList.forEach((note) => {
      //   categorySet.add(note.category);
      // });
      // AppStorage.setOrCreate('categoryList', Array.from(categorySet));
    } catch (error) {
      console.log(error);
    }
  }

  async noteDelete(id: number) {
    try {
      const response = await noteDelete<ResponseNoteList>(id);
      console.log('删除成功:', response);
    } catch (error) {
      console.log(error);
    }
  }

  // 页面初始化前向页面加载数据
  aboutToAppear() {
    this.getNoteList()
  }

  @Builder itemEnd(index: number, item: NoteModel) {
    // 侧滑后尾端出现的四个组件：置顶、分类、收藏、删除

    Row() {
      // 置顶按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.top'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(() => {
        // this.setTop(item.id);
        // this.recordList(); // 刷新列表
      })

      // 分类按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.category'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(() => {
        // this.showCategorySelection(item.id); // 显示分类选择
      })

      // 收藏按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.favorite'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(() => {
        // this.toggleFavorite(item.id); // 切换收藏状态
        // this.recordList(); // 刷新列表
      })

      // 删除按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.delete'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(() => {
        this.noteDelete(item.noteId);
        this.getNoteList();
      })
    }
    .width('63%')
    .height('50%')
  }


  build() {
    Stack() {
      // 背景图片
      Image($r('app.media.bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      // 主体页面
      Column() {
        Row() {
          Image($r('app.media.setting'))
            .width(30)
            .height(30)
            .margin({ left: 15, right: 15 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/SettingPage' })
            })

          Text('便捷记')
            .fontSize(24)
            .fontColor('#147D42')
            .margin({ top: 10, bottom: 10 })

          Image($r('app.media.add'))
            .width(30)
            .height(30)
            .margin({ left: 15, right: 15 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/AddNotePage' })
            })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 10 })
        .width('100%')

        Row() {
          Search({
            placeholder: '搜索笔记',
            value: this.searchText
          })
            .width('100%')
            .borderRadius('20vp')
            .borderWidth('1.5vp')
            .placeholderFont({ size: '16vp' })
            .textFont({ size: '16vp' })
            .backgroundColor(Color.White)
            .onChange((searchValue: string) => {
              this.searchText = searchValue;
              this.getNoteList();
            })
        }
        .width('100%')
        .padding({ left: '12vp', right: '12vp' })
        .margin({ top: ('0vp'), bottom: ('2vp') })

        Row() {
          List({ space: CommonConstants.FULL_SIZE, scroller: this.scrollerForList }) {
            ForEach(this.noteList, (note: NoteModel) => {
              ListItem() {
                Column() {
                  Row() {
                    Column() {
                      Text(this.formatTimestamp(note.updatedAt))
                        .fontSize(15)
                        .fontColor('#397D54')
                    }
                    .margin({ left: 5 })

                    Column() {
                      Text(note.category || '未分类')
                        .fontSize(15)
                        .fontColor('#397D54')
                    }
                    .margin({ right: 5 })
                  }
                  .margin({ top: 5, bottom: 5 })
                  .justifyContent(FlexAlign.SpaceBetween)
                  .width('100%')

                  // 笔记标题与内容展示
                  Row() {
                    Column() {
                      // 笔记标题
                      Text(note.title)
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#000000')
                        .margin({ top: 5, bottom: 5, left: 5 })

                      // 笔记内容（最多显示2行）
                      Text(note.content)
                        .fontSize(15)
                        .fontColor('#000000')
                        .margin({ top: 5, bottom: 5, left: 5 })
                        .maxLines(2)
                    }
                    .alignItems(HorizontalAlign.Start)
                    .width('100%')
                  }
                  .height('50%')
                }
                // 设置外层样式：背景色、圆角、内边距等
                .width(CommonConstants.FULL_WIDTH)
                .height('110vp')
                .padding({ left: '12vp', right: '12vp' })
                .borderRadius('20vp')
                .backgroundColor('#73C088')
                .margin({ bottom: 10 })
              }
              .margin({ top: 5, bottom: 5 })
              .onClick(() => {
                console.log(note.noteId.toString())
                router.pushUrl({
                  url: 'pages/EditNotePage', params: { noteId: note.noteId }
                })
              })
              .swipeAction({ end: () => {
                  this.itemEnd(this.index, note)
              }  })
              .width(CommonConstants.FULL_WIDTH)
              .height('110vp')
            })
          }
          .height("85%")
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius('20vp')
          .divider({
            strokeWidth: 1,
            startMargin: 60,
            endMargin: 10,
            color: '#ffe9f0f0'
          })
        }
        .width(CommonConstants.FULL_WIDTH)
        .padding({ left: '12vp', right: '12vp' })
        .margin({ top: '2vp' })

      }
      .width('100%')
      .height('100%')
    }
  }
}
