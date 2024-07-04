// import { authentication } from '@kit.AccountKit';
import router from '@ohos.router'
// import { BusinessError } from '@kit.BasicServicesKit';
// import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
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
          router.pushUrl({ url: 'pages/Second' })
        })

        Button('click to library')
          .onClick(()=>{
            router.pushUrl({ // url内容的模板为：'@bundle:包名（bundleName）/模块名（moduleName）/路径/页面所在的文件名(不加.ets后缀)'
              url: '@bundle:com.example.myatomicservice/library/src/main/ets/pages/menu'
            }).then(() => {
              console.info('push page success');
            }).catch((err) => {
              console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }

  aboutToAppear() {
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    this.loginWithHuaweiID();
  }

  /**
   * Sample code for using HUAWEI ID to log in to atomic service.
   * According to the Atomic Service Review Guide, when a atomic service has an account system,
   * the option to log in with a HUAWEI ID must be provided.
   * The following presets the atomic service to use the HUAWEI ID silent login function.
   * To enable the atomic service to log in successfully using the HUAWEI ID, please refer
   * to the HarmonyOS HUAWEI ID Access Guide to configure the client ID and fingerprint certificate.
   */
  private loginWithHuaweiID() {
    // Create a login request and set parameters
    // let loginRequest = new authentication.HuaweiIDProvider().createLoginWithHuaweiIDRequest();
    // // Whether to forcibly launch the HUAWEI ID login page when the user is not logged in with the HUAWEI ID
    // loginRequest.forceLogin = false;
    // // Execute login request
    // let controller = new authentication.AuthenticationController();
    // controller.executeRequest(loginRequest).then((data) => {
    //   let loginWithHuaweiIDResponse = data as authentication.LoginWithHuaweiIDResponse;
    //   let authCode = loginWithHuaweiIDResponse.data?.authorizationCode;
    //   // Send authCode to the backend in exchange for unionID, session
    //
    // }).catch((error: BusinessError) => {
    //   hilog.error(0x0000, 'testTag', 'error: %{public}s', JSON.stringify(error));
    //   if (error.code == authentication.AuthenticationErrorCode.ACCOUNT_NOT_LOGGED_IN) {
    //     // HUAWEI ID is not logged in, it is recommended to jump to the login guide page
    //
    //   }
    // });
  }
}

