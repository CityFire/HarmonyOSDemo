class PurchaseItem {
  static NextId: number = 0;
  public id: number;
  public price: number;

  constructor(price: number) {
    this.id = PurchaseItem.NextId++;
    this.price = price;
  }
}

@Component
struct BasketViewer {
  @Link @Watch('onBasketUpdated') shopBasket: PurchaseItem[];
  @State totalPurchase: number = 0;

  updataTotal(): number {
    let total = this.shopBasket.reduce((sum, i) => sum + i.price, 0);
    // 超过100欧元可享受折扣
    if (total >= 100) {
      total = 0.9 * total;
    }
    return total;
  }

  // @Watch 回调
  onBasketUpdated(propName: string): void {
    this.totalPurchase = this.updataTotal();
  }

  build() {
    Column() {
      ForEach(this.shopBasket,
        (item) => {
          Text(`Price: ${item.price.toFixed(2)} €`)
        },
        item => item.id.toString()
      )
      Text(`Total: ${this.totalPurchase.toFixed(2)} €`)
    }
  }
}

@Entry
@Component
struct BasketModifier {
  @State shopBasket: PurchaseItem[] = [];

  build() {
    Column() {
      Button('Add to basket')
        .onClick(() => {
          this.shopBasket.push(new PurchaseItem(Math.round(100 * Math.random())))
        })
      BasketViewer({ shopBasket: $shopBasket })
    }
  }
}


@Component
struct RefreshExample {
  @State isRefreshing: boolean = false
  @State counter: number = 0

  build() {
    Column() {
      Text('Pull Down and isRefreshing: ' + this.isRefreshing)
        .fontSize(30)
        .margin(10)

      Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
        Text('Pull Down and refresh: ' + this.counter)
          .fontSize(30)
          .margin(10)
      }
      .onStateChange((refreshStatus: RefreshStatus) => {
        console.info('Refresh onStateChange state is ' + refreshStatus)
      })
    }
  }
}