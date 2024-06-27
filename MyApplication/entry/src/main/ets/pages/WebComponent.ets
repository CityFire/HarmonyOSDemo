import web_webview from '@ohos.web.webview'

  //在同一page页有两个web组件。在WebComponent新开窗口时，会跳转到NewWebViewComp。
@CustomDialog
struct NewWebViewComp {
  controller?: CustomDialogController
  webviewController1: web_webview.WebviewController = new web_webview.WebviewController()

  build() {
    Column() {
      Web({ src: "", controller: this.webviewController1 })
        .javaScriptAccess(true)
        .multiWindowAccess(false)
        .onWindowExit(() => {
          console.info("NewWebViewComp onWindowExit")
          if (this.controller) {
            this.controller.close()
          }
        })
    }
  }
}

@Entry
@Component
struct WebComponent {
  controller: web_webview.WebviewController = new web_webview.WebviewController()
  dialogController: CustomDialogController | null = null
  build() {
    Column() {
      Web({ src: $rawfile("window.html"), controller: this.controller })
        .javaScriptAccess(true)
      //需要使能multiWindowAccess
        .multiWindowAccess(true)
        .onWindowNew((event) => {
          if (this.dialogController) {
            this.dialogController.close()
          }
          let popController: web_webview.WebviewController = new web_webview.WebviewController()
          this.dialogController = new CustomDialogController({
            builder: NewWebViewComp({webviewController1: popController})
          })
          this.dialogController.open()
          //将新窗口对应WebviewController返回给Web内核。
          //如果不需要打开新窗口请调用event.handler.setWebController接口设置成null。
          //若不调用event.handler.setWebController接口，会造成render进程阻塞。
          event.handler.setWebController(popController)
        })
    }
  }
}