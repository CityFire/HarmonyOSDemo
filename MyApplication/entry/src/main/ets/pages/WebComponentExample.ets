import web_webview from '@ohos.web.webview';

class testClass {
  constructor() {
  }

  test(): string {
    return 'ArkTS Hello World!';
  }

  test1(): string {
    return "ArkUI Web Component";
  }

  toString(): void {
    console.log('Web Component toString');
  }
}

@Entry
@Component
struct WebComponentExample {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  // 声明需要注册的对象
  @State testObj: testClass = new testClass();

  build() {
    Column() {
      Button('refresh')
        .onClick(() => {
          try {
            this.webviewController.refresh();
          } catch (error) {
            // let e: business_error.BusinessError = error as business_error.BusinessError;
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })

      Button('Register JavaScript To Window')
        .onClick(() => {
          try {
            this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["test", "toString"]);
          } catch (error) {
            // let e: business_error.BusinessError = error as business_error.BusinessError;
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })
      Button('runJavaScript')
        .onClick(() => {
          this.webviewController.runJavaScript('htmlTest()');
        })

      // web组件加载本地index.html页面
      Web({ src: $rawfile('index.html'), controller: this.webviewController })
        // 将对象注入到web端
        .javaScriptProxy({
          object: this.testObj,
          name: "testObjName",
          methodList: ["test"],
          controller: this.webviewController
        })
    }
  }
}