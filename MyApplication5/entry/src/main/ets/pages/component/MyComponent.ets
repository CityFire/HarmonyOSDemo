@Component
struct MyComponent2 {
  build() {
    Button(`Hello World`)
  }
}

@Entry
@Component
export struct MyComponent {
  private countDownFrom: number = 0;
  private color: Color = Color.Blue;

  build() {
     // 根节点唯一且必要，必须为容器组件
    Row() {
      MyComponent2()
        .width(200)
        .height(300)
        .backgroundColor(Color.Red) // 自定义组件通过“.”链式调用的形式设置通用样式
    }
  }
}