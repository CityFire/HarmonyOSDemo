AppStorage.SetOrCreate('PropA', 47);

let storage: LocalStorage = new LocalStorage({ 'PropA': 17 });
let propA: number = AppStorage.Get('PropA') // propA in AppStorage == 47, propA in LocalStorage == 17
var link1: SubscribedAbstractProperty<number> = AppStorage.Link('PropA'); // link1.get() == 47
var link2: SubscribedAbstractProperty<number> = AppStorage.Link('PropA'); // link2.get() == 47
var prop: SubscribedAbstractProperty<number> = AppStorage.Prop('PropA'); // prop.get() == 47

link1.set(48); // two-way sync: link1.get() == link2.get() == prop.get() == 48
prop.set(1); // one-way sync: prop.get() == 1; but link1.get() == link2.get() == 48
link1.set(49); // two-way sync: link1.get() == link2.get() == prop.get() == 49

storage.get('PropA') // == 17
storage.set('PropA', 101);
storage.get('PropA') // == 101

AppStorage.Get('PropA') // == 49
link1.get() // == 49
link2.get() // == 49
prop.get() // == 49

storage = new LocalStorage({ 'PropA': 48 });

@Entry(storage)
@Component
struct CompA {
  @StorageLink('PropA') storLink: number = 1;
  @LocalStorageLink('PropA') localStorLink: number = 1;

  build() {
    Column({ space: 20 }) {
      Text(`From AppStorage ${this.storLink}`)
        .onClick(() => this.storLink += 1)

      Text(`From LocalStorage ${this.localStorLink}`)
        .onClick(() => this.localStorLink += 1)
    }
  }
}