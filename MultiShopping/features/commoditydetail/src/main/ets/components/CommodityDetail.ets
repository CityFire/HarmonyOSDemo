import { Commodity, StyleConstants } from 'common';
import router from '@ohos.router';
import { barData, BarData } from '../viewmodel/CommodityDetailData';

@Extend(Button) function titleButton() {
  .backgroundColor($r('app.color.zero_alpha_black'))
  .width($r('app.float.title_button_size'))
  .height($r('app.float.title_button_size'))
  .borderRadius($r('app.float.vp_four'))
}

@Component
export struct CommodityDetail {
  @Prop commodityId: string;
  @State info?: Commodity = undefined;

  @State swiperIndex: number = 0;

  aboutToAppear() {

  }

  @Styles backgroundStyle(){
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.vp_sixteen'))
    .padding({
      left: $r('app.float.vp_twelve'),
      right: $r('app.float.vp_twelve'),
      top: $r('app.float.vp_sixteen'),
      bottom: $r('app.float.vp_sixteen')
    })
    .margin({
      top: $r('app.float.vp_twelve'),
      right: $r('app.float.vp_twelve'),
      left: $r('app.float.vp_twelve')
    })
  }

  @Builder CustomSwiper(payload: string[]) {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Swiper() {
        ForEach(payload, (item: string) => {
          Flex({ justifyContent: FlexAlign.Center }) {
            Image($rawfile(item))
              .height(StyleConstants.FULL_HEIGHT)
              .aspectRatio(1)
              .objectFit(ImageFit.Cover)
          }
          .margin({
            left: $r('app.float.swiper_image_margin'),
            right: $r('app.float.swiper_image_margin'),
            top: $r('app.float.vp_twenty'),
            bottom: $r('app.float.vp_twenty')
          })
        }, (item: string) => JSON.stringify(item))
      }
      .onChange((index: number) => this.swiperIndex = index)
      .indicator(false)
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)

      Text(`${this.swiperIndex + 1}/${payload.length}`)
        .fontSize($r('app.float.smaller_font_size'))
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .width($r('app.float.swiper_indicator_text_width'))
        .height($r('app.float.vp_eighteen'))
        .backgroundColor($r('app.color.forty_alpha_black'))
        .borderRadius($r('app.float.swiper_indicator_text_radius'))
        .margin({
          right: $r('app.float.vp_sixteen'),
          bottom: $r('app.float.vp_sixteen')
        })
    }
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor(Color.White)
    .height($r('app.float.swiper_height'))
  }

  @Builder TitleBar(payload: Commodity) {
    Flex({ direction: FlexDirection.Column }) {
      Text() {
        Span($r('app.string.rmb'))
          .fontSize($r('app.float.middle_font_size'))
          .fontColor($r('app.color.focus_color'))
        Span(`${payload.price}`)
          .fontSize($r('app.float.bigger_font_size'))
          .fontColor($r('app.color.focus_color'))
      }

      Row() {
        Text($r('app.string.commodity_desc', payload.title, payload.description))
          .fontColor(Color.Black)
          .fontSize($r('app.float.middle_font_size'))
          .fontWeight(StyleConstants.FONT_WEIGHT_FOUR)
      }
      .width(StyleConstants.FULL_WIDTH)
      .margin({ top: $r('app.float.vp_four') })

      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(barData, (item: BarData) => {
          Row() {
            Image(item.icon !== undefined ? item.icon : '')
              .height($r('app.float.vp_fourteen'))
              .width($r('app.float.vp_fourteen'))
              .margin({ right: $r('app.float.vp_four') })
            Text(item.text)
              .fontSize($r('app.float.micro_font_size'))
              .fontColor($r('app.color.sixty_alpha_black'))
          }
        }, (item: BarData) => JSON.stringify(item))
      }
      .height($r('app.float.vp_fourteen'))
      .margin({ top: $r('app.float.vp_twelve') })
    }
    .backgroundStyle()
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
        Button() {
          Image($r('app.media.ic_back'))
            .height(StyleConstants.FULL_HEIGHT)
            .aspectRatio(1)
        }
        .titleButton()
        .onClick(() => router.back())

        Button() {
          Image($r('app.media.ic_share'))
            .height(StyleConstants.FULL_HEIGHT)
            .aspectRatio(1)
        }
        .titleButton()
      }
      .margin({
        left: $r('app.float.vp_sixteen'),
        top: $r('app.float.vp_sixteen'),
        right: $r('app.float.vp_sixteen')
      })
    }
  }
}