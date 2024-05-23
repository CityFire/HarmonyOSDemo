let storage = new LocalStorage();

@Entry(storage)
@Component
struct WidgetCard {
  /*
   * The title.
   */
  readonly TITLE: string = 'Hello World';

  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';

  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';

  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';

  /*
   * The with percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';

  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  @LocalStorageProp('title') title: string = 'init';

  @LocalStorageProp('detail') detail: string = 'init';

  @LocalStorageProp('formId') formId: string = '0';

  @LocalStorageProp('text') text: string = '加载中...';
  @LocalStorageProp('loaded') loaded: boolean = false;
  @LocalStorageProp('imgName') imgName: string = 'name';

  @LocalStorageProp('textA') textA: string = '待刷新...';
  @LocalStorageProp('textB') textB: string = '待刷新...';
  @State selectA: boolean = false;
  @State selectB: boolean = false;

  /*
  build() {

    Row() {
      Column() {
        Text(this.TITLE)
          .fontSize($r('app.float.font_size'))
      }
      .width(this.FULL_WIDTH_PERCENT)
    }
    .height(this.FULL_HEIGHT_PERCENT)
    .onClick(() => {
      postCardAction(this, {
        "action": this.ACTION_TYPE,
        "abilityName": this.ABILITY_NAME,
        "params": {
          "message": this.MESSAGE
        }
      });
    })

    /*
    Button('跳转')
      .width('40%')
      .height('20%')
      .onClick(() => {
        postCardAction(this, {
          'action': 'router',
          'bundleName': 'com.example.myapplication5',
          'abilityName': 'EntryAbility',
          'params': {
            'message': 'testForRouter' // 自定义要发送的message
          }
        });
      })

    Button('拉至后台')
      .width('40%')
      .height('20%')
      .onClick(() => {
        postCardAction(this, {
          'action': 'call',
          'bundleName': 'com.example.myapplication5',
          'abilityName': 'EntryAbility',
          'params': {
            'method': 'fun', // 自定义调用的方法名，必填
            'message': 'testForCall' // 自定义要发送的message
          }
        });
      })
      */
  // }

  build() {

    Column() {
      Row() {
        Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
          .select(false)
          .onChange((value: boolean) => {
            this.selectA = value;
            postCardAction(this, {
              'action': 'message',
              'params': {
                'selectA': JSON.stringify(value)
              }
            });
          })
        Text('状态A')

        Checkbox({ name: 'checkbox2', group: 'checkboxGroup' })
          .select(false)
          .onChange((value: boolean) => {
            this.selectB = value;
            postCardAction(this, {
              'action': 'message',
              'params': {
                'selectB': JSON.stringify(value)
              }
            });
          })
        Text('状态B')
      }

      Row() { // 选中状态A才会进行刷新的内容
        Text('状态A: ')
        Text(this.textA)
      }

      Row() { // 选中状态B才会进行刷新的内容
        Text('状态B: ')
        Text(this.textB)
      }
    }.padding('10%')
  }
  /*
    Column() {
      Button('功能A')
        .margin(2)
        .onClick(() => {
          console.info('Jump to CameraAbility funA');
          postCardAction(this, {
            'action': 'router',
            'abilityName': 'CameraAbility', // 只能跳转到当前应用下的UIAbility
            'params': {
              'targetPage': 'funA' // 在CameraAbility中处理这个信息
            }
          });
        })

      Button('跳转')
        .margin(2)
        .onClick(() => {
          console.info('postCardAction to CameraAbility');
          postCardAction(this, {
            'action': 'router',
            'abilityName': 'CameraAbility', // 只能跳转到当前应用下的UIAbility
            'params': {
              'detail': 'RouterFromCard'
            }
          });
        })

      Button('拉至后台')
        .margin(2)
        .onClick(() => {
          console.info('postCardAction to CameraAbility');
          postCardAction(this, {
            'action': 'call',
            'abilityName': 'CameraAbility', // 只能跳转到当前应用下的UIAbility
            'params': {
              'method': 'funE',
              'formId': this.formId,
              'detail': 'CallFromCard'
            }
          });
        })
      Text(`${this.detail}`).margin(2)

      Row() {
        if (this.loaded) {
          Image('memory://' + this.imgName)
            .width('50%')
            .height('50%')
            .margin('5%')
        } else {
          Image('common/start.PNG')
            .width('50%')
            .height('50%')
            .margin('5%')
        }
      }.alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Button('刷新')
        .onClick(() => {
          postCardAction(this, {
          'action': 'message',
          'params': {
            'msgTest': 'messageEvent'
          }
          });
        }).margin(2)

      Text(`${this.title}`)
      Text(`${this.detail}`)

      Button('功能B')
        .margin(2)
        .onClick(() => {
          console.info('Jump to CameraAbility funB');
          postCardAction(this, {
            'action': 'router',
            'abilityName': 'CameraAbility', // 只能跳转到当前应用下的UIAbility
            'params': {
              'targetPage': 'funB' // 在CameraAbility中处理这个信息
            }
          });
        })

      Button('功能C')
        .margin(2)
        .onClick(() => {
          console.info('Jump to CameraAbility funC');
          postCardAction(this, {
            'action': 'call',
            'abilityName': 'CameraAbility', // 只能跳转到当前应用下的UIAbility
            'params': {
              'method': 'funC' // 在CameraAbility中调用的方法名
            }
          });
        })

      Button('功能D')
        .margin(2)
        .onClick(() => {
          console.info('Jump to CameraAbility funD');
          postCardAction(this, {
            'action': 'call',
            'abilityName': 'CameraAbility', // 只能跳转到当前应用下的UIAbility
            'params': {
              'method': 'funD', // 在EntryAbility中调用的方法名
              'num': 1 // 需要传递的其他参数
            }
          });
        })
    }
    .width('100%')
    .height('100%')
  }
  * */
}