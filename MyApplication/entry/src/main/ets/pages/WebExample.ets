import web_webview from '@ohos.web.webview';

@Entry
@Component
struct WebComponent {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  @State mode: WebDarkMode = WebDarkMode.Auto;
  @State access: boolean = true;

  build() {
    Column() {
      Button('loadUrl')
        .onClick(() => {
          try {
            // 点击按钮时，通过loadUrl，跳转到www.example1.com
            this.webviewController.loadUrl('www.baidu.com');
            // 点击按钮时，通过loadUrl，跳转到local1.html
            // this.webviewController.loadUrl($rawfile("local1.html"));
          } catch (error) {
            console.error('ErrorCode: ${error.code}, Message: ${error.message}');
          }
        })
      // 组件创建时，加载www.example.com
      Web({ src: 'www.baidu.com', controller: this.webviewController})
        .darkMode(this.mode)
        .forceDarkAccess(this.access)
      // 组件创建时，通过$rawfile加载本地文件local.html
      // Web({ src: $rawfile("local.html"), controller: this.webviewController })

      Button('loadData')
        .onClick(() => {
          try {
            // 点击按钮时，通过loadData，加载HTML格式的文本数据
            this.webviewController.loadData(
              "<html><body bgcolor=\"white\">Source:<pre>source</pre></body></html>",
              "text/html",
              "UTF-8"
            );
          } catch (error) {
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })
      // 组件创建时，加载www.example.com
      Web({ src: 'www.baidu.com', controller: this.webviewController })
    }
  }
}

@Component
struct WebComponent1 {
  controller: web_webview.WebviewController = new web_webview.WebviewController()
  build() {
    Column() {
      // 加载本地local.html页面
      Web({ src: $rawfile('local1.html'), controller: this.controller })
        .onShowFileSelector((event) => {
          // 开发者设置要上传的文件路径
          let fileList: Array<string> = [
            'xxx/test.png',
          ]
          if (event) {
            event.result.handleFileList(fileList)
          }
          return true;
        })
    }
  }
}