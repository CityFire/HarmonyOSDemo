import { Commodity, LocalDataManager, Order } from 'common';
import { OrderDetailList } from 'orderdetail';
import router from '@ohos.router';
@Entry
@Component
struct OrderDetailListPage {
  @Provide orderList: Order[] = [];
  @Provide commodityList: Commodity[] = [];
  @Provide currentTabIndex: number = 0;
  private localDataManager: LocalDataManager = LocalDataManager.instance();

  aboutToAppear() {
    let params = router.getParams() as Record<string, Object>;
    this.currentTabIndex = params.tabIndex as number || 0;
  }

  onPageShow() {
    this.orderList = this.localDataManager.queryOrderList();
    this.commodityList = this.localDataManager.queryCommodityList();
  }

  build() {
    Column() {
      OrderDetailList()
    }
  }
}