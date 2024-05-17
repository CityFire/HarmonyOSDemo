import common from '@ohos.app.ability.common';

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
  @State message: string = 'Hello World'

  private context = getContext(this) as common.UIAbilityContext;

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
          this.context.terminateSelfWithResult(abilityResult, (err) => {
            console.error('startAbility err' + err);
          });
        }).margin(10)
      }
      .width('100%')
    }
    .height('100%')
  }
}