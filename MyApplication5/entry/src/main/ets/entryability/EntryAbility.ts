import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import AbilityStage from '@ohos.app.ability.AbilityStage';
import Logger from '../Common/utils/Logger';

const TAG = '[EntryAbility]';

export default class EntryAbility extends UIAbility {
  para:Record<string, number> = { 'PropA': 47 };
  storage: LocalStorage = new LocalStorage(this.para);

  windowStage: window.WindowStage;
  tag: string = 'EntryAbility';
  domain: number = 0x0000;
  want: Want;
  launchParam: AbilityConstant.LaunchParam;

  onCreate(want, launchParam) {
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    Logger.info(TAG, 'Ability onCreate');
    AppStorage.SetOrCreate('abilityWant', want);
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    this.windowStage = windowStage;

    // Setting Event Subscription for WindowStage (Obtained/Out-of-focus, Visible/Invisible)
    try {
      windowStage.on('windowStageEvent', (data) => {
        hilog.info(
          this.domain,
          'Succeeded in enabling the listener for window stage event changes. Data: %{public}',
          JSON.stringify(data)?? '');
      });
    } catch (exception) {
      hilog.error(
        this.domain,
        'Failed to enable the listener for window stage event changes. Cause: %{public}',
        JSON.stringify(exception)?? '');
    }

    // 在启动指定实例模式的UIAbility时，给每一个UIAbility实例配置一个独立的Key标识
    // 例如在文档使用场景中，可以用文档路径作为Key标识
    function getInstance() {
      // ...
    }

    let want = {
      deviceId: '', // deviceId为空表示本设备
      bundleName: 'com.example.myapplication',
      abilityName: 'FuncAbility',
      moduleName: 'module1', // moduleName非必选
      parameters: { // 自定义信息
        instanceKey: getInstance(),
      },
    }
    // context为调用方UIAbility的AbilityContext
    // this.context.startAbility(want).then(() => {
    //   // ...
    // }).catch((err) => {
    //   // ...
    // })


    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // windowStage.loadContent('pages/Index', this.storage);
    // windowStage.loadContent('pages/component/AppStorage2Component', this.storage);

    windowStage.loadContent('pages/Index', (err, data) => {
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
    try {
      this.windowStage.off('windowStageEvent');
    } catch (exception) {
      hilog.error(this.domain, 'Failed to disable the listener for window stage event changes. Cause: %{public}s',
        JSON.stringify(exception));
    }
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


// export default class MyAbilityStage extends AbilityStage {
//   onAcceptWant(want): string {
//     // 在被调用方的AbilityStage中，针对启动模式为specified的UIAbility返回一个UIAbility实例对应的一个Key值
//     // 当前示例指的是module1 Module的FuncAbility
//     if (want.abilityName === 'FuncAbility') {
//       // 返回的字符串Key标识为自定义拼接的字符串内容
//       return `ControlModule_EntryAbilityInstance_${want.parameters.instanceKey}`;
//     }
//
//     return '';
//   }
// }

