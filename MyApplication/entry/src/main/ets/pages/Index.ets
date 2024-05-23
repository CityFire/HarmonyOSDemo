// Index.ets
// 导入页面路由模块
import router from '@ohos.router';
import common from '@ohos.app.ability.common';

const TAG = 'Index';

const RESULT_CODE: number = 1001;
let abilityResult = {
  resultCode: RESULT_CODE,
  want: {
    bundleName: 'com.example.myapplication',
    abilityName: 'EntryAbility',
    moduleName: 'entry',
    parameters: {
      payResult: 'OKay',
    },
  },
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  private context = getContext(this) as common.UIAbilityContext;

  private arr: string[] = ['APP1', 'APP2', 'APP3', 'APP4', 'APP5', 'APP6', 'APP7', 'APP8'];

  @Builder
  ListView() {
    List() {
      ListItem() {
        Text('点击menu')  // $r('app.string.click_to_menu')
          .fontSize(18)
          .textAlign(TextAlign.Start)
          .width('100%')
          .fontWeight(500)
          .height('100%')

        this.stackView1()

      }
      .id('clickToMenu')
      .borderRadius(24)
      .width('685px')
      .height('84px')
      .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary'))
      .margin({ top: 10, bottom: 10 })
      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
      .onClick(() => {
        router.pushUrl({
          url: '@bundle:com.example.myapplication/library/ets/pages/MenuPage' // '@bundle:包名（bundleName）/模块名（moduleName）/路径/页面所在的文件名(不加.ets后缀)'
        }).then(() => {
          console.log('push page success');
          console.info('push page success');
        }).catch((err) => {
          console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
        })
      })
    }
    .width('100%')
    .backgroundColor($r('app.color.page_background'))
    .height('50%')
    .alignListItem(ListItemAlign.Center)
  }

  @Builder
  stackView() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Column() {
        Text('Stack子元素1').textAlign(TextAlign.End).fontSize(20)
      }.width(100).height(100).backgroundColor(0xffd306).zIndex(2)

      Column() {
        Text('Stack子元素2').fontSize(20)
      }.width(150).height(150).backgroundColor(Color.Pink).zIndex(1)

      Column() {
        Text('Stack子元素3').fontSize(20)
      }.width(200).height(200).backgroundColor(Color.Grey)
    }.margin({ top: 100 }).width(350).height(350).backgroundColor(0xe0e0e0)

  }

  @Builder
  stackView1() {
    Stack({ alignContent: Alignment.Bottom }) {
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.arr, (item) => {
          Text(item)
            .width(100)
            .height(100)
            .fontSize(16)
            .margin(10)
            .textAlign(TextAlign.Center)
            .borderRadius(10)
            .backgroundColor(0xFFFFFF)
        }, item => item)
      }.width('100%').height('100%')

      // 可以通过Flex组件的alignItems参数设置子组件在交叉轴的对齐方式。
      // ItemAlign.Stretch：交叉轴方向拉伸填充，在未设置尺寸时，拉伸到容器尺寸。
      // ItemAlign. Baseline：交叉轴方向文本基线对齐。
      // 子组件的alignSelf属性也可以设置子组件在父容器交叉轴的对齐格式，且会覆盖Flex布局容器中alignItems配置。
      Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
        Text('联系人').fontSize(16)
        Text('设置').fontSize(16)
        Text('短信').fontSize(16)
      }
      .width('50%')
      .height(50)
      .backgroundColor('#16302e2e')
      .margin({ bottom: 15 })
      .borderRadius(15)
    }.width('100%').height('55%').backgroundColor('#CFD0CF')
  }

  @Builder
  ButtionView() {
    Text(this.message)
      .fontSize(50)
      .fontWeight(FontWeight.Bold)
    // 添加按钮，以响应用户点击
    Button() {
      Text('Next')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
    }
    .type(ButtonType.Capsule)
    .margin({
      top: 20
    })
    .backgroundColor('#0D9FFB')
    .width('40%')
    .height('5%')
    // 跳转按钮绑定onClick事件，点击时跳转到第二页
    .onClick(() => {
      console.info(`Succeeded in clicking the 'Next' button.`)
      // 跳转到第二页
      router.pushUrl({ url: 'pages/Second' }).then(() => {
        console.info('Succeeded in jumping to the second page.')
      }).catch((err) => {
        console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
      })
    }).margin(10)

    Button() {
      Text('stop')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
    }
    .type(ButtonType.Capsule)
    .margin({
      top: 20
    })
    .backgroundColor('#0D9FFB')
    .width('40%')
    .height('5%')
    .margin(10)
    // 跳转按钮绑定onClick事件，点击时跳转到第二页
    .onClick(() => {
      console.info(`Succeeded in clicking the 'stop' button.`)
      // context为需要停止的UIAbility实例的AbilityContext
      // this.context.terminateSelf((err) => {
      //   console.error(`Failed to jump to the prefix page.Code is ${err.code}, message is ${err.message}`)
      // });
      this.context.terminateSelfWithResult(abilityResult, (err) => {
        // ...
        console.error(`Failed to jump to the prefix page.Code is ${err.code}, message is ${err.message}`)
      });
    })
  }

  @Builder
  FlexView() {
    Flex({ direction: FlexDirection.RowReverse, justifyContent: FlexAlign.Start }) { // FlexDirection.Row
      Text('1').width('33%').height(50).backgroundColor(0xF5DEB3)
      Text('2').width('33%').height(50).backgroundColor(0xD2B48C)
      Text('3').width('33%').height(50).backgroundColor(0xF5DEB3)
    }
    .height(70)
    .width('90%')
    .padding(10)
    .backgroundColor(0xAFEEEE)

    Flex({ direction: FlexDirection.Column }) {
      Text('1').width('100%').height(50).backgroundColor(0xF5DEB3)
      Text('2').width('100%').height(50).backgroundColor(0xD2B48C)
      Text('3').width('100%').height(50).backgroundColor(0xF5DEB3)
    }
    .height(70)
    .width('90%')
    .padding({ top: 10, bottom: 10 })
    .backgroundColor(0xAFEEEE)

    // FlexAlign.SpaceEvenly：Flex主轴方向元素等间距布局，相邻子组件之间的间距、第一个子组件与主轴起始端的间距、最后一个子组件到主轴终点端的间距均相等。
    // FlexAlign.SpaceAround：Flex主轴方向均匀分配弹性元素，相邻子组件之间距离相同。第一个子组件到主轴起始端的距离和最后一个子组件到主轴终点端的距离是相邻元素之间距离的一半。
    Flex({ wrap: FlexWrap.NoWrap }) { // FlexWrap. Wrap：换行，每一行子组件按照主轴方向排列。FlexWrap. WrapReverse：换行，每一行子组件按照主轴反方向排列。
      Text('1').width('50%').height(50).backgroundColor(0xF5DEB3)
      Text('2').width('50%').height(50).backgroundColor(0xD2B48C)
      Text('3').width('50%').height(50).backgroundColor(0xF5DEB3)
    }
    .width('90%')
    .padding(10)
    .backgroundColor(0xAFEEEE)
  }

  build() {
    Row() {
      Column() {

        this.stackView1()

        this.ButtionView()

        this.FlexView()

      }
    }
    .width('100%')
  }
}