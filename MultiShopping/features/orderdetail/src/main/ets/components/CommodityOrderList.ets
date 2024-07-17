import { Order } from 'common';
import { CommodityOrderItem } from './CommodityOrderItem';
@Component
export struct CommodityOrderList {
  @Consume('orderList') orderList: Order[];

  build() {
    Column() {
      ForEach(this.orderList, (item: Order) => {
        CommodityOrderItem({
          orderData: item
        });
      }, (item: Order, index?: number) => JSON.stringify(item) + index);
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Text($r('app.string.order_list_reward'))
          .fontSize($r('app.float.small_font_size'))
        Text($r('app.string.order_list_standard_reward'))
          .fontSize($r('app.float.small_font_size'))
      }
      .padding({
        top: $r('app.float.vp_twelve'),
        bottom: $r('app.float.vp_twelve')
      })
      .height($r('app.float.order_item_height'))

      Divider()
        .height($r('app.float.vp_one'))
        .backgroundColor($r("app.color.five_alpha_black"))
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Text($r('app.string.order_list_invoices'))
          .fontSize($r('app.float.small_font_size'))
        Row() {
          Text($r('app.string.order_list_personal_invoices'))
            .fontSize($r('app.float.small_font_size'))
          Image($r('app.media.ic_point'))
            .height($r('app.float.vp_twelve'))
            .width($r('app.float.vp_six'))
            .margin({ left: $r('app.float.vp_twelve') })
        }
      }
      .padding({
        top: $r('app.float.vp_twelve'),
        bottom: $r('app.float.vp_twelve')
      })
      .height($r('app.float.order_item_height'))
    }
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.vp_sixteen'))
    .margin({ bottom: $r('app.float.vp_twelve') })
    .padding($r('app.float.vp_sixteen'))
  }
}