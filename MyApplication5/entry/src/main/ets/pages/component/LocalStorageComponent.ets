
let storage = new LocalStorage({ 'PropA': 47 });// 创建新实例并使用给定对象初始化
// 调用link（api9以上）接口构造'PropA'的双向同步数据，linkToPropA 是全局变量
let linkToPropA = storage.link('PropA');
let propA = storage.get('PropA') // propA == 47
let link1 = storage.link('PropA'); // link1.get() == 47
let link2 = storage.link('PropA'); // link2.get() == 47
let prop = storage.prop('PropA'); // prop.get() = 47
link1.set(48); // two-way sync: link1.get() == link2.get() == prop.get() == 48
prop.set(1); // one-way sync: prop.get()=1; but link1.get() == link2.get() == 48
link1.set(49); // two-way sync: link1.get() == link2.get() == prop.get() == 49


@Component
struct Child {
  // @LocalStorageLink变量装饰器与LocalStorage中的'PropA'属性建立双向绑定
  @LocalStorageLink('PropA') storLink2: number = 1;

  // @LocalStorageProp变量装饰器与LocalStorage中的'PropA'属性建立单向绑定
  @LocalStorageProp('PropA') storProp2: number = 2;

  build() {
    Button(`Child from LocalStorage ${this.storLink2}`)
      // 更改将同步至LocalStorage中的'PropA'以及Parent.storLink1
      .onClick(() => this.storLink2 += 1)

    Column({ space: 15 }) {
      // 当CompA改变时，当前storProp2不会改变，显示47
      Text(`Parent from LocalStorage ${this.storProp2}`)
    }
  }
}

// 使LocalStorage可从@Component组件访问
@Entry(storage)
@Component
struct CompA {
  // @LocalStorageLink('PropA')在CompA自定义组件中创建'PropA'的双向同步数据，初始值为47，因为在构造LocalStorage已经给“PropA”设置47
  @LocalStorageLink('PropA') storLink: number = 1;

  // @LocalStorageLink变量装饰器与LocalStorage中的'PropA'属性建立双向绑定
  @LocalStorageLink('PropA') storLink1: number = 1;

  // @LocalStorageProp变量装饰器与LocalStorage中的'PropA'属性建立单向绑定
  @LocalStorageProp('PropA') storProp1: number = 1;

  build() {
    Column({ space: 15 }) {

      Text(`incr @LocalStorageLink variable`)
        // 点击“incr @LocalStorageLink variable”，this.storLink加1，改变同步回storage，全局变量linkToPropA也会同步改变

        .onClick(() => this.storLink += 1)

      // 并不建议在组件内使用全局变量linkToPropA.get()，因为可能会有生命周期不同引起的错误。
      Text(`@LocalStorageLink: ${this.storLink} - linkToPropA: ${linkToPropA.get()}`)

      Button(`Parent from LocalStorage ${this.storLink1}`) // initial value from LocalStorage will be 47, because 'PropA' initialized already
        .onClick(() => this.storLink1 += 1)
      // @Component子组件自动获得对CompA LocalStorage实例的访问权限。
      Child()

      Column({ space: 15 }) {
        // 点击后从47开始加1，只改变当前组件显示的storProp1，不会同步到LocalStorage中
        Button(`Parent from LocalStorage ${this.storProp1}`)
          .onClick(() => this.storProp1 += 1)
        Child()
      }
    }
  }
}