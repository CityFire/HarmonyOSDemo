import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

export default class FuncAbility extends UIAbility {
  funcAbilityWant;

  // 当被调用方Ability的启动模式设置为multiton启动模式时，每次启动都会创建一个新的实例，那么onNewWant()回调就不会被用到。
  onNewWant(want, launchParam) {
    // 接收调用方UIAbility传过来的参数
    globalThis.funcAbilityWant = want;
    // ...
  }

  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // AbilityB从globalThis读取name并输出
    console.info('name from entryAbilityStr: ' + globalThis.entryAbilityStr);

    // AbilityB覆盖了AbilityA在globalThis中存放的context
    // globalThis.context = this.context;

    // 接收调用方UIAbility传过来的参数
    this.funcAbilityWant = want;

    globalThis.funcAbilityWant = want;

    let info = this.funcAbilityWant?.parameters?.info;
    // ...
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    let url = 'pages/FuncPage';
    if (this.funcAbilityWant?.parameters?.router) {
      if (this.funcAbilityWant.parameters.router === 'funcA') {
        url = 'pages/FuncPage';
      }
    }

    windowStage.loadContent(url, (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
