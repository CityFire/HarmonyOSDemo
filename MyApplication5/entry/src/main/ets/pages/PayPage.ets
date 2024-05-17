import router from '@ohos.router';
@Entry
@Component
struct PayPage {
  @State message: string = 'Hello 支付世界'

  onPageShow() {
    console.info('Page2 onPageShow');
  }

  onPageHide() {
    console.info('Page onPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    console.info('Page onBackPress');
  }

  // 组件生命周期
  aboutToAppear() {
    console.info('Page aboutToAppear');

  }

  // 组件生命周期
  aboutToDisappear() {
    console.info('Page aboutToDisappear');
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('quit PayPage').onClick(() => {
          router.back();
        }).margin(10)
      }
      .width('100%')
    }
    .height('100%')
  }
}