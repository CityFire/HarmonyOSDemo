
import { BreakpointConstants, Commodity, CommodityList, EmptyComponent, GridConstants, LocalDataManager, Logger, OrderOperationStatus, StyleConstants } from 'common';
import { Order, updateOrderProps } from 'common/src/main/ets/viewmodel/OrderModel';
import Prompt from '@system.prompt';
import promptAction from '@ohos.promptAction';
import { OrderDetailConstants } from '../constants/OrderDetailConstants';
import { payEnum, statusEnum } from '../viewmodel/OrderData';
import { CommodityOrderItem } from './CommodityOrderItem';
import router from '@ohos.router';

@Component
export struct OrderListContent {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  @Consume orderList: Order[];  // OrderDetailListPage提供的
  @Consume commodityList: Commodity[];

  private status: OrderOperationStatus = OrderOperationStatus.ALLStatus;
  private localDataManager: LocalDataManager = LocalDataManager.instance();

  paymentHandler(orderId: string, status: number, msg: string | Resource) {
    let orderIdStatus: updateOrderProps = { orderId, status }
    this.orderList = this.localDataManager.updateOrder(orderIdStatus);
    promptAction.showToast({ message: `${msg}${OrderDetailConstants.SUCCESS}` });
  }

  build() {
    Column() {
      Scroll() {
        GridRow({
          columns: { // 一行分为几列
            sm: GridConstants.COLUMN_FOUR,
            md: GridConstants.COLUMN_EIGHT,
            lg: GridConstants.COLUMN_TWELVE
          }
        }) {
          GridCol({
            span: { // 占几列
              sm: GridConstants.SPAN_FOUR,
              md: GridConstants.SPAN_EIGHT,
              lg: GridConstants.SPAN_EIGHT
            },
            offset: { // 偏移列数
              lg: GridConstants.OFFSET_TWO
            }
          }) {
            Column() {
              if (this.status === OrderOperationStatus.ALLStatus || this.orderList.filter(item => item.status === this.status).length > 0) {
                List() {
                  ForEach(this.status === OrderOperationStatus.ALLStatus ? this.orderList : this.orderList.filter(item => item.status === this.status), (info: Order) => {
                    ListItem() {
                      Flex({ direction: FlexDirection.Column }) {
                        Flex({ justifyContent: FlexAlign.End }) {
                          Text(info.status !== undefined ? statusEnum[info.status] : '')
                            .fontSize($r('app.float.smaller_font_size'))
                            .fontColor($r('app.color.focus_color'))
                        }
                        .height($r('app.float.vp_sixteen'))
                        .margin({
                          top: $r('app.float.vp_four'),
                          bottom: $r('app.float.vp_twelve')
                        })
                        .width(StyleConstants.FULL_WIDTH)

                        Divider()
                          .width(StyleConstants.FULL_WIDTH)
                          .height($r('app.float.vp_one'))
                          .backgroundColor($r("app.color.five_alpha_black"))
                          .margin({
                            bottom: $r('app.float.vp_twelve')
                          })

                        CommodityOrderItem({ orderData: info })
                        Text($r('app.string.order_id', info.orderId))
                          .fontSize($r('app.float.small_font_size'))
                          .fontColor($r("app.color.sixty_alpha_black"))
                          .width(StyleConstants.FULL_WIDTH)
                          .margin({
                            top: $r('app.float.vp_twenty_four')
                          })
                        Divider()
                          .width(StyleConstants.FULL_WIDTH)
                          .height($r('app.float.vp_one'))
                          .backgroundColor($r("app.color.five_alpha_black"))
                          .margin({
                            top: $r('app.float.vp_twelve')
                          })
                        Flex({
                          direction: FlexDirection.Column,
                          alignItems: ItemAlign.End,
                          justifyContent: FlexAlign.End
                        }) {
                          Text($r('app.string.goods_count', info.count,
                              info.status !== undefined ? payEnum[info.status] : '', info.price * info.count))
                            .fontSize($r('app.float.small_font_size'))
                            .margin({
                              bottom: $r('app.float.vp_sixteen')
                            })
                          Flex({ justifyContent: FlexAlign.End }) {
                            if (info.status === OrderOperationStatus.UN_PAY) {
                              Button($r('app.string.pay_now'))
                                .height($r('app.float.order_list_button_height'))
                                .fontColor(Color.White)
                                .backgroundColor($r('app.color.focus_color'))
                                .borderRadius($r('app.float.vp_fourteen'))
                                .onClick(() => {
                                  this.paymentHandler(info.orderId !== undefined ? info.orderId : '',
                                    OrderOperationStatus.DELIVERED, OrderDetailConstants.ORDER_PAY);
                                })
                            } else if (info.status === OrderOperationStatus.DELIVERED) {
                              Button($r('app.string.confirm_harvest'))
                                .height($r('app.float.order_list_button_height'))
                                .fontColor(Color.White)
                                .backgroundColor($r('app.color.focus_color'))
                                .borderRadius($r('app.float.vp_fourteen'))
                                .onClick(() => {
                                  this.paymentHandler(info.orderId !== undefined ? info.orderId : '',
                                    OrderOperationStatus.RECEIPT, OrderDetailConstants.ORDER_CONFIRM);
                                })
                            }
                          }
                          .width(StyleConstants.FULL_WIDTH)
                        }
                        .height($r('app.float.order_list_item_height'))
                        .padding({
                          top: $r('app.float.vp_sixteen')
                        })
                      }
                      .onClick(() => {
                        router.pushUrl({
                          url: OrderDetailConstants.PAY_ORDER_PAGE_URL,
                          params: {
                            order: info
                          }
                        }).catch((err: Error) => {
                          Logger.error(JSON.stringify(err));
                        });
                      })
                      .width(StyleConstants.FULL_WIDTH)
                      .backgroundColor(Color.White)
                      .borderRadius($r('app.float.vp_sixteen'))
                      .margin({
                        bottom: $r('app.float.vp_twelve')
                      })
                      .padding({
                        left: $r('app.float.vp_twelve'),
                        right: $r('app.float.vp_twelve'),
                        top: $r('app.float.vp_sixteen'),
                        bottom: $r('app.float.vp_sixteen')
                      })
                    }
                  })
                }
              } else {
                Column() {
                  EmptyComponent({ outerHeight: StyleConstants.FIFTY_HEIGHT })
                }
                .width(StyleConstants.FULL_WIDTH)
              }
              Text($r('app.string.guess_like'))
                .fontSize($r('app.float.middle_font_size'))
                .margin({
                  top: $r('app.float.vp_eight'),
                  bottom: $r('app.float.vp_twelve'),
                  left: $r('app.float.vp_sixteen')
                })
                .width(StyleConstants.FULL_WIDTH)
                .textAlign(TextAlign.Start)

              CommodityList({
                commodityList: $commodityList,
                column: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
                StyleConstants.DISPLAY_TWO : StyleConstants.DISPLAY_THREE,
                onClickItem: (data: Commodity) => {
                  router.pushUrl({
                    url: OrderDetailConstants.COMMODITY_DETAIL_PAGE_URL,
                    params: {
                      id: data.id
                    }
                  }).catch((err: Error) => {
                    Logger.error(JSON.stringify(err));
                  });
                }
              })
            }
          }
        }
      }
      .scrollBar(BarState.Off)
    }
    .margin({
      top: $r('app.float.vp_four'),
      left: $r('app.float.vp_twelve'),
      right: $r('app.float.vp_twelve')
    })
  }
}