import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import fileIO from '@ohos.fileio';
import commonEventManager from '@ohos.commonEventManager';
import emitter from '@ohos.events.emitter';

let path = '';
let fileType = 'application/pdf';
let fileName = 'TestFile.pdf';
let fileSize; // 需要获取被分享文件的大小
// file open where path is a variable contains the file path.
let fileFd = fileIO.openSync(path, 0o102, 0o666);

let want = {
  // This action is used to implicitly match the application selctor.
  action: 'ohos.want.action.select',
  // This is the custom parameter in the first layer of want
  // which is intended to add info to application selector.
  parameters: {
    // The MIME type of pdf
    "ability.picker.type": "application/pdf",
    "ability.picker.fileNames": [path],
    "ability.picker.fileSizes": [fileSize],
    // This a nested want which will be directly send to the user selected application.
    "ability.want.params.INTENT": {
      "action": "ohos.want.action.sendData",
      "type": "application/pdf",
      "parameters": {
        "keyFd": {"type": "FD", "value": fileFd}
      }
    }
  }
}

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

    // note when keyFd is undefined, app crash will happen.
    if (want["parameters"]["keyFd"] !== undefined) {
      // receive file descriptor
      let fd = want["parameters"]["keyFd"].value;
      // ...
    }

    // 用于保存创建成功的订阅者对象，后续使用其完成订阅及退订的动作
    // let subscriber: commonEventManager.CommonEventSubscriber | null = null;
    // 订阅者信息
    // let subscribeInfo: commonEventManager.CommonEventSubscribeInfo = {
    //   events: ["usual.event.SCREEN_OFF"], // 订阅灭屏公共事件
    // }

    // 创建订阅者回调
    // commonEventManager.createSubscriber(subscribeInfo, (err: Base.BusinessError, data: commonEventManager.CommonEventSubscriber) => {
    //   if (err) {
    //     console.error(`Failed to create subscriber. Code is ${err.code}, message is ${err.message}`);
    //     return;
    //   }
    //   console.info('Succeeded in creating subscriber.');
    //   subscriber = data;
    //   // 订阅公共事件回调
    // })

    // 订阅公共事件回调
    // if (subscriber !== null) {
    //   commonEventManager.subscribe(subscriber, (err: Base.BusinessError, data: commonEventManager.CommonEventData) => {
    //     if (err) {
    //       console.error(`Failed to subscribe common event. Code is ${err.code}, message is ${err.message}`);
    //       return;
    //     }
    //   })
    // } else {
    //   console.error(`Need create subscriber`);
    // }

    // 定义一个eventId为1的事件
    let event = {
      eventId: 1
    };

    // 收到eventId为1的事件后执行该回调
    let callback = (eventData) => {
      console.info('event callback');
    };

    // 订阅eventId为1的事件
    emitter.on(event, callback);

    // 定义一个eventId为1的事件，事件优先级为Low
    let event2 = {
      eventId: 1,
      priority: emitter.EventPriority.LOW
    };

    let eventData = {
      data: {
        "content": "c",
        "id": 1,
        "isEmpty": false,
      }
    };

    // 发送eventId为1的事件，事件内容为eventData
    emitter.emit(event2, eventData);

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
