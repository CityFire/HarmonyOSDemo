@Entry
@Component
struct GridExample {
  // @State services: Array<string> = ['会议', '投票', '签到', '打印']
  @State services: Array<string> = ['直播', '进口', '分类', '充值', '领券', '抽奖', '会员', '收藏', '积分', '更多']
  private scroller: Scroller = new Scroller()

  @Builder
  GridView() {
    Grid() {
      // LazyForEach(this.services, service => {
      //
      // })
      ForEach(this.services, service => {
        GridItem() {
          Text(service)
        }
      }, service => service)
    }
    .columnsGap(10)
    .rowsGap(15)
    .rowsTemplate('1fr 1fr')
    .columnsTemplate('1fr 1fr')
  }

  build() {

    Column({ space: 5 }) {
      Grid(this.scroller) {
        ForEach(this.services, (service: string, index) => {
          GridItem() {
            Text(service)
          }
          .width('25%')
        }, service => service)
      }
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr') // 只设置rowsTemplate属性，当内容超出Grid区域时，可水平滚动。
      // .rowsGap(15)

      Row({space: 20}) {
        Button('上一页')
          .onClick(() => {
            this.scroller.scrollPage({
              next: false
            })
          })

        Button('下一页')
          .onClick(() => {
            this.scroller.scrollPage({
              next: true
            })
          })
      }
    }

    // Grid() {
      // GridItem() {
      //   Text('0')
      // }
      // .columnStart(1)
      // .columnEnd(2)
      //
      // GridItem() {
      //   Text('=')
      // }
      // .rowStart(5)
      // .rowEnd(6)
    // }
    // .rowsTemplate('1fr 1fr')
    // .columnsTemplate('1fr 1fr')
    // .maxCount(5)
    // .layoutDirection(GridDirection.Row)
    // .rowsTemplate('2fr 1fr 1fr 1fr 1fr 1fr')
    // .columnsTemplate('1fr 1fr 1fr 1fr')
    // .rowsTemplate('1fr 1fr 1fr')
    // .columnsTemplate('1fr 2fr 1fr')
  }
}

@Component
struct OfficeService {
  @State services: Array<string> = ['会议', '投票', '签到', '打印']

  build() {
    Column() {
      Grid() {
        ForEach(this.services, service => {
          GridItem() {
            Text(service)
          }
          .backgroundColor(Color.Red)
        }, service => service)
      }
      .rowsTemplate('1fr 1fr')
      .columnsTemplate('1fr 1fr')
    }
  }
}