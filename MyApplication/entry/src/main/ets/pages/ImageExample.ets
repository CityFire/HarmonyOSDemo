import picker from '@ohos.file.picker';
import http from '@ohos.net.http';
import ResponseCode from '@ohos.net.http';
import image from '@ohos.multimedia.image';

@Entry
@Component
struct ImageExample {
  @State message: string = 'Hello World'
  @State imgDatas: string[] = [];
  @State image: PixelMap = undefined;
  scroller: Scroller = new Scroller()

  @State widthValue: number = 0
  @State heightValue: number = 0
  @State componentWidth: number = 0
  @State componentHeight: number = 0

  // 获取照片url集
  getAllImg() {
    let result = new Array<string>();
    try {
      let PhotoSelectOptions = new picker.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 5;
      let photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
        this.imgDatas = PhotoSelectResult.photoUris;
        console.info('PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult));
      }).catch((err) => {
        console.error(`PhotoViewPicker.select failed with. Code: ${err.code}, message: ${err.message}`);
      });
    } catch (err) {
      console.error(`PhotoViewPicker failed with. Code: ${err.code}, message: ${err.message}`);    }
  }

  // aboutToAppear中调用上述函数，获取图库的所有图片url，存在imgDatas中
  async aboutToAppear() {
    this.getAllImg();
  }

  httpRequest() {
    http.createHttp().request("https://fc4tn.baidu.com/it/u=1223076131,3921262935&fm=202", (error, data) => {
      if (error){
        console.error(`http reqeust failed with. Code: ${error.code}, message: ${error.message}`);
      } else {
        let code = data.responseCode;
        if (ResponseCode.ResponseCode.OK === code) {
          let res: any = data.result
          let imageSource = image.createImageSource(res);
          let options = {
            alphaType: 0,                     // 透明度
            editable: false,                  // 是否可编辑
            pixelFormat: 3,                   // 像素格式
            scaleMode: 1,                     // 缩略值
            size: { height: 100, width: 100}
          } // 创建图片大小
          imageSource.createPixelMap(options).then((pixelMap) => {
            this.image = pixelMap
          })
        }
      }
    })
  }

  build() {
    // Scroll(this.scroller) {
    //
    // }
    Row() {
      Column() {
        // Grid() {
        //   ForEach(this.imgDatas, item => {
        //     GridItem() {
        //       Image(item)
        //         .width(200)
        //     }
        //   }, item => JSON.stringify(item))
        // }.width('100%').height('30%')

        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("获取网络图片")
          .onClick(() => {
            this.httpRequest()
          }).width(160).height(30).margin(5)

        Image(this.image).height(100).width(100).margin(5)

        Image('images/ic_banner.png')
          .width(200).height(150).margin(5)
          .onComplete(msg => {
            if(msg){
              this.widthValue = msg.width
              this.heightValue = msg.height
              this.componentWidth = msg.componentWidth
              this.componentHeight = msg.componentHeight
            }
          })
            // 图片获取失败，打印结果
          .onError(() => {
            console.info('load image fail')
          })
          .overlay('\nwidth: ' + String(this.widthValue) + ', height: ' + String(this.heightValue) + '\ncomponentWidth: ' + String(this.componentWidth) + '\ncomponentHeight: ' + String(this.componentHeight), {
            align: Alignment.Bottom,
            offset: { x: 0, y: 60 }
          })

        Image($r('app.media.icon'))
          .syncLoad(true)


        Image('https://fc4tn.baidu.com/it/u=1223076131,3921262935&fm=202').margin(5)

        Image($r('app.media.ic_banner04')).width(200).height(150).margin(5)
          .interpolation(ImageInterpolation.None) // 当原图分辨率较低并且放大显示时，图片会模糊出现锯齿。这时可以使用interpolation属性对图片进行插值，使图片显示得更清晰。
          // .interpolation(ImageInterpolation.Low)
          // .overlay("Interpolation.Low", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          // .interpolation(ImageInterpolation.Medium)
          // .overlay("Interpolation.Medium", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          // .interpolation(ImageInterpolation.High)
          // .overlay("Interpolation.High", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          .border({ width: 1 })

          .colorFilter(
            [1, 1, 0, 0, 0,
              0, 1, 0, 0, 0,
              0, 0, 1, 0, 0,
              0, 0, 0, 1, 0])

            // 通过sourceSize属性设置图片解码尺寸，降低图片的分辨率。
          // .sourceSize({
          //   width: 150,
          //   height: 150
          // })
          .aspectRatio(1)
          // .overlay('width:150 height:150', { align: Alignment.Bottom, offset: { x: 0, y: 40 } })

            // 设置图片的渲染模式为原色
          .renderMode(ImageRenderMode.Original)
            // overlay是通用属性，用于在组件上显示说明文字
          .overlay('Original', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })

            // 设置图片的渲染模式为黑白
          // .renderMode(ImageRenderMode.Template)
          // .overlay('Template', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })

          // 通过objectRepeat属性设置图片的重复样式方式
          .objectRepeat(ImageRepeat.Y)
          .objectFit(ImageFit.ScaleDown)
            // 只在竖直轴上重复绘制图片
          .overlay('ImageRepeat.Y', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })

          // .objectRepeat(ImageRepeat.X)
          // .objectFit(ImageFit.ScaleDown)
          //   // 只在水平轴上重复绘制图片
          // .overlay('ImageRepeat.X', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })

          // .objectRepeat(ImageRepeat.XY)
            // 在水平轴和竖直轴上同时重复绘制图片
          // .overlay('ImageRepeat.XY', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          // .objectFit(ImageFit.Contain).margin(15) // 保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内。
          // .overlay('Contain', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          // .objectFit(ImageFit.Cover).margin(15)
          // // 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
          // .overlay('Cover', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            // 自适应显示。
          // .objectFit(ImageFit.Auto).margin(15)
          // .overlay('Auto', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          // .objectFit(ImageFit.Fill).margin(15)
          // // 不保持宽高比进行放大缩小，使得图片充满显示边界。
          // .overlay('Fill', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            // 保持宽高比显示，图片缩小或者保持不变。
          // .objectFit(ImageFit.ScaleDown).margin(15)
          // .overlay('ScaleDown', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            // 保持原有尺寸显示。
          // .objectFit(ImageFit.None).margin(15)
          // .overlay('None', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })

        Image($rawfile('ic_increase.png')).width(50).fillColor(Color.Blue).height(50).margin(5)

      }
      .width('100%')
    }
    .height('100%')
  }
}