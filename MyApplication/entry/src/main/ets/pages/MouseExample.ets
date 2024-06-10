@Entry
@Component
struct MouseExample {
  @State isHovered: boolean = false;
  @State buttonText: string = '';
  @State buttonType: string = '';
  @State columnText: string = '';
  @State columnType: string = '';

  build() {
    Column() {
      Button(this.isHovered ? 'Hovered!' : 'Not Hover')
        .width(200).height(100)
        .backgroundColor(this.isHovered ? Color.Green : Color.Gray)
        .onHover((isHover: boolean) => { // 使用onHover接口监听鼠标是否悬浮在Button组件上
          this.isHovered = isHover;
        })
        .onMouse((event: MouseEvent) => { // 给Button组件设置onMouse回调
          event.stopPropagation(); // 在Button的onMouse事件中设置阻止冒泡  当鼠标在Button组件上操作时，仅Button的onMouse回调会响应，Column的onMouse回调不会响应。
          this.buttonText = 'Button onMouse:\n' + '' +
          'button = ' + event.button + '\n' +
          'action = ' + event.action + '\n' +
          'x,y = (' + event.x + ',' + event.y + ')' + '\n' +
          'screenXY=(' + event.screenX + ',' + event.screenY + ')';
        })

      Button('onKeyEvent')
        .width(140).height(70)
        .onKeyEvent((event: KeyEvent) => { // 给Button设置onKeyEvent事件
          // 通过stopPropagation阻止事件冒泡
          event.stopPropagation();
          if (event.type === KeyType.Down) {
            this.buttonType = 'Down';
          }
          if (event.type === KeyType.Up) {
            this.buttonType = 'Up';
          }
          this.buttonText = 'Button: \n' +
          'KeyType:' + this.buttonType + '\n' +
          'KeyCode:' + event.keyCode + '\n' +
          'KeyText:' + event.keyText;
        })

      Divider()
      Text(this.buttonText).fontColor(Color.Green)
      Divider()
      Text(this.columnText).fontColor(Color.Red)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .borderWidth(2)
    .borderColor(Color.Red)
    .onMouse((event: MouseEvent) => {    // 给Column组件设置onMouse回调
      this.columnText = 'Column onMouse:\n' + '' +
      'button = ' + event.button + '\n' +
      'action = ' + event.action + '\n' +
      'x,y = (' + event.x + ',' + event.y + ')' + '\n' +
      'screenXY=(' + event.screenX + ',' + event.screenY + ')';
    })
    .onKeyEvent((event: KeyEvent) => { // 给父组件Column设置onKeyEvent事件
      if (event.type === KeyType.Down) {
        this.columnType = 'Down';
      }
      if (event.type === KeyType.Up) {
        this.columnType = 'Up';
      }
      this.columnText = 'Column: \n' +
      'KeyType:' + this.buttonType + '\n' +
      'KeyCode:' + event.keyCode + '\n' +
      'KeyText:' + event.keyText;
    })
  }
}


@Component
struct HoverExample {
  build() {
    Column({ space: 10 }) {
      Button('Auto')
        .width(170).height(70)
      Button('Scale')
        .width(170).height(70)
        .hoverEffect(HoverEffect.Scale)
      Button('Highlight')
        .width(170).height(70)
        .hoverEffect(HoverEffect.Highlight)
      Button('None')
        .width(170).height(70)
        .hoverEffect(HoverEffect.None)
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }
}