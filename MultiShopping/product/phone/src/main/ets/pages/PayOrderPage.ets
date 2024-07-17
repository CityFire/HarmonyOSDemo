import { LocalDataManager, Order } from 'common';
import router from '@ohos.router';
import { PayOrder } from 'orderdetail';

@Entry
@Component
struct PayOrderPage {
  @Provide('orderList') data: Order[] = [];
  @State totalPrice: number = 0;
  private localDataManager: LocalDataManager = LocalDataManager.instance();

  aboutToAppear() {
    let params = router.getParams() as Record<string, Object>;
    let order: Order = params.order as Order;
    let orderIds: string[] = params.orderIds as string[];
    if (order) {
      this.data = [order];
    }
    if (orderIds) {
      const orders = this.localDataManager.queryOrderList();
      this.data = orders.filter(order => orderIds.includes(order.orderId));
    }
    this.totalPrice = this.data.reduce((sum, i) => {
      return sum + i.price * i.count;
    }, 0)
  }

  build() {
    Column() {
      PayOrder({
        totalPrice: $totalPrice
      })
    }
  }
}