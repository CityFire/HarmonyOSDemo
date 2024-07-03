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
  ports: web_webview.WebMessagePort[];
  @State sendFromEts: string = 'Send this message from ets to HTML';
  @State receivedFromHtml: string = 'Display received message send from HTML';

  build() {
    Column() {
      // 展示接收到的来自HTML的内容
      Text(this.receivedFromHtml)
      // 输入框的内容发送到html
      TextInput({placeholder: 'Send this message from ets to HTML'})
        .onChange((value: string) => {
          this.sendFromEts = value;
        })
      Button('postMessage')
        .onClick(() => {
          try {
            // 1、创建两个消息端口。
            this.ports = this.webviewController.createWebMessagePorts();
            // 2、在应用侧的消息端口(如端口1)上注册回调事件。
            this.ports[1].onMessageEvent((result: web_webview.WebMessage) => {
              let msg = 'Got msg from HTML:';
              if (typeof(result) === 'string') {
                console.info(`received string message from html5, string is: ${result}`);
                msg = msg + result;
              } else if (typeof(result) === 'object') {
                if (result instanceof ArrayBuffer) {
                  console.info(`received arraybuffer from html5, length is: ${result.byteLength}`);
                  msg = msg + 'lenght is ' + result.byteLength;
                } else {
                  console.info('not support');
                }
              } else {
                console.info('not support');
              }
              this.receivedFromHtml = msg;
            })
            // 3、将另一个消息端口(如端口0)发送到HTML侧，由HTML侧保存并使用。
            this.webviewController.postMessage('__init_port__', [this.ports[0]], '*');
          }catch (error) {
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })

      // 4、使用应用侧的端口给另一个已经发送到html的端口发送消息。
      Button('SendDataToHTML')
        .onClick(() => {
          try {
            if (this.ports && this.ports[1]) {
              this.ports[1].postMessageEvent(this.sendFromEts);
            } else {
              console.error(`ports is null, Please initialize first`);
            }
          } catch (error) {
            console.error(`ErrorCode: ${error.code}, Message: ${error.message}`);
          }
        })

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

      // 如果存在历史记录，accessBackward()接口会返回true。同样，您可以使用accessForward()接口检查是否存在前进的历史记录。如果您不执行检查，那么当用户浏览到历史记录的末尾时，调用forward()和backward()接口时将不执行任何操作。
      Button('loadData')
        .onClick(() => {
          if (this.webviewController.accessBackward()) {
            this.webviewController.backward();
            return true;
          }
        })

      Web({ src: $rawfile('MessagePort.html'), controller: this.webviewController })

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