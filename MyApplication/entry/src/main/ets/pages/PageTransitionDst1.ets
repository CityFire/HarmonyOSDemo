import router from '@ohos.router'
@Entry
@Component
struct PageTransitionDst1 {
  build() {
    Column() {
      Image($r('app.media.ic_banner01'))
        .width('90%')
        .height('80%')
        .objectFit(ImageFit.Fill)
        .syncLoad(true) // 同步加载图片，使页面出现时图片已经加载完成
        .margin(30)

      Row({ space: 10 }) {
        Button("pushUrl")
          .onClick(() => {
            // 路由到下一页面，push操作
            router.pushUrl({ url: 'pages/PageTransitionSrc1' });
          })
        Button("back")
          .onClick(() => {
            // 返回到上一页面，相当于pop操作
            router.back();
          })
      }.justifyContent(FlexAlign.Center)
    }
    .width("100%").height("100%")
    .alignItems(HorizontalAlign.Center)
  }

  pageTransition() {
    // 定义页面进入时的效果，从右侧滑入，时长为1000ms，页面栈发生push操作时该效果才生效
    PageTransitionEnter({ type: RouteType.Push, duration: 1000 })
      .slide(SlideEffect.Right)
    // 定义页面进入时的效果，从左侧滑入，时长为1000ms，页面栈发生pop操作时该效果才生效
    PageTransitionEnter({ type: RouteType.Pop, duration: 1000 })
      .slide(SlideEffect.Left)
    // 定义页面退出时的效果，向左侧滑出，时长为1000ms，页面栈发生push操作时该效果才生效
    PageTransitionExit({ type: RouteType.Push, duration: 1000 })
      .slide(SlideEffect.Left)
    // 定义页面退出时的效果，向右侧滑出，时长为1000ms，页面栈发生pop操作时该效果才生效
    PageTransitionExit({ type: RouteType.Pop, duration: 1000 })
      .slide(SlideEffect.Right)
  }
}