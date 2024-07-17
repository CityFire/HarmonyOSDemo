
import { LocalDataManager, OrderOperationStatus } from 'common';

@Component
export struct OrderListContent {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';

  private status: OrderOperationStatus = OrderOperationStatus.ALLStatus;
  private localDataManager: LocalDataManager = LocalDataManager.instance();

  build() {

  }
}