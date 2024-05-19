import { MyTitleBar } from '../components/MyTitleBar'
import { add, nativeMulti } from '../Index'
import { ResManager } from '../ResManager'
import { Logger } from '../utils/Logger'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        List() {
          ListItem() {
            MyTitleBar()
          }
          .margin({ left: '35px', top: '32px' })

          ListItem() {
            Text(this.message)
              .fontFamily('HarmonyHeiTi')
              .fontSize(18)
              .textAlign(TextAlign.Start)
              .width('100%')
              .fontWeight(FontWeight.Bold)
          }
          .width('685px')
          .margin({ top: 30, bottom: 10 })

          ListItem() {
            // ResManager返回的Resource对象，可以传给组件直接使用，也可以从中取出资源来使用
            Image(ResManager.getPic())
              .id('image')
              .borderRadius('48px')
          }
          .width('685px')
          .margin({ top: 10, bottom: 10 })
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })

          ListItem() {
            Text($r('app.string.add'))
              .fontSize(18)
              .textAlign(TextAlign.Start)
              .width('100%')
              .fontWeight(500)
              .height('100%')
          }
          .id('add')
          .borderRadius(24)
          .width('685px')
          .height('84px')
          .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary'))
          .margin({ top: 10, bottom: 10 })
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .onClick(() => {
            Logger.info('add button click!');
            this.message = 'result: ' + add(1, 2);
          })

          ListItem() {
            Text($r('app.string.get_string_value'))
              .fontSize(18)
              .textAlign(TextAlign.Start)
              .width('100%')
              .fontWeight(500)
              .height('100%')
          }
          .id('getStringValue')
          .borderRadius(24)
          .width('685px')
          .height('84px')
          .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary'))
          .margin({ top: 10, bottom: 10 })
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .onClick(() => {
            // 先通过当前上下文获取hsp模块的上下文，再获取hsp模块的resourceManager，然后再调用resourceManager的接口获取资源
            getContext()
              .createModuleContext('library')
              .resourceManager
              .getStringValue(ResManager.getDesc())
              .then(value => {
                Logger.info(`getStringValue is ${value}`);
                this.message = 'getStringValue is ' + value;
              })
              .catch((err) => {
                Logger.info(`getStringValue promise error is ${err}`);
              });
          })

          ListItem() {
            Text($r('app.string.native_multi'))
              .fontSize(18)
              .textAlign(TextAlign.Start)
              .width('100%')
              .fontWeight(500)
              .height('100%')
          }
          .id('nativeMulti')
          .borderRadius(24)
          .width('685px')
          .height('84px')
          .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary'))
          .margin({ top: 10, bottom: 10 })
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .onClick(() => {
            Logger.info('nativeMulti button click!');
            this.message = 'result: ' + nativeMulti(3, 4);
          })
        }
      }
    }
    .width('100%')
    .backgroundColor($r('app.color.page_background'))
    .height('100%')
  }
}