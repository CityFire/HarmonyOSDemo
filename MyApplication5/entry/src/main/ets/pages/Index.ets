import http from '@ohos.net.http'
import image from '@ohos.multimedia.image';
import router from '@ohos.router';
import CommonConstants from '../Common/constants/CommonConstants';
import Logger from '../Common/utils/Logger';
import common from '@ohos.app.ability.common';

const RESULT_CODE: number = 1001;

// overBuilder( $$ : { paramA1: string, paramB1: string } );
// 按引用传递参数 全局自定义构建函数
@Builder function overBuilder($$: { paramA1: string }) {
  Row() {
    Text(`UseStateVarByReference: ${$$.paramA1 }`)
  }
}

// 按值传递参数
@Builder function overBuilderV(paramA1: string) {
  Row() {
    Text(`UseStateVarByValue: ${paramA1} `)
  }
}


@Builder function overBuilder3($$ : {label: string }) {
  Text($$.label)
    .width(400)
    .height(50)
    .backgroundColor(Color.Green)
}

// 反例： @Styles不支持参数
// @Styles function globalFancy(value: number) {
//   .width(value)
// }

// 全局
@Styles function functionName() {  }

// 定义在全局的@Styles封装的样式
@Styles function globalFancy  () {
  .width(150)
  .height(100)
  .backgroundColor(Color.Pink)
}

// 在组件内
// 组件内@Styles的优先级高于全局@Styles。
// 框架优先找当前组件内的@Styles，如果找不到，则会全局查找。
@Component
struct FancyUse {
  @State heightValue: number = 100
  @Styles fancy() {
    .height(this.heightValue)
    .backgroundColor(Color.Yellow)
    .onClick(() => {
      this.heightValue = 200
    })
  }

  build() {
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
  }
}

// 通过getShared接口获取stage共享的LocalStorage实例
let storage = LocalStorage.GetShared()

let entryAbilityWant;

@Entry(storage)
@Component
struct Index {
  @State message: string = 'Hello World';
  @State label: string = 'Hello Parent';
  @State text: string = 'header';

  // 先创建一个PixelMap状态变量用于接收网络图片
  @State image: PixelMap = undefined
  @State showChild: Boolean = true;
  @State heightValue: number = 100
  @State countDownStartValue: number = 10;

  @State mainCounter: number = 10;

  @State arr: number[] = [1,2,3];

  @State book: Book = new Book('100 secrets of C++', 765);

  // can access LocalStorage instance using
  // @LocalStorageLink/Prop decorated variables
  @LocalStorageLink('PropA') propA: number = 1;

  private context = getContext(this) as common.UIAbilityContext;

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    console.info('Index onPageShow');

    let ctx = globalThis.context; // 页面中从globalThis中取出context并使用
    let permissions = ['com.example.permission']
    ctx.requestPermissionsFromUser(permissions,(result) => {
      console.info('requestPermissionsFromUser result:' + JSON.stringify(result));
    });
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

    entryAbilityWant = globalThis.entryAbilityWant;
  }

  // 组件生命周期
  aboutToDisappear() {
    console.info('MyComponent aboutToDisappear');
  }

  // 用父组件自定义构建函数初始化子组件@BuilderParam装饰的方法
  @Builder componentBuilder() {
    Text(`${this.label}`)
    // Text(`Parent builder `)
  }

  // 定义在组件内的@Styles封装的样式
  @Styles fancy() {
    .width(200)
    .height(this.heightValue)
    .backgroundColor(Color.Yellow)
    .onClick(() => {
      this.heightValue = 200
    })
  }

  // 在启动指定实例模式的UIAbility时，给每一个UIAbility实例配置一个独立的Key标识
  // 例如在文档使用场景中，可以用文档路径作为Key标识
  getInstance() {
  // ...
    return 'FuncAbility';
  }

  startAbilityTest() {
    let want = { // Want参数信息
      deviceId: '', // deviceId为空表示本设备
      // 如果希望隐式仅在特定的捆绑包中进行查询，请取消下面的注释。
      // bundleName: 'com.example.myapplication',
      // abilityName: 'FuncAbility',
      // moduleName: 'entry', // moduleName非必选
      action: 'ohos.want.action.viewData',
      // entities可以被省略。
      entities: ['entity.system.default'],
      parameters: { // 自定义信息
        info: '来自EntryAbility Index页面',
        instanceKey: this.getInstance(),
      },
    };
    // context为调用方UIAbility的AbilityContext
    // let context = getContext(this) as common.UIAbilityContext;
    // this.context.startAbility(want).then(() => {
    //   // ...
    //   console.info('startAbility success');
    // }).catch((err) => {
    //   // ...
    //   console.error('startAbility err' + err);
    // })

    this.context.startAbilityForResult(want).then((data) => {
      //
      if (data?.resultCode === RESULT_CODE) {
        // 解析被调用方UIAbility返回的信息
        let info = data.want?.parameters?.info;
        console.info('startAbility parse success info:' + info);
      }
    }).catch((err) => {
      console.error('startAbility err' + err);
    })
  }

  eventHubFunc() {
    // 不带参数触发自定义“event1”事件
    this.context.eventHub.emit('event1');
    // 带1个参数触发自定义“event1”事件
    this.context.eventHub.emit('event1', 1);
    // 带2个参数触发自定义“event1”事件
    this.context.eventHub.emit('event1', 2, 'test');
    // 开发者可以根据实际的业务场景设计事件传递的参数
  }

  build() {

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


    // Row() {

      // Column() {
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
      */

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
      */

      Row() {
        Column() {
          // this.showChild为true，创建Child子组件，执行Child aboutToAppear
          // if (this.showChild) {
          //   Child()
          // }

          // this.showChild为false，删除Child子组件，执行Child aboutToDisappear
          // Button('delete Child').onClick(() => {
          //   this.showChild = false;
          // }).margin(10)

          Button('start FuncAbility').onClick(() => {
            this.startAbilityTest();
          }).margin(10)


          // push到Page2页面，执行onPageHide
          Button('push to next page')
            .onClick(() => {
              console.info(`Succeeded in clicking the 'Next' button.`)
              // 跳转到第二页
              router.pushUrl({
                url: CommonConstants.SECOND_URL,
                params: { src: CommonConstants.SECOND_SRC_MSG }
              }).then(() => {
                console.info('Succeeded in jumping to the second page.')
              }).catch((err) => {
                console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
                Logger.info('[Index]', 'IndexPage push error' + JSON.stringify(err));
              })
            })
        }.width('100%')
      }

      /*
      Row() {
        Column() {
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
      }
      */

      /*
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
      */
    // }
    .height('100%')
  }

  /*
  // 网络图片请求方法
  private httpRequest() {
    let httpRequest = http.createHttp()

    httpRequest.request(
      "https://www.apple.com.cn/macbook-pro/images/overview/themes/performance/pro_apps_software_development__b72dk94g8k4i_large_2x.jpg",   // 请填写一个具体的网络图片地址
      (error, data) => {
        if (error) {
          console.log("error code: " + error.code + ", msg: " + error.message)
        } else {
          let code = data.responseCode
          // @ts-ignore
          if (ResponseCode.ResponseCode.OK == code) {
            // @ts-ignore
            let imageSource = image.createImageSource(data.result)
            let options = {alphaType: 0,                     // 透明度
              editable: false,                  // 是否可编辑
              pixelFormat: 3,                   // 像素格式
              scaleMode: 1,                     // 缩略值
              size: {height: 100, width: 100}}  // 创建图片大小
            imageSource.createPixelMap(options).then((pixelMap) => {
              this.image = pixelMap
            })
          } else {
            console.log("response code: " + code)
          }
        }
      }
    )
  }
  */
}


@Component
struct CountDownComponent {
  @Prop count: number;
  constOfOneAttempt: number = 1;

  build() {
    Column() {
      if (this.count > 0) {
        Text(`You have ${this.count} Nuggets left`).margin(10)
      } else {
        Text('Game over!').margin(10)
      }
      // @Prop装饰的变量不会同步给父组件
      Button(`Try again`).onClick(() => {
        this.count -= this.constOfOneAttempt;
      }).margin(10)
    }
  }
}

@Component
struct ReaderComp {
  @Prop title: string;
  @Prop readIt: boolean;

  build() {
    Row() {
      Text(this.title)
      Text(`... ${this.readIt ? 'I have read' : 'I have not read it'}`)
        .onClick(() => this.readIt = true)
    }
  }
}

class Book {
  public title: string;
  public pages: number;
  public readIt: Boolean = false;

  constructor(title: string, pages: number) {
    this.title = title;
    this.pages = pages;
  }
}

class Model {
  public value: string;

  constructor(value: string) {
    this.value = value;
  }
}

@Component
struct MyComponent {
  @State title: Model = new Model('Hello World');
  @State count: number = 0;
  private increaseBy: number = 1;

  build() {
    Column() {
      Text(`${this.title.value}`)
        .margin(10)
      Button(`Click to change title`)
        .onClick(() => {
          // @State变量的更新将触发上面的Text组件内容更新
          this.title.value = this.title.value === 'Hello ArkUI' ? 'Hello World' : 'Hello ArkUI';
        })
        .width(300)
        .margin(10)

      Button(`Click to increase count = ${this.count}`)
        .onClick(() => {
          // @State变量的更新将触发该Button组件的内容更新
          this.count += this.increaseBy;
        })
        .width(300)
        .margin(10)
    }
  }
}


@Component
struct MyComponent_ {
  @Prop customCounter: number;
  @Prop customCounter2: number;

  build() {
    Column() {
      Row() {
        Text(`From Main: ${this.customCounter}`).fontColor('#ff6b6565').margin({ left: -110, top: 12 })
      }

      Row() {
        Button('Click to change locally !')
          .width(288)
          .height(40)
          .margin({ left: 30, top: 12 })
          .fontColor('#FFFFFF，90%')
          .onClick(() => {
            this.customCounter2++
          })
      }

      Row() {
        Text(`Custom Local: ${this.customCounter2}`).fontColor('#ff6b6565').margin({ left: -110, top: 12 })
      }
    }
  }
}

@Component
struct Child_ {
  @Prop value: number;

  build() {
    Text(`${this.value}`)
      .fontSize(50)
      .onClick(()=>{this.value++})
  }
}



@Builder function overBuilder2() {}



@Component
struct Child {
  @State title: string = 'Hello World';
  label: string = `Child`
  // 组件生命周期
  aboutToDisappear() {
    console.info('[lifeCycle] Child aboutToDisappear')
  }
  // 组件生命周期
  aboutToAppear() {
    console.info('[lifeCycle] Child aboutToAppear')
    // this.MyGlobalBuilderFunction()
  }

  @Builder doNothingBuilder() {};

  // 使用自定义组件的自定义构建函数初始化@BuilderParam
  @BuilderParam customBuilderParam: () => void = this.doNothingBuilder; // @BuilderParam装饰的方法只能被自定义构建函数（@Builder装饰的方法）初始化
  // 使用全局自定义构建函数初始化@BuilderParam
  @BuilderParam customOverBuilderParam: () => void = overBuilder2;

  // 使用父组件@Builder装饰的方法初始化子组件@BuilderParam
  @BuilderParam customBuilderParamP: () => void;

  // 无参数类型，指向的componentBuilder也是无参数类型
  @BuilderParam customBuilderParam2: () => void;
  // 有参数类型，指向的GlobalBuilder1也是有参数类型的方法
  @BuilderParam customOverBuilderParam3: ($$ : { label : string }) => void;

  build() {
    Column() {
      this.customBuilderParamP()

      // this.customBuilderParam2()
      this.customOverBuilderParam3({label: 'global Builder label' } )
      Text(this.title).fontSize(50).onClick(() => {
        this.title = 'Hello ArkUI';
      })
    }

  }


  @Builder MyGlobalBuilderFunction() {   }
}

// xxx.ets
@Component
struct CustomContainer {
  @Prop header: string;
  // 使用父组件的尾随闭包{}(@Builder装饰的方法)初始化子组件@BuilderParam
  @BuilderParam closer: () => void

  build() {
    Column() {
      Text(this.header)
        .fontSize(30)
      this.closer()
    }
  }
}

@Builder function specificParam(label1: string, label2: string) {
  Column() {
    Text(label1)
      .fontSize(30)
    Text(label2)
      .fontSize(30)
  }
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