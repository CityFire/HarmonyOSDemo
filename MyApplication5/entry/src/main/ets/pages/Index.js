import http from '@ohos.net.http';
import image from '@ohos.multimedia.image';
// overBuilder( $$ : { paramA1: string, paramB1: string } );
// 按引用传递参数 全局自定义构建函数
function overBuilder($$) {
    ;
}
// 按值传递参数
function overBuilderV(paramA1) {
    ;
}
function overBuilder3($$) {
        .width(400)
        .height(50)
        .backgroundColor(Color.Green);
}
// 反例： @Styles不支持参数
// @Styles function globalFancy(value: number) {
//   .width(value)
// }
// 全局
function functionName() { }
// 定义在全局的@Styles封装的样式
function globalFancy() {
    
  
        .width(150)
        .height(100)
        .backgroundColor(Color.Pink);
}
// 在组件内
// 组件内@Styles的优先级高于全局@Styles。
// 框架优先找当前组件内的@Styles，如果找不到，则会全局查找。
struct FancyUse extends   {
    constructor() { }
    fancy() {
        
    
            .height(this.heightValue)
            .backgroundColor(Color.Yellow)
            .onClick(() => {
            this.heightValue = 200;
        });
    }
    build() {
        ;
    }
}
// 通过getShared接口获取stage共享的LocalStorage实例
let storage = LocalStorage.GetShared();
struct Index extends   {
    constructor() { }
    // 只有被@Entry装饰的组件才可以调用页面的生命周期
    onPageShow() {
        console.info('Index onPageShow');
    }
    // 只有被@Entry装饰的组件才可以调用页面的生命周期
    onPageHide() {
        console.info('Index onPageHide');
    }
    // 只有被@Entry装饰的组件才可以调用页面的生命周期
    onBackPress() {
        console.info('Index onBackPress');
    }
    // 组件生命周期
    aboutToAppear() {
        console.info('MyComponent aboutToAppear');
    }
    // 组件生命周期
    aboutToDisappear() {
        console.info('MyComponent aboutToDisappear');
    }
    // 用父组件自定义构建函数初始化子组件@BuilderParam装饰的方法
    componentBuilder() {
        ;
        // Text(`Parent builder `)
    }
    // 定义在组件内的@Styles封装的样式
    fancy() {
        
    
            .width(200)
            .height(this.heightValue)
            .backgroundColor(Color.Yellow)
            .onClick(() => {
            this.heightValue = 200;
        });
    }
    loadMoreArticles() {
        this.articleList.push(new Article('007', '加载的新文章', '文章简介内容'));
    }
    build() {
            .width('100%')
            .height('100%')
            .backgroundColor(0xF1F3F5);
    }
    /*
    build() {
  
      Column() {
        ForEach(this.simpleList, (item: string) => {
          ArticleSkeletonView()
            .margin({ top: 20 })
        }, (item: string) => item)
      }
      .padding(20)
      .width('100%')
      .height('100%')
  
  
  
      /*
      Column() {
        Row() {
          Column() {
            // customCounter必须从父组件初始化，因为MyComponent的customCounter成员变量缺少本地初始化；此处，customCounter2可以不做初始化。
            MyComponent_({ customCounter: this.mainCounter, customCounter2: 5 })
            // customCounter2也可以从父组件初始化，父组件初始化的值会覆盖子组件customCounter2的本地初始化的值
            MyComponent_({ customCounter: this.mainCounter, customCounter2: this.mainCounter })
          }
        }
  
        Row() {
          Column() {
            Button('Click to change number')
              .width(288)
              .height(40)
              .margin({ left: 30, top: 12 })
              .fontColor('#FFFFFF，90%')
              .onClick(() => {
                this.mainCounter++
              })
  
            Text(`${this.propA}`)
              .fontSize(50)
              .fontWeight(FontWeight.Bold)
            Button("To Page")
              .onClick(() => {
                router.pushUrl({
                  url:'pages/Page2'
                })
              })
          }
          .width('100%')
          }
        }
      }
      */
    /*
      Row() {
  
        Column() {
          // 此处指定的参数都将在初始渲染时覆盖本地定义的默认值，并不是所有的参数都需要从父组件初始化
          // MyComponent({ count: 1, increaseBy: 2 })
          //   .width(300)
          // MyComponent({ title: new Model('Hello World 2'), count: 7 })
  
          /*
          Child_({value: this.arr[0]})
          Child_({value: this.arr[1]})
          Child_({value: this.arr[2]})
  
          Divider().height(5)
  
          ForEach(this.arr,
            item => {
              Child_({'value': item} as Record<string, number>)
            },
            item => item.toString()
          )
          Text('replace entire arr')
            .fontSize(50)
            .onClick(() => {
              // 两个数组都包含项“3”。
              this.arr = this.arr[0] == 1 ? [3, 4, 5] : [1, 2, 3];
            })
  
          ReaderComp({ title: this.book.title, readIt: this.book.readIt })
          ReaderComp({ title: this.book.title, readIt: this.book.readIt })
  
          Text(`Grant ${this.countDownStartValue} nuggets to play.`).margin(10)
          // 父组件的数据源的修改会同步给子组件
          Button(`+1 - Nuggets in New Game`).onClick(() => {
            this.countDownStartValue += 1;
          }).margin(10)
          // 父组件的修改会同步给子组件
          Button(`-1  - Nuggets in New Game`).onClick(() => {
            this.countDownStartValue -= 1;
          }).margin(10)
  
          CountDownComponent({ count: this.countDownStartValue, constOfOneAttempt: 2 })
        }
        */
    /*
    Column({ space: 10 }) {
      // 使用全局的@Styles封装的样式
      Text('FancyA')
        .globalFancy()
        .fontSize(30)
      // 使用组件内的@Styles封装的样式
      Text('FancyB')
        .fancy()
        .fontSize(30)
    }

    Column() {
      // 创建CustomContainer，在创建CustomContainer时，通过其后紧跟一个大括号“{}”形成尾随闭包
      // 作为传递给子组件CustomContainer @BuilderParam closer: () => void的参数
      CustomContainer({ header: this.text }) {
        Column() {
          specificParam('testA', 'testB')
        }.backgroundColor(Color.Yellow)
        .onClick(() => {
          this.text = 'changeHeader';
        })
      }
    }
    */
    /*
    Column() {
      this.componentBuilder();
      // Child({ customBuilderParamP: this.componentBuilder })
      Child({ customBuilderParamP: this.componentBuilder, customOverBuilderParam3: overBuilder3 })
    }
    * /

    /*
    Row() {
      Column() {
        // 在Parent组件中调用overBuilder的时候，将this.label引用传递给overBuilder
        overBuilder({ paramA1: this.label })
        // overBuilderV(this.label)
        Button('Click me').onClick(() => {
          // 点击“Click me”后，UI从“Hello”刷新为“ArkUI”
          this.label = 'ArkUI';
        })
      }
    }

    Row() {
      Column() {
        // this.showChild为true，创建Child子组件，执行Child aboutToAppear
        if (this.showChild) {
          Child()
        }

        // this.showChild为false，删除Child子组件，执行Child aboutToDisappear
        Button('delete Child').onClick(() => {
          this.showChild = false;
        })

        // push到Page2页面，执行onPageHide
        Button('push to next page')
          .onClick(() => {
            router.pushUrl({ url: 'pages/Page2' })
          })
      }
    }

    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }

    Row() {
      Column({space: 10}) {
        Button("获取网络图片")
          .onClick(() => {
            this.httpRequest()
          })
        Image(this.image).height(100).width(100)
      }
      .width('100%')
      .height('100%')
      .padding(10)
    }
    * */
    // }
    // .height('100%')
    // }
    // 网络图片请求方法
    httpRequest() {
        let httpRequest = http.createHttp();
        httpRequest.request("https://www.apple.com.cn/macbook-pro/images/overview/themes/performance/pro_apps_software_development__b72dk94g8k4i_large_2x.jpg", // 请填写一个具体的网络图片地址
        (error, data) => {
            if (error) {
                console.log("error code: " + error.code + ", msg: " + error.message);
            }
            else {
                let code = data.responseCode;
                // @ts-ignore
                if (ResponseCode.ResponseCode.OK == code) {
                    // @ts-ignore
                    let imageSource = image.createImageSource(data.result);
                    let options = { alphaType: 0,
                        editable: false,
                        pixelFormat: 3,
                        scaleMode: 1,
                        size: { height: 100, width: 100 } }; // 创建图片大小
                    imageSource.createPixelMap(options).then((pixelMap) => {
                        this.image = pixelMap;
                    });
                }
                else {
                    console.log("response code: " + code);
                }
            }
        });
    }
}
class Article {
    constructor(id, title, brief) {
        this.id = id;
        this.title = title;
        this.brief = brief;
    }
}
struct ArticleListView extends   {
    constructor() { }
    loadMoreArticles() {
        this.articleList.push(new Article('007' + $, { count } + 1));
    }
    toString() { }
    ;
}
;
struct ArticleCard extends   {
    constructor() { }
    build() {
            .padding(20)
            .borderRadius(12)
            .backgroundColor('#FFECECEC')
            .height(120)
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);
    }
}
function textArea(width = '100%', height = '100%') {
        .width(width)
        .height(height)
        .backgroundColor('#FFF2F3F4');
}
struct ArticleSkeletonView extends   {
    constructor() { }
    build() {
            .padding(20)
            .borderRadius(12)
            .backgroundColor('#FFECECEC')
            .height(120)
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);
    }
}
struct CountDownComponent extends   {
    constructor() { }
    build() {
        ;
    }
}
struct ReaderComp extends   {
    constructor() { }
    build() {
        ;
    }
}
class Book {
    constructor(title, pages) {
        this.readIt = false;
        this.title = title;
        this.pages = pages;
    }
}
class Model {
    constructor(value) {
        this.value = value;
    }
}
struct MyComponent extends   {
    constructor() { }
    build() {
        ;
    }
}
struct MyComponent_ extends   {
    constructor() { }
    build() {
        ;
    }
}
struct Child_ extends   {
    constructor() { }
    build() {
            .fontSize(50)
            .onClick(() => { this.value++; });
    }
}
function overBuilder2() { }
struct Child extends   {
    constructor() { }
    // 组件生命周期
    aboutToDisappear() {
        console.info('[lifeCycle] Child aboutToDisappear');
    }
    // 组件生命周期
    aboutToAppear() {
        console.info('[lifeCycle] Child aboutToAppear');
        // this.MyGlobalBuilderFunction()
    }
    doNothingBuilder() { }
    ;
    build() {
        ;
    }
    MyGlobalBuilderFunction() { }
}
// xxx.ets
struct CustomContainer extends   {
    constructor() { }
    build() {
        ;
    }
}
function specificParam(label1, label2) {
    ;
}
/*
@Entry
@Component
struct CustomContainerUser {
  @State text: string = 'header';

  build() {
    Column() {
      // 创建CustomContainer，在创建CustomContainer时，通过其后紧跟一个大括号“{}”形成尾随闭包
      // 作为传递给子组件CustomContainer @BuilderParam closer: () => void的参数
      CustomContainer({ header: this.text }) {
        Column() {
          specificParam('testA', 'testB')
        }.backgroundColor(Color.Yellow)
        .onClick(() => {
          this.text = 'changeHeader';
        })
      }
    }
  }
}
*/ 
//# sourceMappingURL=Index.js.map