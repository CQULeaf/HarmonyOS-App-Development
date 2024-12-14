import NoteModel from '../bean/NoteModel'
import { noteAdd } from '../api/notes'
import { router } from '@kit.ArkUI'

interface SelectOption {
  value: string
  icon: Resource
}

@Entry
@Component
struct AddNotePage {
  @StorageProp('CurrentUsername') username: string = '';
  @StorageProp('CategoryArray') categoryArray: string[] = []
  @State addTitle: string = ''
  @State addContent: string = ''
  @State selectedCategory: string = ''
  // 操作历史
  @State undoStack: string[] = []
  @State redoStack: string[] = []

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

  // 保存当前状态到撤销栈
  saveStateBeforeChange(newContent: string) {
    if (newContent !== this.addContent) {
      this.undoStack.push(this.addContent)
      this.addContent = newContent
      this.redoStack = []
    }
  }

  // 后撤操作
  undo() {
    if (this.undoStack.length > 0) {
      // 从操作栈中取出最后一个操作，恢复内容
      const lastState = this.undoStack.pop()
      if (lastState !== undefined) {
        this.redoStack.push(this.addContent)
        this.addContent = lastState
      }
    } else {
      console.log('没有更多操作可以后撤')
    }
  }

  // 前撤操作
  redo() {
    if (this.redoStack.length > 0) {
      // 从撤销栈中取出最后一个撤销的操作，恢复内容
      const redoState = this.redoStack.pop()
      if (redoState !== undefined) {
        this.undoStack.push(this.addContent)
        this.addContent = redoState
      }
    } else {
      console.log('没有更多操作可以前撤')
    }
  }

  // 添加笔记
  async noteAdd() {
    try {
      if (this.addContent.trim() === '' || this.addTitle.trim() === '') {
        AlertDialog.show({
          message: '标题或笔记都不能为空哦~'
        })
      } else {
        const res = await noteAdd<NoteModel>(this.username, this.addTitle, this.addContent, this.selectedCategory)
        AlertDialog.show({
          message: '笔记添加成功！'
        })
        router.pushUrl({ url: 'pages/Index' })
      }
    } catch (error) {
      AlertDialog.show({
        message: '添加失败，请检查网络连接或稍后重试'
      })
    }
  }

  selectOptions: SelectOption[] = this.categoryArray.map((category) => {
    return { value: category, icon: $r('app.media.file') } as SelectOption
  })

  build() {
    // 编辑卡片
    Column() {
      // 四个按钮
      Row() {
        // 返回按钮
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .margin({ left: 26 })
          .onClick(() => {
            router.back()
          })

        // 后撤按钮
        Image(this.undoStack.length > 0 ? $r('app.media.undo') : $r('app.media.undo_disabled'))
          .width(24)
          .height(24)
          .margin({ left: 100 })
          .onClick(() => {
            if (this.undoStack.length > 0) {
              this.undo();
            }
          })
          .opacity(this.undoStack.length > 0 ? 1 : 0.5)

        // 前撤按钮
        Image(this.redoStack.length > 0 ? $r('app.media.redo') : $r('app.media.redo_disabled'))
          .width(24)
          .height(24)
          .margin({ right: 100 })
          .onClick(() => {
            if (this.redoStack.length > 0) {
              this.redo();
            }
          })
          .opacity(this.redoStack.length > 0 ? 1 : 0.5)

        // 保存按钮
        Image($r('app.media.save'))
          .width(24)
          .height(24)
          .margin({ right: 26 })
          .onClick(() => {
            this.noteAdd()
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .width('100%')

      // 标题输入部分：可供输入的空行
      TextInput({
        placeholder: '请输入标题',
        text: this.addTitle
      })
        .onChange((value: string) => {
          this.addTitle = value
        })
        .height(40)
        .margin({ left: 20, right: 20, top: 10 })
        .backgroundColor('#fff')
        .padding(10)

      // 显示记录时间部分
      Row() {
        // 时间显示
        Text(this.formatTimestamp(Date.now()))
          .fontSize(16)
          .fontColor('#397D54')
          .margin({ left: 20 })

        // 分类选择
        Select(
          this.selectOptions
        )
          .margin({ right: 30 })
          .value(this.selectedCategory)
          .font({ size: 16})
          .fontColor('#397D54')
          .selectedOptionFont({ size: 16, weight: 400 })
          .selectedOptionBgColor('#44bcf9')
          .selectedOptionFontColor('#397D54')
          .optionFont({ size: 16, weight: 400 })
          .onSelect((index: number) => {
            this.selectedCategory = this.categoryArray[index]
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .width('100%')

      // 文本输入部分
      TextArea({
        placeholder: '请输入笔记',
        text: this.addContent
      })
        .onChange((value: string) => {
          this.saveStateBeforeChange(value)
        })
        .height('70%')
        .margin(20)
        .backgroundColor('#fff')
        .padding(10)

      // 展示正文字数
      Text(`字数：${this.addContent.length}`)
        .fontSize(20)
        .fontColor('#397D54')
        .margin({ bottom: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#73C088')
  }
}