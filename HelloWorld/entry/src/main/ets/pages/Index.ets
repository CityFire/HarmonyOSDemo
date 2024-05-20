import common from '@ohos.app.ability.common';

import { MainPage } from 'package';
import { Log } from 'package';
import { func } from 'package';
import { nativeAdd } from 'package';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Row() {
      // 引用HAR的ArkUI组件
      MainPage()
      Column() {
        Text(this.message + 'func return: ' + func())
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Red)
          .margin(10)

        // 引用HAR的字符串资源
        Text($r('app.string.empty'))
          .id('stringHar')
          .fontFamily('HarmonyHeiTi')
          .fontColor($r('app.color.text_color'))
          .fontSize(24)
          .fontWeight(500)
          .margin({ top: '40%' })

        Button() {
          Text('stop')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        // 跳转按钮绑定onClick事件，点击时跳转到第二页
        .onClick(() => {
          // 引用HAR的类和方法
          Log.info('har msg');
          this.message = 'func return: ' + func();
          //引用HAR的native方法
          this.message = 'result: ' + nativeAdd(1, 2);

          console.info(`Succeeded in clicking the 'stop' button.`)
          // context为需要停止的UIAbility实例的AbilityContext
          this.context.terminateSelf((err) => {
            console.error(`Failed to jump to the prefix page.Code is ${err.code}, message is ${err.message}`)
          });
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}