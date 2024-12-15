import NoteModel from '../bean/NoteModel'
import { noteDeletedList, noteDeletePermanently, noteRecover } from '../api/notes'
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
  @State categoryArray: string[] = []

  @State selectOptions: SelectOption[] = []

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

  async getNoteDeletedList() {
    try {
      const response = await noteDeletedList<ResponseNoteList>(this.username);
      this.noteList = response;

      this.noteList.sort((a, b) => {
        const timeA = new Date(a.updatedAt).getTime();
        const timeB = new Date(b.updatedAt).getTime();

        return timeB - timeA;
      });

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
    } catch (error) {
      console.log(error);
    }
  }

  async recoverNote (noteId: number) {
    try {
      await noteRecover<NoteModel>(noteId);
    } catch (error) {
      console.log(error);
    }
  }

  async deleteNotePermanently (noteId: number) {
    try {
      await noteDeletePermanently<NoteModel>(noteId);
    } catch (error) {
      console.log(error);
    }
  }

  // 页面初始化前向页面加载数据
  aboutToAppear() {
    this.getNoteDeletedList()
  }

  @Builder itemEnd(index: number, item: NoteModel) {
    Row() {
      // 恢复按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.recovery'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(async () => {
        try {
          await this.recoverNote(item.noteId);
          this.aboutToAppear();
          router.pushUrl({
            url: 'pages/Index'
          });
        } catch (error) {
          console.log(error);
        }
      });

      // 删除按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.delete_forever'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(async () => {
        try {
          await this.deleteNotePermanently(item.noteId);
          this.aboutToAppear();
        } catch (error) {
          console.log(error);
        }
      });
    }
    .width('35%')
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
          Image($r('app.media.back'))
            .width(24)
            .height(24)
            .margin({ left: 15 })
            .onClick(() => {
              router.back()
            })

          Text('回收站')
            .fontSize(25)
            .fontColor('#9B0000')
            .margin({ left: 120 })

          Blank()
            .layoutWeight(1)
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
              this.getNoteDeletedList();
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
                      Text(note.category)
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
                        .maxLines(1)

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
