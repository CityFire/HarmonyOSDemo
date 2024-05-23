@Entry
@Component
struct ScrollExample {
  scroller: Scroller = new Scroller();
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  build() {
    Scroll(this.scroller) {
      Row() {
        ForEach(this.arr, (item) => {
          Text(item.toString())
            .height('90%')
            .width(150)
            .backgroundColor(0xFFFFFF)
            .borderRadius(15)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .margin({ left: 10 })
        })
      }.height('100%')
    }
    .backgroundColor(0xDCDCDC)
    .scrollable(ScrollDirection.Horizontal) // 滚动方向为水平方向
    .scrollBar(BarState.On) // 滚动条常驻显示
    .scrollBarColor(Color.Gray) // 滚动条颜色
    .scrollBarWidth(10) // 滚动条宽度
    .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
  }
}