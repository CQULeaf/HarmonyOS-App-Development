import webview from '@ohos.web.webview'

@Component
export default struct Echarts {
  //控制器
  controller: webview.WebviewController = new webview.WebviewController();
  //组件宽
  @Prop eWidth: string | number = '100%'
  //组件高，单位vp
  @Prop eHeight: string | number = 300
  //渲染完成回调
  renderCallBack: (e: Echarts) => void = () => {
  }

  //更新或渲染组件
  render(option: Record<string, ESObject> | string) {
    this.controller.runJavaScript(`setOption(${typeof option === 'string' ? option : JSON.stringify(option)})`)
  }

  build() {
    Column() {
      Web({ src: $rawfile('echarts.html'), controller: this.controller })
        .width('100%')
        .height('100%')
        .onPageEnd(e => {
          this.renderCallBack && this.renderCallBack(this)
        })

    }
    .width(this.eWidth)
    .height(this.eHeight)
  }
}
