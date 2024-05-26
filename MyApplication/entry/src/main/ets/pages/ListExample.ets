import util from '@ohos.util'
@Component
struct CityList {
  build() {
    List() {
      ListItem() {
        Text('北京').fontSize(24)
      }

      ListItem() {
        Text('杭州').fontSize(24)
      }

      ListItem() {
        Text('上海').fontSize(24)
      }

      ListItem() {
        Row() {
          Image($r('app.media.icon'))
            .width(40)
            .height(40)
            .margin(10)

          Text('小明')
            .fontSize(20)
        }
      }

      ListItem() {
        Row() {
          Image($r('app.media.icon'))
            .width(40)
            .height(40)
            .margin(10)

          Text('小红')
            .fontSize(20)
        }
      }
    }
    .backgroundColor('#FFF1F3F5')
    .alignListItem(ListItemAlign.Center)
  }
}

class Contact {
  key: string = util.generateRandomUUID(true);
  name: string;
  icon: Resource;

  constructor(name: string, icon: Resource) {
    this.name = name;
    this.icon = icon;
  }
}

@Entry
@Component
struct SimpleContacts {
  private contacts = [
    new Contact('小明', $r("app.media.icon")),
    new Contact('小红', $r("app.media.icon")),
  ]

  build() {
    List() {
      ForEach(this.contacts, (item: Contact) => {
        ListItem() {
          Row() {
            Image(item.icon)
              .width(40)
              .height(40)
              .margin(10)
            Text(item.name).fontSize(20)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
        }
      }, item => item.key)
    }
    .width('100%')
    .divider({
      strokeWidth: 1,
      startMargin: 60,
      endMargin: 10,
      color: '#ffe9f0f0'
    })
    .scrollBar(BarState.Auto)
  }
}

@Component
struct ContactsList {

  private listScroller: Scroller = new Scroller();

  contactsGroups: object[] = [
    {
      title: 'A',
      contacts: [
        new Contact('艾佳', $r('app.media.icon')),
        new Contact('安安', $r('app.media.icon')),
        new Contact('Angela', $r('app.media.icon')),
      ],
    },
    {
      title: 'B',
      contacts: [
        new Contact('白叶', $r('app.media.icon')),
        new Contact('伯明', $r('app.media.icon')),
      ],
    },
  ]

  @Builder itemHead(text: string) {
    // 列表分组的头部组件，对应联系人分组A、B等位置的组件
    Text(text)
      .fontSize(20)
      .backgroundColor('#fff1f3f5')
      .width('100%')
      .padding(5)
  }

  @Builder ListView() {
    List() {
      ListItemGroup({ header: this.itemHead('A') }) {
        // 循环渲染分组A的ListItem
      }
      ListItemGroup({ header: this.itemHead('B') }) {
        // 循环渲染分组B的ListItem
      }
    }
  }

  @Builder ListView_() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 将listScroller用于初始化List组件的scroller参数，完成listScroller与列表的绑定。
      List({ space: 20, scroller: this.listScroller }) {

      }

      Button() {

      }
      .onClick(() => {
        // 点击按钮时，指定跳转位置，返回列表顶部
        this.listScroller.scrollToIndex(0)
      })
    }
  }

  build() {

    List() {
      // 循环渲染ListItemGroup，contactsGroups为多个分组联系人contacts和标题title的数据集合
      ForEach(this.contactsGroups, item => {
        ListItemGroup({ header: this.itemHead(item.title) }) {
          // 循环渲染ListItem
          ForEach(item.contacts, contact => {
            ListItem() {

            }
          }, item => item.key)
        }
      })
    }
    .sticky(StickyStyle.Header) // 设置吸顶，实现粘性标题效果
  }
}

// ListItem的swipeAction属性可用于实现列表项的左右滑动功能。swipeAction属性方法初始化时有必填参数SwipeActionOptions，
// 其中，start参数表示设置列表项右滑时起始端滑出的组件，end参数表示设置列表项左滑时尾端滑出的组件。
// 在消息列表中，end参数表示设置ListItem左滑时尾端划出自定义组件，即删除按钮。在初始化end方法时，
// 将滑动列表项的索引传入删除按钮组件，当用户点击删除按钮时，可以根据索引值来删除列表项对应的数据，从而实现侧滑删除功能。
@Component
struct MessageList {
  @State messages: object[] = [
  // 初始化消息列表数据
  ];

  @Builder itemEnd(index: number) {
    // 侧滑后尾端出现的组件
    Button({ type: ButtonType.Circle }) {
      Image($r('app.media.icon'))
        .width(20)
        .height(20)
    }
    .onClick(() => {
      this.messages.splice(index, 1);
    })
  }

  build() {
    List() {
      ForEach(this.messages, (item, index) => {
        ListItem() {

        }
        .swipeAction({ end: this.itemEnd(index) }) // 设置侧滑属性
      }, item => item.id.toString())
    }

    Badge({
      count: 1,
      position: BadgePosition.RightTop,
      style: { badgeSize: 16, badgeColor: '#FA2A2D' }
    }) {
      // Image组件实现消息联系人头像
    }
  }
}
