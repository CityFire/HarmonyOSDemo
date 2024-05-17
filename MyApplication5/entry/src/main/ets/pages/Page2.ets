import router from '@ohos.router';

let storage = LocalStorage.GetShared()
@Entry(storage)
@Component
struct Page2 {
  @LocalStorageLink('PropA') propA: number = 2;

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
