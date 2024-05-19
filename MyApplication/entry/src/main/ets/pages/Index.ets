// Index.ets
// 导入页面路由模块
import router from '@ohos.router';
import common from '@ohos.app.ability.common';

const TAG = 'Index';

const RESULT_CODE: number = 1001;
let abilityResult = {
  resultCode: RESULT_CODE,
  want: {
    bundleName: 'com.example.myapplication',
    abilityName: 'EntryAbility',
    moduleName: 'entry',
    parameters: {
      payResult: 'OKay',
    },
  },
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Row() {
      Column() {

        List() {
          ListItem() {
            Text('点击menu')  // $r('app.string.click_to_menu')
              .fontSize(18)
              .textAlign(TextAlign.Start)
              .width('100%')
              .fontWeight(500)
              .height('100%')
          }
          .id('clickToMenu')
          .borderRadius(24)
          .width('685px')
          .height('84px')
          .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary'))
          .margin({ top: 10, bottom: 10 })
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .onClick(() => {
            router.pushUrl({
              url: '@bundle:com.example.myapplication/library/ets/pages/MenuPage' // '@bundle:包名（bundleName）/模块名（moduleName）/路径/页面所在的文件名(不加.ets后缀)'
            }).then(() => {
              console.log('push page success');
              console.info('push page success');
            }).catch((err) => {
              console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
            })
          })
        }
        .alignListItem(ListItemAlign.Center)
      }
      .width('100%')
      .backgroundColor($r('app.color.page_background'))
      .height('100%')

        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        // 添加按钮，以响应用户点击
        Button() {
          Text('Next')
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
          console.info(`Succeeded in clicking the 'Next' button.`)
          // 跳转到第二页
          router.pushUrl({ url: 'pages/Second' }).then(() => {
            console.info('Succeeded in jumping to the second page.')
          }).catch((err) => {
            console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
          })
        }).margin(10)

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
          console.info(`Succeeded in clicking the 'stop' button.`)
          // context为需要停止的UIAbility实例的AbilityContext
          // this.context.terminateSelf((err) => {
          //   console.error(`Failed to jump to the prefix page.Code is ${err.code}, message is ${err.message}`)
          // });
          this.context.terminateSelfWithResult(abilityResult, (err) => {
            // ...
            console.error(`Failed to jump to the prefix page.Code is ${err.code}, message is ${err.message}`)
          });
        })
      }
      .width('100%')
  }
}