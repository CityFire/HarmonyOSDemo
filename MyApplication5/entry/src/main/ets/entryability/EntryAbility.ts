import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import AbilityStage from '@ohos.app.ability.AbilityStage';
import Logger from '../Common/utils/Logger';

const TAG: string = '[Example].[Entry].[EntryAbility]';

let lifecycleId;
let callbackId;

export default class EntryAbility extends UIAbility {
  para:Record<string, number> = { 'PropA': 47 };
  storage: LocalStorage = new LocalStorage(this.para);

  windowStage: window.WindowStage;
  tag: string = 'EntryAbility';
  domain: number = 0x0000;
  want: Want;
  launchParam: AbilityConstant.LaunchParam;

  func1(...data) {
    // 触发事件，完成相应的业务操作
    Logger.info(TAG, '1. ' + JSON.stringify(data));
  }

  onCreate(want, launchParam) {
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    Logger.info(TAG, 'Ability onCreate');
    AppStorage.SetOrCreate('abilityWant', want);

    let cacheDir = this.context.cacheDir;
    let tempDir = this.context.tempDir;
    let filesDir = this.context.filesDir;
    let databaseDir = this.context.databaseDir;
    let bundleCodeDir = this.context.bundleCodeDir;
    let distributedFilesDir = this.context.distributedFilesDir;
    let preferencesDir = this.context.preferencesDir;

    // 存储普通信息前，切换到EL1设备级加密
    if (this.context.area === 1) { // 获取area
      this.context.area = 0;     // 修改area
    }
    // 存储普通信息

    // 存储敏感信息前，切换到EL2用户级加密
    if (this.context.area === 0) { // 获取area
      this.context.area = 1;     // 修改area
    }
    // 存储敏感信息

    // 创建其他应用或其他Module的Context
    let moduleName2 = "module1";
    let context2 = this.context.createModuleContext(moduleName2);

    // 获取eventHub
    let eventhub = this.context.eventHub;
    // 执行订阅操作
    eventhub.on('event1', this.func1);
    eventhub.on('event1', (...data) => {
      // 触发事件，完成相应的业务操作
      Logger.info(TAG, '2. ' + JSON.stringify(data));
    });

    globalThis.entryAblityWant = want;

    globalThis.entryAbilityStr = 'AbilityA'; // AbilityA存放字符串“AbilityA”到globalThis

    globalThis.context = this.context; // AbilityA存放context到globalThis

    let AbilityLifecycleCallback = {
      onAbilityCreate(ability) {
        console.log('AbilityLifecycleCallback onAbilityCreate ability:' + ability);
      },
      onWindowStageCreate(ability, windowStage) {
        console.log('AbilityLifecycleCallback onWindowStageCreate ability:' + ability);
        console.log('AbilityLifecycleCallback onWindowStageCreate windowStage:' + windowStage);
      },
      onWindowStageActive(ability, windowStage) {
        console.log('AbilityLifecycleCallback onWindowStageActive ability:' + ability);
        console.log('AbilityLifecycleCallback onWindowStageActive windowStage:' + windowStage);
      },
      onWindowStageInactive(ability, windowStage) {
        console.log('AbilityLifecycleCallback onWindowStageInactive ability:' + ability);
        console.log('AbilityLifecycleCallback onWindowStageInactive windowStage:' + windowStage);
      },
      onWindowStageDestroy(ability, windowStage) {
        console.log('AbilityLifecycleCallback onWindowStageDestroy ability:' + ability);
        console.log('AbilityLifecycleCallback onWindowStageDestroy windowStage:' + windowStage);
      },
      onAbilityDestroy(ability) {
        console.log('AbilityLifecycleCallback onAbilityDestroy ability:' + ability);
      },
      onAbilityForeground(ability) {
        console.log('AbilityLifecycleCallback onAbilityForeground ability:' + ability);
      },
      onAbilityBackground(ability) {
        console.log('AbilityLifecycleCallback onAbilityBackground ability:' + ability);
      },
      onAbilityContinue(ability) {
        console.log('AbilityLifecycleCallback onAbilityContinue ability:' + ability);
      }
    }
    // 1.通过context属性获取applicationContext
    let applicationContext = this.context.getApplicationContext();
    // 2.通过applicationContext注册监听应用内生命周期
    lifecycleId = applicationContext.on('abilityLifecycle', AbilityLifecycleCallback);
    console.log('registerAbilityLifecycleCallback number: ' + JSON.stringify(lifecycleId));

    globalThis.applicationContext = this.context.getApplicationContext();
    let environmentCallback = {
      onConfigurationUpdated(config){
        console.log('onConfigurationUpdated config:' + JSON.stringify(config));
      },
      onMemoryLevel(level){
        console.log('onMemoryLevel level:' + level);
      }
    }
    // 1.获取applicationContext
    let applicationContext1 = globalThis.applicationContext;
    // 2.通过applicationContext注册监听应用内生命周期
    callbackId = applicationContext1.on('environment', environmentCallback);
    console.log('registerEnvironmentCallback callbackId: ${callbackId}');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    // context为UIAbility实例的AbilityContext 调用eventHub.off()方法取消该事件的订阅
    try {
      this.context.eventHub.off('event1');
    } catch (error) {
      console.log('emit failed with error. Cause: ' + JSON.stringify(error));
    }

    let applicationContext = this.context.getApplicationContext();
    console.log('stage applicationContext: ' + applicationContext);
    applicationContext.off('abilityLifecycle', lifecycleId, (error, data) => {
      console.log('unregisterAbilityLifecycleCallback success, err: ' + JSON.stringify(error));
    });

    // applicationContext.off('environment', callbackId);
    applicationContext.off('environment', callbackId, (error, data) => {
      console.log('unregisterEnvironmentCallback success, err: ' + JSON.stringify(error));
    });

    applicationContext.killAllProcesses();
    // applicationContext.killProcessesBySelf().then((data) => {
    //   console.log('The process running information is:' + JSON.stringify(data));
    // }).catch((error) => {
    //   console.error('error:' + JSON.stringify(error));
    // });
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

    // 获取UIAbility实例的上下文
    let context = this.context;

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

