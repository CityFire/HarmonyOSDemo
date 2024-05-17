// @Extend(UIComponentName) function functionName { } // 语法
// @Extend仅支持定义在全局，不支持在组件内部定义
// @Extend(Text)可以支持Text的私有属性fontColor
@Extend(Text) function fancy() {
  .fontColor(Color.Red)
}
// superFancyText可以调用预定义的fancy
@Extend(Text) function superFancyText(size:number) {
  .fontSize(size)
  .fancy()
}

// xxx.ets
@Extend(Text) function fancy_ (fontSize: number) {
  .fontColor(Color.Red)
  .fontSize(fontSize)
}

@Extend(Text) function makeMeClick(onClick: () => void) {
  .backgroundColor(Color.Blue)
  .onClick(onClick)
}

@Extend(Text) function fancyText(weightValue: number, color: Color) {
  .fontStyle(FontStyle.Italic)
  .fontWeight(weightValue)
  .backgroundColor(color)
}

@Entry
@Component
struct FancyUse {
  @State label: string = 'Hello World';
  @State fontSizeValue: number = 20;

  onClickHandler() {
    this.label = 'Hello ArkUI';
  }

  build() {
    Row({ space: 10 }) {
      Text('Fancy')
        .fancy_(16)
      Text('Fancy')
        .fancy_(this.fontSizeValue)
        .onClick(() => {
          this.fontSizeValue = 30
        })
      Text('Fancy')
        .fancy_(24)
      Text(`${this.label}`)
        .makeMeClick(this.onClickHandler.bind(this))
      Text(`${this.label}`)
        .fontStyle(FontStyle.Italic)
        .fontWeight(100)
        .backgroundColor(Color.Blue)
      Text(`${this.label}`)
        .fontStyle(FontStyle.Italic)
        .fontWeight(200)
        .backgroundColor(Color.Pink)
      Text(`${this.label}`)
        .fontStyle(FontStyle.Italic)
        .fontWeight(300)
        .backgroundColor(Color.Orange)
      Text(`${this.label}`)
        .fancyText(100, Color.Blue)
      Text(`${this.label}`)
        .fancyText(200, Color.Pink)
      Text(`${this.label}`)
        .fancyText(300, Color.Orange)
    }.margin('20%')
  }
}
