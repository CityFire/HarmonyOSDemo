import { BreakpointConstants } from 'common/src/main/ets/constants/BreakpointConstants';
import { Home } from 'home';
import { NewProduct } from 'newproduct';
import { ShopCart } from 'shopcart';
import { Personal } from 'personal';
import { buttonInfo, ButtonInfoModel } from '../viewmodel/MainPageData';
import { PageConstants } from '../constants/PageConstants';
import { BreakPointSystem, LocalDataManager, Product, StyleConstants } from 'common';

@Entry
@Component
struct MainPage {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  @StorageLink('IndexPage') currentPageIndex: number = 0;
  @State shoppingCartCache: Product[] = [];
  @State shoppingCartList: Product[] = [];

  private breakpointSystem = new BreakPointSystem();
  private localDataManager: LocalDataManager = LocalDataManager.instance();

  aboutToAppear() {
    this.breakpointSystem.register();
    this.shoppingCartList = this.shoppingCartCache?.length > 0 ? this.shoppingCartCache : [];
    this.queryOrderList();
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister();
  }

  onPageShow() {
    this.queryShopCart();
    this.queryOrderList();
  }

  build() {
    Column() {
      Tabs({
        barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start : BarPosition.End,
        index: this.currentPageIndex
      }) {
        TabContent() {
          Home({

          })
        }
        .tabBar(this.BottomNavigation(buttonInfo[PageConstants.HOME_INDEX]))

        TabContent() {
          NewProduct()
        }
        .tabBar(this.BottomNavigation(buttonInfo[PageConstants.NEW_PRODUCT_INDEX]))

        TabContent() {
          ShopCart()
        }
        .tabBar(this.BottomNavigation(buttonInfo[PageConstants.SHOP_CART_INDEX]))

        TabContent() {
          Personal()
        }
        .tabBar(this.BottomNavigation(buttonInfo[PageConstants.PERSONAL_INDEX]))
      }
      .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.float.bar_width') : StyleConstants.FULL_WIDTH)
      .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      StyleConstants.SIXTY_HEIGHT : $r('app.float.vp_fifty_six'))
      .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .scrollable(false)
      .onChange((index: number) => {
        this.currentPageIndex = index;
        if (index === PageConstants.SHOP_CART_INDEX) {
          this.queryShopCart();
        } else if (index === PageConstants.PERSONAL_INDEX) {
          this.queryOrderList();
        }
      })
    }
    .backgroundColor($r('app.color.page_background'))
  }

  @Builder BottomNavigation(button: ButtonInfoModel) {
    Column({ space: PageConstants.BUTTON_SPACE }) {
      Image(this.currentPageIndex === button.index ? button.selectImg : button.img)
        .objectFit(ImageFit.Contain)
        .width($r('app.float.main_image_size'))
        .height($r('app.float.main_image_size'))
      Text(button.title)
        .fontColor(this.currentPageIndex === button.index ? $r('app.color.focus_color') : Color.Black)
        .opacity(this.currentPageIndex === button.index ? StyleConstants.FULL_OPACITY : StyleConstants.SIXTY_OPACITY)
        .fontWeight(StyleConstants.FONT_WEIGHT_FIVE)
        .textAlign(TextAlign.Center)
        .fontSize($r('app.float.micro_font_size'))
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  queryShopCart() {
    const shoppingData = this.localDataManager.queryShopCart();
    this.shoppingCartList = shoppingData;
    this.shoppingCartCache = shoppingData;
  }

  queryOrderList() {
    const orderList = this.localDataManager.queryOrderList();

  }
}