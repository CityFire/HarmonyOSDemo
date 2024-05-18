import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import router from '@ohos.router';
import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import formProvider from '@ohos.app.form.formProvider';

let selectPage = "";
let currentWindowStage = null;

function FunCCall(data) {
  // 获取call事件中传递的所有参数
  console.log('FunCCall param:' + JSON.stringify(data.readString()));
  router.pushUrl({
    url: 'pages/FunC',
  }).then(() => {
    console.info('Succeeded in jumping to the FunC page.')
  }).catch((err) => {
    console.error(`Failed to jump to the FunC page.Code is ${err.code}, message is ${err.message}`)
  })
  return null;
}

function FunDCall(data) {
  console.log('FunDCall param:' + JSON.stringify(data.readString()));
  router.pushUrl({
    url: 'pages/FunD',
  }).then(() => {
    console.info('Succeeded in jumping to the FunD page.')
  }).catch((err) => {
    console.error(`Failed to jump to the FunD page.Code is ${err.code}, message is ${err.message}`)
  })
  return null;
}

export default class CameraAbility extends UIAbility {
  // 如果UIAbility第一次启动，在收到Router事件后会触发onCreate生命周期回调
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // 获取router事件中传递的targetPage参数
    console.info("onCreate want:" + JSON.stringify(want));
    
    if (want.parameters[formInfo.FormParam.IDENTITY_KEY] !== undefined) {
      let curFormId = want.parameters[formInfo.FormParam.IDENTITY_KEY];
      let message = JSON.parse(want.parameters.params).detail;
      console.info(`UpdateForm formId: ${curFormId}, message: ${message}`);
      let formData = {
        "detail": message + ': onCreate UIAbility.', // 和卡片布局中对应
      };
      let formMsg = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(curFormId, formMsg).then((data) => {
        console.info('updateForm success.' + JSON.stringify(data));
      }).catch((error) => {
        console.error('updateForm failed:' + JSON.stringify(error));
      })
    }
    
    if (want.parameters.params !== undefined) {
      let params = JSON.parse(want.parameters.params);
      console.info("onCreate router targetPage:" + params.targetPage);
      selectPage = params.targetPage;
    }

    // 如果UIAbility第一次启动，在收到call事件后会触发onCreate生命周期回调
    try {
      // 监听call事件所需的方法
      this.callee.on('funC', FunCCall);
      this.callee.on('FunD', FunDCall);
    } catch (error) {
      console.log('register failed with error. Cause: ' + JSON.stringify(error));
    }
  }

  // 如果UIAbility已在后台运行，在收到Router事件后会触发onNewWant生命周期回调
  onNewWant(want, launchParam) {
    console.info("onNewWant want:" + JSON.stringify(want));

    if (want.parameters[formInfo.FormParam.IDENTITY_KEY] !== undefined) {
      let curFormId = want.parameters[formInfo.FormParam.IDENTITY_KEY];
      let message = JSON.parse(want.parameters.params).detail;
      console.info(`UpdateForm formId: ${curFormId}, message: ${message}`);
      let formData = {
        "detail": message + ': onNewWant UIAbility.', // 和卡片布局中对应
      };
      let formMsg = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(curFormId, formMsg).then((data) => {
        console.info('updateForm success.' + JSON.stringify(data));
      }).catch((error) => {
        console.error('updateForm failed:' + JSON.stringify(error));
      })
    }

    if (want.parameters.params !== undefined) {
      let params = JSON.parse(want.parameters.params);
      console.info("onNewWant router targetPage:" + params.targetPage);
      selectPage = params.targetPage;
    }
    if (currentWindowStage != null) {
      this.onWindowStageCreate(currentWindowStage);
    }
  }

  // 进程退出时，解除监听
  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    try {
      this.callee.off('funC');
      this.callee.off('funD');
    } catch (error) {
      console.log('unregister failed with error. Cause: ' + JSON.stringify(error));
    }
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    let targetPage;
    // 根据传递的targetPage不同，选择拉起不同的页面
    switch (selectPage) {
      case 'funA':
        targetPage = 'pages/FunA';
        break;
      case 'funB':
        targetPage = 'pages/FunB';
        break;
      default:
        targetPage = 'pages/Index';
    }
    if (currentWindowStage === null) {
      currentWindowStage = windowStage;
    }

    windowStage.loadContent(targetPage, (err, data) => {
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
