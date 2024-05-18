import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import formProvider from '@ohos.app.form.formProvider';

export default class EntryFormAbility extends FormExtensionAbility {
  // 卡片提供方接收创建卡片的通知接口
  onAddForm(want) {
    console.log('FormExtensionAbility onAddForm, want:' + want.abilityName);
    // 在入参want中可以取出卡片的唯一标识：formId
    let formId: string = want.parameters[formInfo.FormParam.IDENTITY_KEY];
    // 使用方创建卡片时触发，提供方需要返回卡片数据绑定类
    // Called to return a FormBindingData object.
    let formData = {
      temperature:'11c',
      'time':'11:00'
    };
    return formBindingData.createFormBindingData(formData);
  }

  // 卡片提供方接收临时卡片转常态卡片的通知接口
  onCastToNormalForm(formId) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
    // 使用方将临时卡片转换为常态卡片触发，提供方需要做相应的处理
    console.log('FormExtensionAbility onCastToNormalForm, formId:' + formId);
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
  onFormEvent(formId, message) { // 请求触发事件的卡片标识
    // Called when a specified message event defined by the form provider is triggered.
    // 若卡片支持触发事件，则需要重写该方法并实现对事件的触发
    console.log('FormExtensionAbility onFormEvent, formId:' + formId + ', message:' + message);
  }

  // 卡片提供方接收销毁卡片的通知接口
  onRemoveForm(formId) { // 请求销毁的卡片标识
    // Called to notify the form provider that a specified form has been destroyed.
    // 当对应的卡片删除时触发的回调，入参是被删除的卡片ID
    console.log('FormExtensionAbility onRemoveForm, formId:' + formId);
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