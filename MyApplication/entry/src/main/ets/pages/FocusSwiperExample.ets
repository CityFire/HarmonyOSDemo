import promptAction from '@ohos.promptAction';
class MyDataSource implements IDataSource {
  private list: number[] = [];
  private listener: DataChangeListener;

  constructor(list: number[]) {
    this.list = list;
  }

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): any {
    return this.list[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener;
  }

  unregisterDataChangeListener() {
  }

}

@Entry
@Component
struct FocusSwiperExample {
  private swiperController: SwiperController = new SwiperController()
  private data: MyDataSource = new MyDataSource([])

  aboutToAppear(): void {
    let list = []
    for (let i = 1; i <= 4; i++) {
      list.push(i.toString());
    }
    this.data = new MyDataSource(list);
  }

  build() {
    Column({ space: 5 }) {
      Swiper(this.swiperController) {
        LazyForEach(this.data, (item: string) => {
          Row({ space: 20 }) { // 设置该Row组件为tabIndex的第一个节点
            Column() {
              Button('1').width(200).height(200)
                .fontSize(40)
                .backgroundColor('#dadbd9')
                .groupDefaultFocus(true)  // 设置Button-1为第一个tabIndex的默认焦点
                .tabIndex(1)    // Button-1设置为第一个tabIndex节点
            }

            Column({ space: 20 }) {
              Row({ space: 20 }) {
                Button('2')
                  .width(100)
                  .height(100)
                  .fontSize(40)
                  .type(ButtonType.Normal)
                  .borderRadius(20)
                  .backgroundColor('#dadbd9')
                Button('3')
                  .width(100)
                  .height(100)
                  .fontSize(40)
                  .type(ButtonType.Normal)
                  .borderRadius(20)
                  .backgroundColor('#dadbd9')
              }

              Row({ space: 20 }) {
                Button('4')
                  .width(100)
                  .height(100)
                  .fontSize(40)
                  .type(ButtonType.Normal)
                  .borderRadius(20)
                  .backgroundColor('#dadbd9')
                Button('5')
                  .width(100)
                  .height(100)
                  .fontSize(40)
                  .type(ButtonType.Normal)
                  .borderRadius(20)
                  .backgroundColor('#dadbd9')
              }

              Row({ space: 20 }) {
                Button('6')
                  .width(100)
                  .height(100)
                  .fontSize(40)
                  .type(ButtonType.Normal)
                  .borderRadius(20)
                  .backgroundColor('#dadbd9')
                Button('7')
                  .width(100)
                  .height(100)
                  .fontSize(40)
                  .type(ButtonType.Normal)
                  .borderRadius(20)
                  .backgroundColor('#dadbd9')
              }
            }
          }
          .width(480)
          .height(380)
          .justifyContent(FlexAlign.Center)
          .borderWidth(2)
          .borderColor(Color.Gray)
          .backgroundColor(Color.White)
        }, item => item)
      }
      .cachedCount(2)
      .index(0)
      .interval(4000)
      .indicator(true)
      .loop(true)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
      .onChange((index: number) => {
        console.info(index.toString());
      })
      .margin({ left: 20, top: 20, right: 20 })

      Row({ space: 40 }) { // 设置该Row组件为第二个tabIndex节点
        Button('←')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.swiperController.showPrevious();
          })
          .groupDefaultFocus(true) // 设置该Row组件为第二个tabIndex节点
          .tabIndex(2)    // Button-左箭头设置为第二个tabIndex节点
        Button('→')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.swiperController.showNext();
          })
      }
      .width(480)
      .height(50)
      .justifyContent(FlexAlign.Center)
      .borderWidth(2)
      .borderColor(Color.Gray)
      .backgroundColor('#f7f6dc')

      Row({ space: 40 }) { // 设置该Row组件为第三个tabIndex节点
        Button('Cancel')
          .fontSize(30)
          .fontColor('#787878')
          .type(ButtonType.Normal)
          .width(140)
          .height(50)
          .backgroundColor('#dadbd9')

        Button('OK')
          .defaultFocus(true)  // 设置Button-OK为defaultFocus
          .fontSize(30)
          .fontColor('#787878')
          .type(ButtonType.Normal)
          .width(140)
          .height(50)
          .backgroundColor('#dadbd9')
          .onClick(() => {
            promptAction.showToast({ message: 'Button OK on clicked' });
          })
          .groupDefaultFocus(true)    // 设置Button-OK为第三个tabIndex节点的默认焦点
          .tabIndex(3)    // Button-OK设置为第三个tabIndex节点
      }
      .width(480)
      .height(80)
      .justifyContent(FlexAlign.Center)
      .borderWidth(2)
      .borderColor(Color.Gray)
      .backgroundColor('#dff2e4')
      .margin({ left: 20, bottom: 20, right: 20 })
    }.backgroundColor('#f2f2f2')
    .margin({ left: 50, top: 50, right: 20 })
  }
}


@Component
struct RequestFocusExample {
  @State idList: string[] = ['A', 'B', 'C', 'D', 'E', 'F', 'N']
  @State requestId: number = 0

  build() {
    Column({ space:20 }){
      Button("id: " + this.idList[0] + " focusOnTouch(true) + focusable(false)")
        .width(400).height(70).fontColor(Color.White).focusOnTouch(true)
        .focusable(false)
      Button("id: " + this.idList[1] + " default")
        .width(400).height(70).fontColor(Color.White)
      Button("id: " + this.idList[2] + " focusOnTouch(false)")
        .width(400).height(70).fontColor(Color.White).focusOnTouch(false)
      Button("id: " + this.idList[3] + " focusOnTouch(true)")
        .width(400).height(70).fontColor(Color.White).focusOnTouch(true)
    }.width('100%').margin({ top:20 })

    /*
    Column({ space:20 }){
      Row({space: 5}) {
        Button("id: " + this.idList[0] + " focusable(false)")
          .width(200).height(70).fontColor(Color.White)
          .id(this.idList[0])
          .focusable(false)
        Button("id: " + this.idList[1])
          .width(200).height(70).fontColor(Color.White)
          .id(this.idList[1])
      }
      Row({space: 5}) {
        Button("id: " + this.idList[2])
          .width(200).height(70).fontColor(Color.White)
          .id(this.idList[2])
        Button("id: " + this.idList[3])
          .width(200).height(70).fontColor(Color.White)
          .id(this.idList[3])
      }
      Row({space: 5}) {
        Button("id: " + this.idList[4])
          .width(200).height(70).fontColor(Color.White)
          .id(this.idList[4])
        Button("id: " + this.idList[5])
          .width(200).height(70).fontColor(Color.White)
          .id(this.idList[5])
      }
    }.width('100%').margin({ top:20 })
    .onKeyEvent((e) => {
      if (e.keyCode >= 2017 && e.keyCode <= 2022) {
        this.requestId = e.keyCode - 2017;
      } else if (e.keyCode === 2030) {
        this.requestId = 6;
      } else {
        return;
      }
      if (e.type !== KeyType.Down) {
        return;
      }
      let res = focusControl.requestFocus(this.idList[this.requestId]);
      if (res) {
        promptAction.showToast({message: 'Request success'});
      } else {
        promptAction.showToast({message: 'Request failed'});
      }
    })
    */
  }
}

