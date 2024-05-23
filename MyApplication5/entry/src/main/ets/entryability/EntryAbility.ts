import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import AbilityStage from '@ohos.app.ability.AbilityStage';
import Logger from '../Common/utils/Logger';
import common from '@ohos.app.ability.common';

const TAG: string = '[Example].[Entry].[EntryAbility]';

let lifecycleId;
let callbackId;

let fileType = 'application/pdf';
let fileName = 'TestFile.pdf';
let fileFd = -1; // 需要获取被分享文件的FD
let fileSize; // 需要获取被分享文件的大小

/*
{
  "deviceId": "",
  "bundleName": "com.example.myapplication",
  "abilityName": "EntryAbility",
  "moduleName": "entry",
  "uri": "",
  "type": "application/pdf",
  "flags": 0,
  "action": "ohos.want.action.sendData",
  "parameters": {
    "component.startup.newRules": true,
    "keyFd": {
      "type": "FD",
      "value": 36
    },
  "mime-type": "application/pdf",
  "moduleName": "entry",
  "ohos.aafwk.param.callerPid": 3488,
  "ohos.aafwk.param.callerToken": 537379209,
  "ohos.aafwk.param.callerUid": 20010014
},
"entities": []
}
*/

function implicitStartAbility() {
  let context = getContext(this) as common.UIAbilityContext;
  let wantInfo = {
    // This action is used to implicitly match the application selctor.
    action: 'ohos.want.action.select',
    // This is the custom parameter in the first layer of want
    // which is intended to add info to application selector.
    parameters: {
      // The MIME type of pdf
      'ability.picker.type': fileType,
      'ability.picker.fileNames': [fileName],
      'ability.picker.fileSizes': [fileSize],
      // This a nested want which will be directly send to the user selected application.
      'ability.want.params.INTENT': {
        'action': 'ohos.want.action.sendData',
        'type': 'application/pdf',
        'parameters': {
          'keyFd': { 'type': 'FD', 'value': fileFd }
        }
      }
    }
  }
  context.startAbility(wantInfo).then(() => {
    // ...
  }).catch((err) => {
    // ...
  })
}

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

  // 显式
  async explicitStartAbility() {
    try {
      // Explicit want with abilityName specified.
      let want = {
        deviceId: "",
        bundleName: "com.example.myapplication",
        abilityName: "calleeAbility"
      };
      let context = this.context;// getContext(this) as common.UIAbilityContext;
      await context.startAbility(want);
      console.info(`explicit start ability succeed`);
    } catch (error) {
      console.info(`explicit start ability failed with ${error.code}`);
    }
  }

  // 隐式
  async implicitStartAbility() {
    try {
      let want = {
        // uncomment line below if wish to implicitly query only in the specific bundle.
        // bundleName: "com.example.myapplication",
        "action": "ohos.want.action.viewData",
        // entities can be omitted.
        "entities": [ "entity.system.browsable" ],
        "uri": "https://www.test.com:8080/query/student",
        "type": "text/plain"
      }
      let context = this.context;// getContext(this) as common.UIAbilityContext;
      await context.startAbility(want)
      console.info(`explicit start ability succeed`)
    } catch (error) {
      console.info(`explicit start ability failed with ${error.code}`)
    }
  }

  onCreate(want, launchParam) {
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    Logger.info(TAG, 'Ability onCreate');
    AppStorage.SetOrCreate('abilityWant', want);

    /*
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


    // 隐式Want
    // 使用隐式Want描述需要打开一个链接的请求，而不关心通过具体哪个应用打开，系统将匹配声明支持该请求的所有应用
    let wantInfo = {
      // uncomment line below if wish to implicitly query only in the specific bundle.
      // bundleName: 'com.example.myapplication',
      action: 'ohos.want.action.search',
      // entities can be omitted
      entities: [ 'entity.system.browsable' ],
      uri: 'https://www.test.com:8080/query/student',
      type: 'text/plain',
    };

    // 获取eventHub
    let eventhub = this.context.eventHub;
    // 执行订阅操作
    eventhub.on('event1', this.func1);
    eventhub.on('event1', (...data) => {
      // 触发事件，完成相应的业务操作
      Logger.info(TAG, '2. ' + JSON.stringify(data));
    });
    */

    globalThis.entryAblityWant = want;

    globalThis.entryAbilityStr = 'AbilityA'; // AbilityA存放字符串“AbilityA”到globalThis

    globalThis.context = this.context; // AbilityA存放context到globalThis

    /*
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
    */
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    /*
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

    applicationContext.off('environment', callbackId);
    applicationContext.off('environment', callbackId, (error, data) => {
      console.log('unregisterEnvironmentCallback success, err: ' + JSON.stringify(error));
    });
    */

    // applicationContext.killAllProcesses();

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

function getContext(arg0: any): import("../../../../../../../../Library/Huawei/Sdk/openharmony/9/ets/api/application/UIAbilityContext").default {
throw new Error('Function not implemented.');
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

