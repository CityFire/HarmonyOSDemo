import web_webview from '@ohos.web.webview';
import common from '@ohos.app.ability.common'
import Ability from '@ohos.app.ability.Ability';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import geoLocationManager from '@ohos.geoLocationManager';

let context = getContext(this) as common.UIAbilityContext;
let atManager = abilityAccessCtrl.createAtManager();

try {
  atManager.requestPermissionsFromUser(context, ["ohos.permission.APPROXIMATELY_LOCATION"], (err, data) => {
    let requestInfo: geoLocationManager.LocationRequest = {
      'priority': 0x203,
      'scenario': 0x300,
      'maxAccuracy': 0
    };
    let locationChange = (location: geoLocationManager.Location):void => {
      if (location) {
        console.log('locationChanger: location=' + JSON.stringify(location));
      }
    };
    try {
      geoLocationManager.on('locationChange', requestInfo, locationChange);
      geoLocationManager.off('locationChange', locationChange);
    } catch (err) {
      console.error("errCode:" + err.code + ", errMessage:" + err.message);
    }
  })
} catch (err) {
  console.error("err:", err);
}

@Entry
@Component
struct GeoLocationExample {
  controller: web_webview.WebviewController = new web_webview.WebviewController();

  build() {
    Column() {
      Web({ src:$rawfile('getLocation.html'), controller:this.controller })
        .geolocationAccess(true)
        .onGeolocationShow((event) => { // 地理位置权限申请通知
          AlertDialog.show({
            title: '位置权限请求',
            message: '是否允许获取位置信息',
            primaryButton: {
              value: 'cancel',
              action: () => {
                if (event) {
                  event.geolocation.invoke(event.origin, false, false); // 不允许此站点地理位置权限请求
                }
              }
            },
            secondaryButton: {
              value: 'ok',
              action: () => {
                if (event) {
                  event.geolocation.invoke(event.origin, true, false); // 允许此站点地理位置权限请求
                }
              }
            },
            cancel: () => {
              if (event) {
                event.geolocation.invoke(event.origin, false, false); // 不允许此站点地理位置权限请求
              }
            }
          })
        })
    }
  }
}