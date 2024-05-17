import common from '@ohos.app.ability.common';
import router from '@ohos.router';
import Logger from '../Common/utils/Logger';

const RESULT_CODE: number = 1001;

let abilityResult = {
  resultCode: RESULT_CODE,
  want: {
    bundleName: 'com.example.myapplication5',
    abilityName: 'FuncAbility',
    moduleName: 'entry',
    parameters: {
      info: '来自FuncAbility Index页面',
    },
  },
}

@Entry
@Component
struct Page {
  @State message: string = 'Hello FuncAbility'

  private context = getContext(this) as common.UIAbilityContext;
  private first: boolean = true;

  onPageShow() {
    console.info('Page2 onPageShow');
    if (this.first === true) {
      this.first = false;

      let funcAbilityWant = globalThis.funcAbilityWant;
      let url2 = funcAbilityWant?.parameters?.router;
      if (url2 && url2 === 'funcA') {
        // router.replaceUrl({
        //   url: 'pages/PayPage',
        // })
        router.pushUrl({
          url: 'pages/PayPage'
        }).then(() => {
          console.info('Succeeded in jumping to the PayPage page.')
        }).catch((err) => {
          console.error(`Failed to jump to the PayPage page.Code is ${err.code}, message is ${err.message}`)
          Logger.info('[Index]', 'Page push error' + JSON.stringify(err));
        })
      }
    }
  }

  onPageHide() {
    console.info('Page onPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    console.info('Page onBackPress');
  }

  // 组件生命周期
  aboutToAppear() {
    console.info('Page aboutToAppear');

  }

  // 组件生命周期
  aboutToDisappear() {
    console.info('Page aboutToDisappear');
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('stop FuncAbility').onClick(() => {
          // context为需要停止的UIAbility实例的AbilityContext
          // this.context.terminateSelf((err) => {
          //   console.error('startAbility err' + err);
          // });
          // context为被调用方UIAbility的AbilityContext
          let funcAbilityWant = globalThis.funcAbilityWant;
          let url2 = funcAbilityWant?.parameters?.router;
          if (url2 && url2 === 'funcA') {
            this.context.terminateSelfWithResult(abilityResult, (err) => {
              console.error('startAbility err' + err);
            });
          }
        }).margin(10)
      }
      .width('100%')
    }
    .height('100%')
  }
}