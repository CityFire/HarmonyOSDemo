import router from '@ohos.router';
@Entry
@Component
struct SharedTransitionDest {

  // page B
  pageTransition() {
    // 定义页面进入时的效果，从右侧滑入，时长为1000ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: 1000 })
      .slide(SlideEffect.Right)
    // 定义页面退出时的效果，向右侧滑出，时长为1200ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ type: RouteType.None, duration: 1200 })
      .slide(SlideEffect.Right)
    // 定义页面进入时的效果，从右侧滑入，时长为1000ms，页面栈发生push操作时该效果才生效
    PageTransitionEnter({ type: RouteType.Push, duration: 1000 })
      .slide(SlideEffect.Right)
    // 定义页面进入时的效果，从左侧滑入，时长为1000ms，页面栈发生pop操作时该效果才生效
    PageTransitionEnter({ type: RouteType.Pop, duration: 1000 })
      .slide(SlideEffect.Left)
    // 定义页面退出时的效果，向左侧滑出，时长为1200ms，页面栈发生push操作时该效果才生效
    PageTransitionExit({ type: RouteType.Push, duration: 1200 })
      .slide(SlideEffect.Left)
    // 定义页面退出时的效果，向右侧滑出，时长为1200ms，页面栈发生pop操作时该效果才生效
    PageTransitionExit({ type: RouteType.Pop, duration: 1200 })
      .slide(SlideEffect.Right)

    // 禁用某页面的页面转场
    // PageTransitionEnter({ type: RouteType.None, duration: 0 })
    // PageTransitionExit({ type: RouteType.None, duration: 0 })
  }

  build() {
    Column() {
      // 配置Static类型的共享元素转场
      Text("SharedTransition dest page")
        .fontSize(16)
        .sharedTransition('text', { duration: 500, curve: Curve.Linear, type: SharedTransitionEffectType.Static })
        .margin({ top: 10 })

      // 配置Exchange类型的共享元素转场，共享元素id为"sharedImage1"
      Image($r('app.media.ic_banner02'))
        .width(350)
        .height(150)
        .sharedTransition('sharedImage1', { duration: 500, curve: Curve.Linear })
        .onClick(() => {
          // 点击图片时路由返回至上一页面
          router.back();
        })
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
  }
}