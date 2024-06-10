import image from '@ohos.multimedia.image'
@Entry
@Component
struct PageTouchEvent {
  // @State visible: Visibility = Visibility.Visible
  private pixelMapReader = undefined

  @State number: string[] = ['drag here']
  @State text: string = ''
  @State bool1: boolean = false
  @State bool2: boolean = false
  @State visible: Visibility = Visibility.Visible
  @State visible2: Visibility = Visibility.None
  scroller: Scroller = new Scroller()

  @State eventType: string = '';

  aboutToAppear() {
    console.info('begin to create pixmap has info message: ')
    this.createPixelMap()
  }

  createPixelMap() {
    let color = new ArrayBuffer(4 * 96 * 96);
    var buffer = new Uint8Array(color);
    for (var i = 0; i < buffer.length; i++) {
      buffer[i] = (i + 1) % 255;
    }
    let opts = {
      alphaType: 0,
      editable: true,
      pixelFormat: 4,
      scaleMode: 1,
      size: { height: 96, width: 96 }
    }
    const promise = image.createPixelMap(color, opts);
    promise.then((data) => {
      console.info('create pixmap has info message: ' + JSON.stringify(data))
      this.pixelMapReader = data;
    })
  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Text('App1')
        .width('40%')
        .height(80)
        .fontSize(20)
        .margin(10)
        .textAlign(TextAlign.Center)
        .backgroundColor(Color.Pink)
        .visibility(Visibility.Visible)

      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.number, (item) => {
          ListItem() {
            Text('' + item)
              .width('100%')
              .height(60)
              .fontSize(16)
              .borderRadius(10)
              .textAlign(TextAlign.Center)
              .backgroundColor(0xFFFFFF)
          }
        }, item => item)

        ListItem() {
          Text('Across Window Drag This')
            .width('80%')
            .height(80)
            .fontSize(16)
            .margin(10)
            .textAlign(TextAlign.Center)
            .backgroundColor(Color.Pink)
            .visibility(this.visible)
        }

        ListItem() {
          Column() {
            Button('Touch').height(30).width(100)
              .onTouch((event: TouchEvent) => {
                if (event.type === TouchType.Down) {
                  this.eventType = 'Down';
                }
                if (event.type === TouchType.Up) {
                  this.eventType = 'Up';
                }
                if (event.type === TouchType.Move) {
                  this.eventType = 'Move';
                }
                this.text = 'TouchType:' + this.eventType + '\nDistance between touch point and touch element:\nx: '
                + event.touches[0].x + '\n' + 'y: ' + event.touches[0].y + '\nComponent globalPos:('
                + event.target.area.globalPosition.x + ',' + event.target.area.globalPosition.y + ')\nwidth:'
                + event.target.area.width + '\nheight:' + event.target.area.height
              })
            Button('Touch').height(40).width(200).margin(10)
              .onTouch((event: TouchEvent) => {
                if (event.type === TouchType.Down) {
                  this.eventType = 'Down';
                }
                if (event.type === TouchType.Up) {
                  this.eventType = 'Up';
                }
                if (event.type === TouchType.Move) {
                  this.eventType = 'Move';
                }
                this.text = 'TouchType:' + this.eventType + '\nDistance between touch point and touch element:\nx: '
                + event.touches[0].x + '\n' + 'y: ' + event.touches[0].y + '\nComponent globalPos:('
                + event.target.area.globalPosition.x + ',' + event.target.area.globalPosition.y + ')\nwidth:'
                + event.target.area.width + '\nheight:' + event.target.area.height
              })
            Text(this.text)
          }
        }
      }
      .height('50%')
      .width('90%')
      .border({ width: 1 })
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 })
      .onDragEnter((event: DragEvent, extraParams: string) => {                         //拖拽进去组件
        console.info('List onDragEnter, ' + extraParams)
      })
      .onDragMove((event: DragEvent, extraParams: string) => {                          //拖拽时移动
        console.info('List onDragMove, ' + extraParams)
      })
      .onDragLeave((event: DragEvent, extraParams: string) => {                         //拖拽离开组件
        console.info('List onDragLeave, ' + extraParams)
      })
      .onDrop((event: DragEvent, extraParams: string) => {                              //释放组件
        console.info('List onDragDrop, ' + extraParams)
        this.visible2 = Visibility.Visible                                              //拖拽完成使拖入目标可见
      })
        // .onDragStart(() => {                    //启动跨窗口拖拽
        //   console.info('Text onDrag start')
        //   return { pixelMap: this.pixelMapReader, extraInfo: 'custom extra info.' }
        // })
        // .onDrop((event: DragEvent, extraParams: string) => {
        //   console.info('Text onDragDrop,  ')
        //   this.visible = Visibility.None                    //拖动结束后，使源不可见
        // })
    }
    .width('100%')
    .height('100%')
  }
}