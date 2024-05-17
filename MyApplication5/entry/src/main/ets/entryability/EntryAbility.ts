import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  para:Record<string, number> = { 'PropA': 47 };
  storage: LocalStorage = new LocalStorage(this.para);

  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

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
    this.context.startAbility(want).then(() => {
      // ...
    }).catch((err) => {
      // ...
    })

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


