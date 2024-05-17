PersistentStorage.PersistProp('highScore', '0');

PersistentStorage.DeleteProp('highScore');

PersistentStorage.PersistProps([{ key: 'highScore', defaultValue: '0' }, { key: 'wightScore', defaultValue: '1' }]);

let keys: Array<string> = PersistentStorage.Keys();

PersistentStorage.PersistProp('aProp', 47);

AppStorage.Get('aProp'); // returns 47

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @StorageLink('aProp') aProp: number = 48

  build() {
    Row() {
      Column() {
        Text(this.message)
        // 应用退出时会保存当前结果。重新启动后，会显示上一次的保存结果
        Text(`${this.aProp}`)
          .onClick(() => {
            this.aProp += 1;
          })
      }
    }
  }
}

// 在PersistentStorage之后访问AppStorage中的属性
// 开发者可以先判断是否需要覆盖上一次保存在PersistentStorage中的值，如果需要覆盖，
// 再调用AppStorage的接口进行修改，如果不需要覆盖，则不调用AppStorage的接口。
PersistentStorage.PersistProp('aProp', 48);
if (AppStorage.Get('aProp') > 50) {
  // 如果PersistentStorage存储的值超过50，设置为47
  AppStorage.SetOrCreate('aProp',47);
}