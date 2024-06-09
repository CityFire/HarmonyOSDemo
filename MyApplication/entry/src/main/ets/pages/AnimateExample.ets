import curves from '@ohos.curves';
import router from '@ohos.router';
@Entry
@Component
struct AnimateExample {
  // 用于控制Column的alignItems属性
  @State itemAlign: HorizontalAlign = HorizontalAlign.Start;
  allAlign: HorizontalAlign[] = [HorizontalAlign.Start, HorizontalAlign.Center, HorizontalAlign.End];
  alignIndex: number = 0;

  @State myWidth: number = 100;
  @State myHeight: number = 50;
  // 标志位，true和false分别对应一组myWidth、myHeight值
  @State flag: boolean = false;
  @State myColor: Color = Color.Blue;

  // @State flag: boolean = true;
  @State show: string = 'show';

  @Builder LayoutChange() {
    Column({ space: 10 }) {
      Button("1").width(100).height(50)
      Button("2").width(100).height(50)
      Button("3").width(100).height(50)
    }
    .margin(20)
    .alignItems(this.itemAlign)
    .borderWidth(2)
    .width('90%')
    .height(200)

    Button("click").onClick(() => {
      // 动画时长为1000ms，曲线为EaseInOut
      animateTo({ duration: 1000, curve: Curve.EaseInOut }, () => {
        this.alignIndex = (this.alignIndex + 1) % this.allAlign.length;
        // 在闭包函数中修改this.itemAlign参数，使Column容器内部孩子的布局方式变化，使用动画过渡到新位置
        this.itemAlign = this.allAlign[this.alignIndex];
      });
    })
  }

  @Builder animationTo() {
    Column() {
      // Button放在足够大的容器内，使其不影响更外层的组件位置
      Button("text")
        .type(ButtonType.Normal)
        .width(this.myWidth)
        .height(this.myHeight)
    }
    .margin(20)
    .width(200)
    .height(100)
    // Button("text")
    //   .type(ButtonType.Normal)
    //   .width(this.myWidth)
    //   .height(this.myHeight)
    //   .margin(20)
    Button("area: click me")
      .fontSize(12)
        // 配置position属性固定，使自己的布局位置不被第一个Button的宽高影响
      .position({ x: "30%", y: 200 })
      .margin(20)
      .onClick(() => {
        animateTo({ duration: 1000, curve: Curve.Ease }, () => {
          // 动画闭包中根据标志位改变控制第一个Button宽高的状态变量，使第一个Button做宽高动画
          if (this.flag) {
            this.myWidth = 100;
            this.myHeight = 50;
          } else {
            this.myWidth = 200;
            this.myHeight = 100;
          }
          this.flag = !this.flag;
        });
      })
  }

  // page A
  pageTransition() {
    // 定义页面进入时的效果，从左侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: 1200 })
      .slide(SlideEffect.Left)
    // 定义页面退出时的效果，向左侧滑出，时长为1000ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ type: RouteType.None, duration: 1000 })
      .slide(SlideEffect.Left)
    // 定义页面进入时的效果，从右侧滑入，时长为1200ms，页面栈发生push操作时该效果才生效
    PageTransitionEnter({ type: RouteType.Push, duration: 1200 })
      .slide(SlideEffect.Right)
    // 定义页面进入时的效果，从左侧滑入，时长为1200ms，页面栈发生pop操作时该效果才生效
    PageTransitionEnter({ type: RouteType.Pop, duration: 1200 })
      .slide(SlideEffect.Left)
    // 定义页面退出时的效果，向左侧滑出，时长为1000ms，页面栈发生push操作时该效果才生效
    PageTransitionExit({ type: RouteType.Push, duration: 1000 })
      .slide(SlideEffect.Left)
    // 定义页面退出时的效果，向右侧滑出，时长为1000ms，页面栈发生pop操作时该效果才生效
    PageTransitionExit({ type: RouteType.Pop, duration: 1000 })
      .slide(SlideEffect.Right)
  }

  build() {
    // Column() {
    //   this.LayoutChange();
    // }
    // .width("100%")
    // .height("100%")

    Column({ space: 10 }) {
      Button("text")
        .type(ButtonType.Normal)
        .width(this.myWidth)
        .height(this.myHeight)
          // animation只对其上面的type、width、height属性生效，时长为1000ms，曲线为Ease
        .animation({ duration: 1000, curve: Curve.Ease })
          // animation对下面的backgroundColor、margin属性不生效
        .backgroundColor(this.myColor)
        .margin(20)


      Button("area: click me")
        .fontSize(12)
        .onClick(() => {
          // 改变属性值，配置了属性动画的属性会进行动画过渡
          if (this.flag) {
            this.myWidth = 100;
            this.myHeight = 50;
            this.myColor = Color.Blue;
          } else {
            this.myWidth = 200;
            this.myHeight = 100;
            this.myColor = Color.Pink;
          }
          this.flag = !this.flag;
        })
        .transition({ type: TransitionType.Insert, translate: { x: 200, y: -200 }, opacity: 0 })
        // .transition({ type: TransitionType.Delete, rotate: { x: 0, y: 0, z: 1, angle: 360 } })
        .transition({ type: TransitionType.Delete, translate: { x: 200, y: -200 } })

      Button(this.show).width(80).height(30).margin(30)
        .onClick(() => {
          if (this.flag) {
            this.show = 'hide';
          } else {
            this.show = 'show';
          }
          // 点击Button控制Image的显示和消失
          // this.flag = !this.flag;
          animateTo({ duration: 1000 }, () => {
            // 动画闭包内控制Image组件的出现和消失
            this.flag = !this.flag;
          })
        })
      if (this.flag) {
        // Image的出现和消失配置为不同的过渡效果
        Image($r('app.media.ic_banner03')).width(200).height(150)
          .transition({ type: TransitionType.Insert, translate: { x: 200, y: -200 } })
          .transition({ type: TransitionType.Delete, opacity: 0, scale: { x: 0, y: 0 } })
      }
      // 配置Exchange类型的共享元素转场，共享元素id为"sharedImage1"
      Image($r('app.media.ic_banner02')).width(150).height(100)
        .sharedTransition('sharedImage1', { duration: 1000, curve: Curve.Linear })
        .onClick(() => {
          // 点击小图时路由跳转至下一页面
          router.pushUrl({ url: 'pages/SharedTransitionDest' });
        })
    }
    .width("100%")
    .height("100%")
  }
}

@Component
struct ForEachTransition {
  @State numbers: string[] = ["1", "2", "3", "4", "5"]
  startNumber: number = 6;

  build() {
    Column({ space: 10 }) {
      Column() {
        ForEach(this.numbers, (item) => {
          // ForEach下的直接组件需配置transition效果
          Text(item)
            .width(240)
            .height(60)
            .fontSize(18)
            .borderWidth(1)
            .backgroundColor(Color.Orange)
            .textAlign(TextAlign.Center)
            .transition({ type: TransitionType.All, translate: { x: 200 }, scale: { x: 0, y: 0 } })
        }, item => item)
      }
      .margin(10)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .width("90%")
      .height("70%")

      Button('向头部添加元素')
        .fontSize(16)
        .width(160)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 往数组头部插入一个元素，导致ForEach在头部增加对应的组件
            this.numbers.unshift(this.startNumber.toString());
            this.startNumber++;
          })
        })
      Button('向尾部添加元素')
        .width(160)
        .fontSize(16)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 往数组尾部插入一个元素，导致ForEach在尾部增加对应的组件
            this.numbers.push(this.startNumber.toString());
            this.startNumber++;
          })
        })
      Button('删除头部元素')
        .width(160)
        .fontSize(16)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 删除数组的头部元素，导致ForEach删除头部的组件
            this.numbers.shift();
          })
        })
      Button('删除尾部元素')
        .width(160)
        .fontSize(16)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            // 删除数组的尾部元素，导致ForEach删除尾部的组件
            this.numbers.pop();
          })
        })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SpringTest {
  @State translateX: number = 0;

  private jumpWithSpeed(speed: number) {
    this.translateX = -1;
    animateTo({ duration: 2000, curve: curves.springCurve(speed, 1, 1, 1.2) }, () => {
      // 以指定初速度进行x方向的平移的弹簧动画
      this.translateX = 0;
    })
  }

  build() {
    Column() {
      Button("button")
        .fontSize(14)
        .width(100)
        .height(50)
        .margin(30)
        .translate({ x: this.translateX })
      Row({space:50}) {
        Button("jump 50").fontSize(14)
          .onClick(() => {
            // 以初速度50的弹簧曲线进行平移
            this.jumpWithSpeed(50);
          })
        Button("jump 200").fontSize(14)
          .onClick(() => {
            // 以初速度200的弹簧曲线进行平移
            this.jumpWithSpeed(200);
          })
      }.margin(30)
    }.height('100%').width('100%')
  }
}


@Component
struct SpringMotionTest {
  @State positionX: number = 100;
  @State positionY: number = 100;
  diameter: number = 50;

  build() {
    Column() {
      Row() {
        Circle({ width: this.diameter, height: this.diameter })
          .fill(Color.Blue)
          .position({ x: this.positionX, y: this.positionY })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move) {
              // 跟手过程，使用responsiveSpringMotion曲线
              animateTo({ curve: curves.responsiveSpringMotion() }, () => {
                // 减去半径，以使球的中心运动到手指位置
                this.positionX = event.touches[0].screenX - this.diameter / 2;
                this.positionY = event.touches[0].screenY - this.diameter / 2;
                console.info(`move, animateTo x:${this.positionX}, y:${this.positionY}`);
              })
            } else if (event.type === TouchType.Up) {
              // 离手时，使用springMotion曲线
              animateTo({ curve: curves.springMotion() }, () => {
                this.positionX = 100;
                this.positionY = 100;
                console.info(`touchUp, animateTo x:100, y:100`);
              })
            }
          })
      }
      .width("100%").height("80%")
      .clip(true) // 如果球超出父组件范围，使球不可见
      .backgroundColor(Color.Orange)

      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Start, justifyContent: FlexAlign.Center }) {
        Text("拖动小球").fontSize(16)
      }
      .width("100%")

      Row() {
        Text('点击位置: [x: ' + Math.round(this.positionX) + ', y:' + Math.round(this.positionY) + ']').fontSize(16)
      }
      .padding(10)
      .width("100%")
    }.height('100%').width('100%')
  }
}