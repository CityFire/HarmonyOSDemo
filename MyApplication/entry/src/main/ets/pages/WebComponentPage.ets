import web_webview from '@ohos.web.webview';
import router from '@ohos.router';
import call from '@ohos.telephony.call';

@Entry
@Component
struct WebComponentPage {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();

  build() {
    Column() {
      Web({ src: $rawfile('route.html'), controller: this.webviewController })
        .onUrlLoadIntercept((event) => {
          let url: string = event.data as string;
          if (url.indexOf('native://') === 0) {
            // 跳转其他界面
            router.pushUrl({ url:url.substring(9) })
            return true;
          }
          // 判断链接是否为拨号链接
          if (url.indexOf('tel://') === 0) {
            // 跳转拨号界面
            call.makeCall(url.substring(6), (err) => {
              if (!err) {
                console.info('make call succeeded.');
              } else {
                console.info('make call fail, err is:' + JSON.stringify(err));
              }
            });
            return true;
          }
          return false;
        })
    }
  }
}