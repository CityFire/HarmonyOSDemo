// Second.ets
// 导入页面路由模块
import router from '@ohos.router';

@Entry
@Component
struct Second {
  @State message: string = 'Hi there'
  scroller: Scroller = new Scroller();
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  build() {
    Scroll(this.scroller) {
      Column() {
        ForEach(this.arr, (item) => {
          Row() {
            Column() {
              // Stack({ }) {
              //   Column(){}.width('100%').height('100%').backgroundColor('#ff58b87c')
                Text(this.message)
                  .fontSize(50)
                  .fontWeight(FontWeight.Bold)
                  .width('60%')
                  .height('60%')
                  .backgroundColor('#ffc3f6aa')
                Button() {
                  Text('Back')
                    .fontSize(25)
                    .fontWeight(FontWeight.Bold)
                }
                .type(ButtonType.Capsule)
                .margin({
                  top: 20
                })
                .backgroundColor('#0D9FFB')
                .width('25%')
                .height('20%')
                // 返回按钮绑定onClick事件，点击按钮时返回到第一页
                .onClick(() => {
                  console.info(`Succeeded in clicking the 'Back' button.`)
                  try {
                    // 返回第一页
                    router.back()
                    console.info('Succeeded in returning to the first page.')
                  } catch (err) {
                    console.error(`Failed to return to the first page.Code is ${err.code}, message is ${err.message}`)
                  }
                })
              // }.width('100%').height(250).margin({ top: 0 })
            }.justifyContent(FlexAlign.Start)
            .backgroundColor(0xF5DEB3)
            .width('100%')
            .height('100%')
          }
          .backgroundColor(0xD2B48C)
          .height('30%')
        }, item => item)
      }.width('100%')
      .backgroundColor(0x222222)
    }
    .backgroundColor(0xDCDCDC)
    .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
    .scrollBar(BarState.On) // 滚动条常驻显示
    .scrollBarColor(Color.Gray) // 滚动条颜色
    .scrollBarWidth(10) // 滚动条宽度
    .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
  }
}
