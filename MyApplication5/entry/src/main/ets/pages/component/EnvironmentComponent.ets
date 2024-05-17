// 将设备的语言code存入AppStorage，默认值为en
Environment.EnvProp('languageCode', 'en');

// @StorageProp('languageCode') lang : string = 'en';

// 将设备languageCode存入AppStorage中
Environment.EnvProp('languageCode', 'en');

@Entry
@Component
struct Index {
  @StorageProp('languageCode') languageCode: string = 'en';

  build() {
    Row() {
      Column() {
        // 输出当前设备的languageCode
        Text(this.languageCode)
      }
    }
  }
}

// 使用Environment.EnvProp将设备运行languageCode存入AppStorage中；
Environment.EnvProp('languageCode', 'en');
// 从AppStorage获取单向绑定的languageCode的变量
const lang: SubscribedAbstractProperty<string> = AppStorage.Prop('languageCode');

if (lang.get() === 'zh') {
  console.info('你好');
} else {
  console.info('Hello!');
}