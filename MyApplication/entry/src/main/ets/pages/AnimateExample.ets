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
    }
    .width("100%")
    .height("100%")
  }
}