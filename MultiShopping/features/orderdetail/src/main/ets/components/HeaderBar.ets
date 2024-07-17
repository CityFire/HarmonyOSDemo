import { StyleConstants } from 'common';

@Component
export struct HeaderBar {
  private title: string | Resource = '';
  private onBack: () => void = () => {};

  build() {
    Flex({ alignItems: ItemAlign.Center }) {
      Button() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.vp_twenty'))
          .height($r('app.float.vp_twenty'))
          .margin({
            left: $r('app.float.title_image_margin_left'),
            right: $r('app.float.vp_eighteen'),
            top: $r('app.float.vp_sixteen'),
            bottom: $r('app.float.vp_sixteen')
          })
      }
      .backgroundColor($r("app.color.zero_alpha_black"))
      .onClick(() => this.onBack())

      if (this.title) {
        Text(this.title)
          .fontSize($r('app.float.bigger_font_size'))
          .margin({ left: $r('app.float.title_text_margin_left') })
      }
    }
    .backgroundColor($r('app.color.page_background'))
    .height($r('app.float.vp_fifty_six'))
    .width(StyleConstants.FULL_WIDTH)
  }
}