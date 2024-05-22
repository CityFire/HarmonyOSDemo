import router from '@ohos.router';
import worker from '@ohos.worker';

let wk = new worker.ThreadWorker("entry/ets/workers/worker.ts");
// 发送消息到worker线程
wk.postMessage("message from main thread.")

// 处理来自worker线程的消息
wk.onmessage = function(message) {
  console.info("message from worker: " + message)

  // 根据业务按需停止worker线程
  wk.terminate()
}

let storage = LocalStorage.GetShared()
@Entry(storage)
@Component
struct Page2 {
  @LocalStorageLink('PropA') propA: number = 2;

  onPageShow() {
    console.info('Page2 onPageShow');
  }

  onPageHide() {
    console.info('Page2 onPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    console.info('Page2 onBackPress');
  }

  // 组件生命周期
  aboutToAppear() {
    console.info('Page2 aboutToAppear');

  }

  // 组件生命周期
  aboutToDisappear() {
    console.info('Page2 aboutToDisappear');
  }

  build() {
    Row() {
      Column() {
        Text(`${this.propA}`)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button("Change propA")
          .onClick(() => {
            this.propA = 100;
          }).margin(10)

        Button("Back Index")
          .onClick(() => {
            console.info(`Succeeded in clicking the 'Back' button.`)
            try {
              // 返回第一页
              router.back()
              console.info('Succeeded in returning to the first page.')
            } catch (err) {
              console.error(`Failed to return to the first page.Code is ${err.code}, message is ${err.message}`)
            }
          })
      }
      .width('100%')
    }
    .height('100%')
  }

}
