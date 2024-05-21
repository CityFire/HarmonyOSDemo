import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import formProvider from '@ohos.app.form.formProvider';
import data from '@ohos.telephony.data';
import fs from '@ohos.file.fs';
import request from '@ohos.request';
import dataStorage from '@ohos.data.storage';

export default class EntryFormAbility extends FormExtensionAbility {
  // 卡片提供方接收创建卡片的通知接口
  // 在添加卡片时，打开一个本地图片并将图片内容传递给卡片页面显示
  onAddForm(want) {
    console.log('FormExtensionAbility onAddForm, want:' + want.abilityName);
    // 在入参want中可以取出卡片的唯一标识：formId

    let formId = want.parameters[formInfo.FormParam.IDENTITY_KEY];
    let isTempCard: boolean = want.parameters[formInfo.FormParam.TEMPORARY_KEY];
    if (isTempCard === false) { // 如果为常态卡片，直接进行信息持久化
      console.info('Not temp card, init db for:' + formId);
      let storeDB = dataStorage.getStorageSync(this.context.filesDir + 'myStore')
      storeDB.putSync('A' + formId, 'false');
      storeDB.putSync('B' + formId, 'false');
      storeDB.flushSync();
    }
    let dataObj1 = {};
    return formBindingData.createFormBindingData(dataObj1);

    // let formId = want.parameters["ohos.extra.param.key.form_identity"];
    // let dataObj1 = {
    //   "formId": formId
    // };
    // let obj1 = formBindingData.createFormBindingData(dataObj1);
    // return obj1;

    /*
    let formId: string = want.parameters[formInfo.FormParam.IDENTITY_KEY];
    // 使用方创建卡片时触发，提供方需要返回卡片数据绑定类
    // Called to return a FormBindingData object.
    let formData = {
      temperature:'11c',
      'time':'11:00'
    };
    return formBindingData.createFormBindingData(formData);
    */

    // 假设在当前卡片应用的tmp目录下有一个本地图片：head.PNG
    let tempDir = this.context.getApplicationContext().tempDir;
    // 打开本地图片并获取其打开后的fd
    let file;
    try {
      file = fs.openSync(tempDir + '/' + 'head.PNG');
    } catch (e) {
      console.error(`openSync failed: ${JSON.stringify(e)}`);
    }
    let formData = {
      'text': 'Image: Bear',
      'imgName': 'imgBear',
      'formImages': {
        'imgBear': file.fd
      },
      'loaded': true
    }
    // 将fd封装在formData中并返回至卡片页面
    return formBindingData.createFormBindingData(formData);
  }

  // 卡片提供方接收临时卡片转常态卡片的通知接口
  onCastToNormalForm(formId) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
    // 使用方将临时卡片转换为常态卡片触发，提供方需要做相应的处理
    console.log('FormExtensionAbility onCastToNormalForm, formId:' + formId);
    // 如果在添加时为临时卡片，则建议转为常态卡片时进行信息持久化
    let storeDB = dataStorage.getStorageSync(this.context.filesDir + 'myStore')
    storeDB.putSync('A' + formId, 'false');
    storeDB.putSync('B' + formId, 'false');
    storeDB.flushSync();
  }

  // 卡片提供方接收更新卡片的通知接口。获取最新数据后调用formProvider的updateForm接口刷新卡片数据。
  onUpdateForm(formId) { // 请求更新的卡片ID
    // Called to notify the form provider to update a specified form.
    // 若卡片支持定时更新/定点更新/卡片使用方主动请求更新功能，则提供方需要重写该方法以支持数据更新
    console.log('FormExtensionAbility onUpdateForm, formId: ${formId}');
    let obj2 = formBindingData.createFormBindingData({
      temperature: '22c',
      time: '22:00'
    });
    formProvider.updateForm(formId, obj2).then((data) => {
      console.log('FormExtensionAbility context updateForm, data: ${data}');
    }).catch((error) => {
      if (error) {
        // 异常分支打印
        console.error('Operation updateForm failed. Cause: ${error}');
        return;
      }
    });

    let storeDB = dataStorage.getStorageSync(this.context.filesDir + 'myStore')
    let stateA = storeDB.getSync('A' + formId, 'false').toString()
    let stateB = storeDB.getSync('B' + formId, 'false').toString()
    // A状态选中则更新textA
    if (stateA === 'true') {
      let formInfo = formBindingData.createFormBindingData({
        'textA': 'AAA'
      })
      formProvider.updateForm(formId, formInfo)
    }
    // B状态选中则更新textB
    if (stateB === 'true') {
      let formInfo = formBindingData.createFormBindingData({
        'textB': 'BBB'
      })
      formProvider.updateForm(formId, formInfo)
    }
  }

  // 卡片提供方接收修改可见性的通知接口
  onChangeFormVisibility(newStatus) { // 请求修改的卡片标识和可见状态
    // Called when the form provider receives form events from the system.
    // 需要配置formVisibleNotify为true，且为系统应用才会回调
    console.log('FormExtensionAbility onChangeFormVisibility, newStatus: ${newStatus}');
    let obj2 = formBindingData.createFormBindingData({
      temperature: '22c',
      time: '22:00'
    });

    for (let key in newStatus) {
      console.log('FormExtensionAbility onChangeFormVisibility, key: ${key}, value= ${newStatus[key]}');
      formProvider.updateForm(key, obj2).then((data) => {
        console.log('FormExtensionAbility context updateForm, data: ${data}');
      }).catch((error) => {
        console.error('Operation updateForm failed. Cause: ${error}');
      });
    }
  }

  // 卡片提供方接收处理卡片事件的通知接口
  // 在卡片页面触发message事件时，下载一个网络图片，并将网络图片内容传递给卡片页面显示
  onFormEvent(formId, message) { // 请求触发事件的卡片标识
    // Called when a specified message event defined by the form provider is triggered.
    // 若卡片支持触发事件，则需要重写该方法并实现对事件的触发
    console.log('FormExtensionAbility onFormEvent, formId:' + formId + ', message:' + message);
    console.info(`FormAbility onEvent, formId = ${formId}, message: ${JSON.stringify(message)}`);
    let formData = {
      'title': 'Title Update.', // 和卡片布局中对应
      'detail': 'Detail Update.', // 和卡片布局中对应
    };
    let formInfo = formBindingData.createFormBindingData(formData)
    formProvider.updateForm(formId, formInfo).then((data) => {
      console.info('FormAbility updateForm success.' + JSON.stringify(data));
    }).catch((error) => {
      console.error('FormAbility updateForm failed: ' + JSON.stringify(error));
    })
    // 注意：FormExtensionAbility在触发生命周期回调时被拉起，仅能在后台存在5秒
    // 建议下载能快速下载完成的小文件，如在5秒内未下载完成，则此次网络图片无法刷新至卡片页面上
    let netFile = 'https://xxxx/xxxx.png'; // 需要在此处使用真实的网络图片下载链接
    let tempDir = this.context.getApplicationContext().tempDir;
    let tmpFile = tempDir + '/file' + Date.now();
    request.downloadFile(this.context, {
      url: netFile, filePath: tmpFile
    }).then((task) => {
      task.on('complete', function callback() {
        console.info('ArkTSCard download complete:' + tmpFile);
        let file;
        try {
          file = fs.openSync(tmpFile);
        } catch (e) {
          console.error(`openSync failed: ${JSON.stringify(e)}`);
        }
        let formData = {
          'text': 'Image: Https',
          'imgName': 'imgHttps',
          'formImages': {
            'imgHttps': file.fd
          },
          'loaded': true
        }
        let formInfo = formBindingData.createFormBindingData(formData)
        formProvider.updateForm(formId, formInfo).then((data) => {
          console.info('FormAbility updateForm success.' + JSON.stringify(data));
        }).catch((error) => {
          console.error('FormAbility updateForm failed: ' + JSON.stringify(error));
        })
      })
      task.on('fail', function callBack(err) {
        console.info('ArkTSCard download task failed. Cause:' + err);
        let formInfo = formBindingData.createFormBindingData({
          'text': '刷新失败'
        })
        formProvider.updateForm(formId, formInfo)
      });
    }).catch((err) => {
      console.error('Failed to request the download. Cause: ' + JSON.stringify(err));
    });

    let storeDB = dataStorage.getStorageSync(this.context.filesDir + 'myStore')
    let msg = JSON.parse(message)
    if (msg.selectA != undefined) {
      console.info('onFormEvent selectA info:' + msg.selectA);
      storeDB.putSync('A' + formId, msg.selectA);
    }
    if (msg.selectB != undefined) {
      console.info('onFormEvent selectB info:' + msg.selectB);
      storeDB.putSync('B' + formId, msg.selectB);
    }
    storeDB.flushSync();
  }

  // 卡片提供方接收销毁卡片的通知接口
  onRemoveForm(formId) { // 请求销毁的卡片标识
    // Called to notify the form provider that a specified form has been destroyed.
    // 当对应的卡片删除时触发的回调，入参是被删除的卡片ID
    console.log('FormExtensionAbility onRemoveForm, formId:' + formId);

    let storeDB = dataStorage.getStorageSync(this.context.filesDir + 'myStore')
    storeDB.deleteSync('A' + formId);
    storeDB.deleteSync('B' + formId);
  }

  // 当系统配置更新时调用
  onConfigurationUpdate(config) { // 表示需要更新的配置信息
    // 当系统配置信息置更新时触发的回调
    console.log('onConfigurationUpdate, config:' + JSON.stringify(config));
  }

  // 卡片提供方接收查询卡片状态通知接口。默认返回卡片初始状态。
  onAcquireFormState(want) {
    // Called to return a {@link FormState} object.
    // 卡片提供方接收查询卡片状态通知接口，默认返回卡片初始状态。
    console.log('FormExtensionAbility onAcquireFormState, want:' + want);
    return formInfo.FormState.READY;
  }
};