// @Entry
@Component
struct TabContentExample {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()

  @Builder TabBuilder(index: number) {
    Column() {
      Image(this.currentIndex === index ? '/common/public_icon_on.svg' : '/common/public_icon_off.svg')
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
        .objectFit(ImageFit.Contain)
      Text(`Tab${index + 1}`)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%')//.height('100%').justifyContent(FlexAlign.Center)
  }

  @Builder tabContentView() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      TabContent() {
        Column() {
          Text('Tab1')
            .fontSize(36)
            .fontColor('#182431')
            .fontWeight(500)
            .opacity(0.4)
            .margin({ top: 30, bottom: 56.5 })
          Divider()
            .strokeWidth(0.5)
            .color('#182431')
            .opacity(0.05)
        }.width('100%')
      }.tabBar(this.TabBuilder(0))

      TabContent() {
        Column() {
          Text('Tab2')
            .fontSize(36)
            .fontColor('#182431')
            .fontWeight(500)
            .opacity(0.4)
            .margin({ top: 30, bottom: 56.5 })
          Divider()
            .strokeWidth(0.5)
            .color('#182431')
            .opacity(0.05)
        }.width('100%')
      }.tabBar(this.TabBuilder(1))

      TabContent() {
        Column() {
          Text('Tab3')
            .fontSize(36)
            .fontColor('#182431')
            .fontWeight(500)
            .opacity(0.4)
            .margin({ top: 30, bottom: 56.5 })
          Divider()
            .strokeWidth(0.5)
            .color('#182431')
            .opacity(0.05)
        }.width('100%')
      }.tabBar(this.TabBuilder(2))

      TabContent() {
        Column() {
          Text('Tab4')
            .fontSize(36)
            .fontColor('#182431')
            .fontWeight(500)
            .opacity(0.4)
            .margin({ top: 30, bottom: 56.5 })
          Divider()
            .strokeWidth(0.5)
            .color('#182431')
            .opacity(0.05)
        }.width('100%')
      }.tabBar(this.TabBuilder(3))
    }
    .vertical(false)
    .barHeight(56)
    .onChange((index: number) => {
      this.currentIndex = index
    })
    .width(360)
    .height(190)
    .backgroundColor('#F1F3F5')
    .margin({ top: 38 })
  }

  @Builder barContentView() {
    Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
      TabContent()
        .tabBar(this.TabBuilder(0))
      TabContent()
        .tabBar(this.TabBuilder(1))
      TabContent()
        .tabBar(this.TabBuilder(2))
      TabContent()
        .tabBar(this.TabBuilder(3))
    }
    .vertical(true)
    .barWidth(96)
    .barHeight(414)
    .onChange((index: number) => {
      this.currentIndex = index
    })
    .width(96)
    .height(414)
    .backgroundColor('#F1F3F5')
    .margin({ top: 52 })

  }

  build() {
    Column() {
      this.barContentView()
    }.width('100%')
  }
}

@Entry
@Component
struct TabBarStyleExample {
  build() {
    Column({ space: 5 }) {
      Text("子页签样式")
      Column() {
        Tabs({ barPosition: BarPosition.Start }) {
          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Pink)
          }.tabBar(new SubTabBarStyle('Pink'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Yellow)
          }.tabBar(new SubTabBarStyle('Yellow'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Blue)
          }.tabBar(new SubTabBarStyle('Blue'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Green)
          }.tabBar(new SubTabBarStyle('Green'))
        }
        .vertical(false)
        .scrollable(true)
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          console.info(index.toString())
        })
        .width('100%')
        .backgroundColor(0xF1F3F5)
      }.width('100%').height(200)
      Text("底部页签样式")
      Column() {
        Tabs({ barPosition: BarPosition.End }) {
          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Pink)
          }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_app_icon'), 'pink'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Yellow)
          }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_app_icon'), 'Yellow'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Blue)
          }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_app_icon'), 'Blue'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Green)
          }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_app_icon'), 'Green'))
        }
        .vertical(false)
        .scrollable(true)
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          console.info(index.toString())
        })
        .width('100%')
        .backgroundColor(0xF1F3F5)
      }.width('100%').height(200)
      Text("侧边页签样式")
      Column() {
        Tabs({ barPosition: BarPosition.Start }) {
          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Pink)
          }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_app_icon'), 'pink'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Yellow)
          }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_app_icon'), 'Yellow'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Blue)
          }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_app_icon'), 'Blue'))

          TabContent() {
            Column().width('100%').height('100%').backgroundColor(Color.Green)
          }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_app_icon'), 'Green'))
        }
        .vertical(true).scrollable(true).barMode(BarMode.Fixed)
        .onChange((index: number) => {
          console.info(index.toString())
        })
        .width('100%')
        .backgroundColor(0xF1F3F5)
      }.width('100%').height(400)
    }
  }
}
