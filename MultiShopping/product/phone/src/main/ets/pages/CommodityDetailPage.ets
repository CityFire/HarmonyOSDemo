import { Commodity, LocalDataManager } from 'common';
import { CommodityDetail } from 'commoditydetail';
import router from '@ohos.router';

@Entry
@Component
struct CommodityDetailPage {
  @State commodityId: string = '';
  @State info?: Commodity = undefined;
  private localDataManager: LocalDataManager = LocalDataManager.instance();

  aboutToAppear() {
    let params = router.getParams() as Record<string, Object>;
    this.commodityId = params.id as string;
    this.info = this.localDataManager.queryCommodityListById(this.commodityId);
  }

  build() {
    Row() {
      CommodityDetail({
        commodityId: this.commodityId
      })
    }
    .backgroundColor($r('app.color.page_background'))
  }
}