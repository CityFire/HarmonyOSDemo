import { HelloComponent } from './HelloComponent';
import { MyComponent } from './MyComponent';

@Entry
@Component
struct ParentComponent {
  private someColor: Color = Color.Pink;

  doSomeCalculations() {
  }

  calcTextValue(): string {
    return 'Hello World';
  }

  @Builder doSomeRender() {
    Text(`Hello Wolrd`)
  }

  build() {
    Column() {
      Text('ArkUI message')
      HelloComponent({ message: 'Hello, World!'});
      Divider()
      HelloComponent({ message: '你好!'});
      // 创建MyComponent实例，并将创建MyComponent成员变量countDownFrom初始化为10，将成员变量color初始化为this.someColor
      MyComponent({ countDownFrom: 10, color: this.someColor })

      // 反例：不能调用没有用@Builder装饰的方法
      // this.doSomeCalculations();
      // 正例：可以调用
      this.doSomeRender();
      // 正例：参数可以为调用TS方法的返回值
      Text(this.calcTextValue())

      /*
      // 反例：不允许使用switch语法
      switch (expression) {
        case 1:
          Text('...')
          break;
        case 2:
          Image('...')
          break;
        default:
          Text('...')
          break;
      }
      * */

        // 反例：不允许使用表达式
      // (this.aVar > 10) ? Text('...') : Image('...')
    }
  }
}