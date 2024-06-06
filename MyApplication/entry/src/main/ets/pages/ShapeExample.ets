@Entry
@Component
struct ShapeExample {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Shape() {
          Rect().width(300).height(50)
        }

        Circle({ width: 150, height: 150 }).fill('#E87361')

        // 画一个宽高都为75的圆
        Text('原始尺寸Circle组件')
        Circle({width: 75, height: 75}).fill('#E87361')

        Row({space:10}) {
          Column() {
            // 创建一个宽高都为150的shape组件，背景色为黄色，一个宽高都为75的viewport。用一个蓝色的矩形来填充viewport，在viewport中绘制一个直径为75的圆。
            // 绘制结束，viewport会根据组件宽高放大两倍
            Text('shape内放大的Circle组件')
            Shape() {
              Rect().width('100%').height('100%').fill('#0097D4')
              Circle({width: 75, height: 75}).fill('#E87361')
            }
            .viewPort({x: 0, y: 0, width: 75, height: 75})
            .width(150)
            .height(150)
            .backgroundColor('#F5DC62')
          }
          Column() {
            // 创建一个宽高都为150的shape组件，背景色为黄色，一个宽高都为300的viewport。用一个绿色的矩形来填充viewport，在viewport中绘制一个直径为75的圆。
            // 绘制结束，viewport会根据组件宽高缩小两倍。
            Text('Shape内缩小的Circle组件')
            Shape() {
              Rect().width('100%').height('100%').fill('#BDDB69')
              Circle({width: 75, height: 75}).fill('#E87361')
            }
            .viewPort({x: 0, y: 0, width: 300, height: 300})
            .width(150)
            .height(150)
            .backgroundColor('#F5DC62')
          }
        }

      }
      .width('100%')
    }
    .height('100%')
  }
}