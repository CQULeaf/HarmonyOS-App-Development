export class CasualModeController {
  // 将父组件的 aboutToAppear 方法声明在控制器类中
  aboutToAppear: () => void = () => {
    console.log('默认的 aboutToAppear 方法')
  }
}
export default new CasualModeController()