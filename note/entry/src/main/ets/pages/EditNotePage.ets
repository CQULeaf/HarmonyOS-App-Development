import NoteModel from '../bean/NoteModel'
import { noteEdit, getNoteById } from '../api/notes'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct EditNotePage {
  @State noteId: number = 0;
  @State editTitle: string = '';
  @State editContent: string = '';
  @State selectedCategory: string = ''
  @State note: NoteModel = {
    noteId: 0,
    username: '',
    title: '',
    content: '',
    category: '',
    createdAt: 0,
    updatedAt: 0,
    is_deleted: false,
  }

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

  // 操作历史
  @State undoStack: string[] = []
  @State redoStack: string[] = []

  async getNoteById() {
    try {
      const response = await getNoteById<NoteModel>(this.noteId);
      this.note = response;

      this.undoStack = [this.note.content];
      this.editContent = this.note.content;
      this.editTitle = this.note.title;
    } catch (error) {
      console.error('获取笔记详情请求错误', error)
    }
  }

  async updateNote() {
    try {
      const response = await noteEdit<NoteModel>(this.noteId, this.editTitle, this.editContent, this.selectedCategory);
      console.log('更新笔记成功:', response);
      router.pushUrl({ url: 'pages/Index' });
    } catch (error) {
      console.error('更新笔记请求错误', error)
    }
  }

  aboutToAppear(): void {
    if (router.getParams() !== undefined && router.getParams() !== null) {
      let params = router.getParams() as Record<string, number>;
      if (params.noteId !== undefined && params.noteId !== null) {
        this.noteId = params.noteId;
        this.getNoteById();
      }
    }
  }

  // 保存当前状态到撤销栈
  saveStateBeforeChange(newContent: string) {
    if (newContent !== this.editContent) {
      this.undoStack.push(this.editContent)
      this.editContent = newContent
      this.redoStack = []
    }
  }

  // 后撤操作
  undo() {
    if (this.undoStack.length > 1) {
      // 从操作栈中取出最后一个操作，恢复内容
      const lastState = this.undoStack.pop()
      console.log('lastState:', lastState)
      if (lastState !== undefined) {
        this.redoStack.push(this.editContent)
        this.editContent = lastState
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
        this.undoStack.push(this.editContent)
        this.editContent = redoState
      }
    } else {
      console.log('没有更多操作可以前撤')
    }
  }

  build() {
    Column() {
      Row() {
        // 返回按钮
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .margin({ left: 26 })
          .onClick(() => {
            router.back();
          })

        // 后撤按钮
        Image(this.undoStack.length > 1 ? $r('app.media.undo') : $r('app.media.undo_disabled'))
          .width(24)
          .height(24)
          .margin({ left: 100 })
          .onClick(() => {
            if (this.undoStack.length > 1) {
              this.undo();
            }
          })
          .opacity(this.undoStack.length > 1 ? 1 : 0.5)

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
            this.updateNote();
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .width('100%')

      // 标题输入部分：可供输入的空行
      TextInput({
        placeholder: '请输入标题',
        text: this.editTitle,
      })
        .onChange((value: string) => {
          this.editTitle = value;
        })
        .height(40)
        .margin({ left: 20, right: 20, top: 10 })
        .backgroundColor('#fff')
        .padding(10)

      // 显示记录时间部分
      Row() {
        Text(this.formatTimestamp(this.note.updatedAt || Date.now()))
          .fontSize(16)
          .fontColor('#397D54')
          .margin({ left: 20 })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .width('100%')

      // 笔记内容输入部分
      TextArea({
        placeholder: '请输入笔记内容',
        text: this.editContent,
      })
        .onChange((value: string) => {
          this.saveStateBeforeChange(value)
        })
        .height('70%')
        .margin(20)
        .backgroundColor('#fff')
        .padding(10)

      // 展示正文字数
      Text(`字数：${this.editContent.length}`)
        .fontSize(20)
        .fontColor('#397D54')
        .margin({ bottom: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#73C088')
  }
}
