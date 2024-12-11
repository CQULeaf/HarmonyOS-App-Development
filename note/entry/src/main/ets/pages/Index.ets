import NoteModel from '../bean/NoteModel'
import { noteList, noteAdd, noteDelete, noteEdit } from '../api/notes'
import NoteItem from '../component/NoteItem'
import { router } from '@kit.ArkUI'

interface ResponseNoteList extends Array<NoteModel> {}

@Entry
@Component
struct Index {
  @StorageProp('CurrentUsername') username: string = '';
  @State title: string | null = ''
  @State content: string = ''
  @State category: string | null = ''
  @State noteList: NoteModel[] = []

  @State searchText: string = ''

  @State editingMemoIndex: number = -1
  @State editContent: string = ''

  async getNoteList() {
    try {
      const response = await noteList<ResponseNoteList>(this.username);
      this.noteList = response;
      console.log('查询成功:', response);

      // 获取用户所有的分类
      const categorySet = new Set<string>();
      this.noteList.forEach((note) => {
        categorySet.add(note.category);
      });
      AppStorage.setOrCreate('categoryList', Array.from(categorySet));
    } catch (error) {
      console.log(error);
    }
  }

  // 点击笔记时的方法
  clickNote = (note: NoteModel) => {
    this.editingMemoIndex = this.noteList.indexOf(note)
    this.editContent = note.content
  }

  // 页面初始化前向页面加载数据
  aboutToAppear() {
    this.getNoteList()
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
              router.pushUrl({ url: 'pages/NotePage' })
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

        // 笔记列表
        Scroll() {
          Column() {
            ForEach(
              this.noteList,
              (note: NoteModel, index: number) => {
                // 笔记点击方法
                NoteItem({ note: this.noteList[index], onNoteClick: this.clickNote })
              },
              (note: NoteModel) => {
                return note.content
              }
            )
          }
        }
      }
      .width('100%')
      .height('100%')
    }
  }
}