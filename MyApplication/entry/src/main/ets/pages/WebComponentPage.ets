import web_webview from '@ohos.web.webview';
import router from '@ohos.router';
import call from '@ohos.telephony.call';

@Entry
@Component
struct WebComponentPage {
  @State mode: CacheMode = CacheMode.None;
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  responseResource: WebResourceResponse = new WebResourceResponse()
  // 开发者自定义响应数据
  @State webdata: string = "<!DOCTYPE html>\n" +
  "<html>\n"+
  "<head>\n"+
  "<title>intercept test</title>\n"+
  "</head>\n"+
  "<body>\n"+
  "<h1>intercept test</h1>\n"+
  "</body>\n"+
  "</html>"

  build() {
    Column() {
      Button('setCookie')
        .onClick(() => {
          try {
            web_webview.WebCookieManager.setCookie('https://www.example.com', 'value=test');
          } catch (error) {
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })
      Button('removeCache')
        .onClick(() => {
          try {
            // 设置为true时同时清除rom和ram中的缓存，设置为false时只清除ram中的缓存
            this.webviewController.removeCache(true);
          } catch (error) {
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })
      Web({ src: 'www.example.com', controller: this.webviewController })
        .cacheMode(this.mode)
        .domStorageAccess(true)
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
        .onInterceptRequest((event?: Record<string, WebResourceRequest>): WebResourceResponse => {
          if (!event) {
            return new WebResourceResponse();
          }
          let mRequest: WebResourceRequest = event.request as WebResourceRequest;
          console.info('TAGLee: url:'+ mRequest.getRequestUrl());
          //拦截页面请求，如果加载的url判断与目标url一致则返回自定义加载结果webdata
          if (mRequest.getRequestUrl() === 'https://www.example.com/test.html') {
            // 构造响应数据
            this.responseResource.setResponseData(this.webdata);
            this.responseResource.setResponseEncoding('utf-8');
            this.responseResource.setResponseMimeType('text/html');
            this.responseResource.setResponseCode(200);
            this.responseResource.setReasonMessage('OK');
            return this.responseResource;
          }
          return;
        })
    }
  }
}