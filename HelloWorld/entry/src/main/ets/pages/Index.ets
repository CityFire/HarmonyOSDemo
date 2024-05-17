import common from '@ohos.app.ability.common';
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Red)
          .margin(10)

        Button() {
          Text('stop')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        // 跳转按钮绑定onClick事件，点击时跳转到第二页
        .onClick(() => {
          console.info(`Succeeded in clicking the 'stop' button.`)
          // context为需要停止的UIAbility实例的AbilityContext
          this.context.terminateSelf((err) => {
            console.error(`Failed to jump to the prefix page.Code is ${err.code}, message is ${err.message}`)
          });
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}