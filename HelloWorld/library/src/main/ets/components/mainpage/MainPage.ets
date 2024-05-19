@Component
export struct MainPage {
  @State message: string = 'HAR MainPage'

  build() {
    Column() {
      Row() {
        Text(this.message)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
      }
      .margin({ top: '32px' })
      .height(56)
      .width('624px')

      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, alignContent: FlexAlign.Center }) {
        Column() {
          Image($r('app.media.pic_empty')).width('33%')
          Text($r('app.string.empty'))
            .fontSize(14)
            .fontColor($r('app.color.text_color'))
        }
      }.width('100%')
      .height('90%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}
