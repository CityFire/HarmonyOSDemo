// stateStyles是属性方法，可以根据UI内部状态来设置样式，类似于css伪类，但语法不同。ArkUI提供以下四种状态：
//
// focused：获焦态。
// normal：正常态。
// pressed：按压态。
// disabled：不可用态。

@Entry
@Component
struct StateStylesSample {
  // class类型
  @State title: Model = new Model('Hello', new ClassA('World'));

  @State model: Model2[] = [new Model2(11), new Model2(1)];

  @Styles normalStyle() {
    .backgroundColor(Color.Gray)
  }

  @Styles pressedStyle() {
    .backgroundColor(Color.Red)
  }

  build() {
    Column() {
      // class类型赋值
      // this.title = new Model('Hi', new ClassA('ArkUI'));
      // 数组自身的赋值可以观察到。
      // this.model = [new Model(2)];
      // 数组项的赋值可以观察到。
      // this.model[0] = new Model2(2);
      // 删除数组项可以观察到。
      // this.model.pop();
      // 新增数组项可以观察到。
      // this.model.push(new Model2(12));
      // 数组项中属性的赋值观察不到。
      // this.model[0].value = 6;

      Button('Button1')
        .stateStyles({
          focused: {
            .backgroundColor(Color.Pink)
        },
          pressed: {
            .backgroundColor(Color.Black)
        },
          normal: {
            .backgroundColor(Color.Red)
        }
        })
        .margin(20)
      Button('Button2')
        .stateStyles({
          focused: {
            .backgroundColor(Color.Pink)
        },
          pressed: {
            .backgroundColor(Color.Black)
        },
          normal: {
            .backgroundColor(Color.Red)
        }
        })
      Text('Text1')
        .fontSize(50)
        .fontColor(Color.White)
        .stateStyles({
          normal: this.normalStyle,
          pressed: this.pressedStyle,
        })
    }.margin('30%')
  }
}

@Component
struct CompWithInlineStateStyles {
  @State focusedColor: Color = Color.Red;
  normalColor: Color = Color.Green

  build() {
    Column() {

      Button('clickMe').height(100).width(100)
        .stateStyles({
          normal: {
            .backgroundColor(this.normalColor)
          },
          focused: {
            .backgroundColor(this.focusedColor)
          }
        })
        .onClick(() => {
          this.focusedColor = Color.Pink
        })
        .margin('30%')
    }
  }
}

class ClassA {
  public value: string;

  constructor(value: string) {
    this.value = value;
  }
}

class Model {
  public value: string;
  public name: ClassA;
  constructor(value: string, a: ClassA) {
    this.value = value;
    this.name = a;
  }
}

class Model2 {
  public value: number;

  constructor(value: number) {
    this.value = value;
  }
}