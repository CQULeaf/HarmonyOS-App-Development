import NoteModel from '../bean/NoteModel'
import { noteList, noteDelete, noteTop, noteFavorite, noteCategory } from '../api/notes'
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

  async getNoteList() {
    try {
      const response = await noteList<ResponseNoteList>(this.username);
      this.noteList = response;

      this.noteList.sort((a, b) => {
        const timeA = new Date(a.updatedAt).getTime();
        const timeB = new Date(b.updatedAt).getTime();

        if (b.isTop !== a.isTop) {
          return b.isTop ? 1 : -1;
        }
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

      // 获取用户所有的分类
      const categorySet = new Set<string>();
      this.noteList.forEach((note) => {
        categorySet.add(note.category);
      });
      this.categoryArray = Array.from(categorySet).sort((a, b) => a.length - b.length);
      AppStorage.setOrCreate('CategoryArray', this.categoryArray);

      this.selectOptions = [
        { value: '全部笔记', icon: $r('app.media.all_note') },
        ...this.categoryArray.map((category) => {
          return { value: category, icon: $r('app.media.file') } as SelectOption;
        }),
        { value: '我的收藏', icon: $r('app.media.my_favorite') },
        { value: '回收站', icon: $r('app.media.my_delete') }
      ];
    } catch (error) {
      console.log(error);
    }
  }

  async noteDelete(id: number) {
    try {
      const response = await noteDelete<number>(id);
      console.log('删除成功:', response);
    } catch (error) {
      console.log(error);
    }
  }

  async NoteTop(id: number, isTop: boolean) {
    try {
      const response = await noteTop<NoteModel>(id, isTop);
      console.log('置顶成功:', response);
    } catch (error) {
      console.log(error);
    }
  }

  async NoteFavorite(id: number, isFavorite: boolean) {
    try {
      const response = await noteFavorite<NoteModel>(id, isFavorite);
      console.log('收藏成功:', response);
    } catch (error) {
      console.log(error);
    }
  }

  async NoteCategory(id: number, category: string) {
    try {
      const response = await noteCategory<NoteModel>(id, category);
      console.log('分类成功:', response);
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
      .onClick(async () => {
        try {
          await this.NoteTop(item.noteId, !item.isTop);
          this.aboutToAppear();
        } catch (error) {
          console.log(error);
        }
      });

      // 分类按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.category'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(() => {
        TextPickerDialog.show({
          range: this.categoryArray,
          selected: this.categoryArray.indexOf(item.category),
          onAccept: async (selectedCategory: TextPickerResult) => {
            const selectedCategoryValue = Array.isArray(selectedCategory.value) ? selectedCategory.value[0] : selectedCategory.value;
            await this.NoteCategory(item.noteId, selectedCategoryValue);
            this.aboutToAppear();
          },
          onCancel: () => {
            console.log('没有更多操作可以前撤')
          }
        })
      });

      // 收藏按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.favorite'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(async () => {
        try {
          await this.NoteFavorite(item.noteId, !item.isFavorite);
          this.aboutToAppear();
        } catch (error) {
          console.log(error);
        }
      });

      // 删除按钮
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.delete'))
      }
      .width('48vp')
      .height('48vp')
      .backgroundColor('#73C088')
      .margin({ left: 5, right: 5 })
      .onClick(async () => {
        try {
          await this.noteDelete(item.noteId);
          this.aboutToAppear();
        } catch (error) {
          console.log(error);
        }
      });
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

          Select(
            this.selectOptions
          )
            .selected(0)
            .value('全部笔记')
            .font({ size: 16 })
            .fontColor('#397D54')
            .selectedOptionFont({ size: 16, weight: 400 })
            .selectedOptionBgColor('#44bcf9')
            .selectedOptionFontColor('#397D54')
            .optionFont({ size: 16, weight: 400 })
            .onSelect(async (index: number) => {  // 改为异步函数
              const selectedValue = this.selectOptions[index].value;

              try {
                if (selectedValue === '全部笔记') {
                  await this.getNoteList();
                } else if (selectedValue === '我的收藏') {
                  this.noteList = this.noteList.filter((note) => note.isFavorite);
                } else if (selectedValue === '回收站') {
                  router.pushUrl({ url: 'pages/RecycleBinPage' });
                } else {
                  this.noteList = this.noteList.filter((note) => note.category === selectedValue);
                }
              } catch (error) {
                console.log('Error selecting note category:', error);
              }
            });

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
                    if (note.isTop) {
                      Column() {
                        Image($r('app.media.top'))
                          .width(20)
                          .height(20)
                      }
                      .margin({ left: 10 })
                    }

                    if (note.isFavorite) {
                      Column() {
                        Image($r('app.media.favorite'))
                          .width(20)
                          .height(20)
                      }
                      .margin({ left: 5 })
                    }

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
