@Entry
@Component
struct CanvasExample {
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  //用来创建OffscreenCanvasRenderingContext2D对象，width为离屏画布的宽度，height为离屏画布的高度。通过在canvas中调用OffscreenCanvasRenderingContext2D对象来绘制。
  private offContext: OffscreenCanvasRenderingContext2D = new OffscreenCanvasRenderingContext2D(600, 600, this.settings)
  private img: ImageBitmap = new ImageBitmap("/images/ic_banner.png")

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      //在canvas中调用CanvasRenderingContext2D对象。
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .backgroundColor('#F5DC62')
        .onReady(() => {
          //可以在这里绘制内容。
          this.context.strokeRect(50, 50, 200, 150);
          //将离屏绘值渲染的图像在普通画布上显示
          let image = this.offContext.transferToImageBitmap();
          this.context.transferFromImageBitmap(image);
          this.context.fillStyle = '#0097D4';
          this.context.fillRect(100, 200, 100, 100);

          this.context.beginPath();
          this.context.moveTo(50, 50);
          this.context.lineTo(280, 160);
          this.context.stroke();

          let region = new Path2D();
          region.arc(100, 75, 50, 0, 6.28);
          this.context.stroke(region);

          //绘制矩形
          this.context.beginPath();
          this.context.rect(100, 50, 100, 100);
          this.context.stroke();
          //绘制圆形
          this.context.beginPath();
          this.context.arc(150, 250, 50, 0, 6.28);
          this.context.stroke();
          //绘制椭圆
          this.context.beginPath();
          this.context.ellipse(150, 450, 50, 100, Math.PI * 0.25, Math.PI * 0, Math.PI * 2);
          this.context.stroke();

          //绘制填充类文本
          this.context.font = '50px sans-serif';
          this.context.fillText("Hello World!", 50, 100);
          //绘制描边类文本
          this.context.font = '55px sans-serif';
          this.context.strokeText("Hello World!", 50, 150);

          // 使用drawImage接口将图片画在（0，0）为起点，宽高130的区域
          this.offContext.drawImage(this.img, 0, 0, 130, 130);
          // 使用getImageData接口，获得canvas组件区域中，（50，50）为起点，宽高130范围内的绘制内容
          let imagedata = this.offContext.getImageData(50,50,130,130);
          // 使用putImageData接口将得到的ImageData画在起点为（150， 150）的区域中
          this.offContext.putImageData(imagedata, 150, 150);
          // 将离屏绘制的内容画到canvas组件上
          let image1 = this.offContext.transferToImageBitmap();
          this.context.transferFromImageBitmap(image1);

          //创建一个径向渐变色的CanvasGradient对象
          let grad = this.context.createRadialGradient(200,200,50, 200,200,200)
          //为CanvasGradient对象设置渐变断点值，包括偏移和颜色
          grad.addColorStop(0.0, '#E87361');
          grad.addColorStop(0.5, '#FFFFF0');
          grad.addColorStop(1.0, '#BDDB69');
          //用CanvasGradient对象填充矩形
          this.context.fillStyle = grad;
          this.context.fillRect(0, 0, 400, 400);

          // 设定填充样式，填充颜色设为蓝色
          this.context.fillStyle = '#0097D4';
          // 以(50, 50)为左上顶点，画一个宽高200的矩形
          this.context.fillRect(50,50,200,200);
          // 以(70, 70)为左上顶点，清除宽150高100的区域
          this.context.clearRect(70,70,150,100);

          // 使用Path2D的接口构造一个五边形
          let path = new Path2D();
          path.moveTo(150, 50);
          path.lineTo(50, 150);
          path.lineTo(100, 250);
          path.lineTo(200, 250);
          path.lineTo(250, 150);
          path.closePath();
          // 设定填充色为蓝色
          this.context.fillStyle = '#0097D4';
          // 使用填充的方式，将Path2D描述的五边形绘制在canvas组件内部
          this.context.fill(path);
        })
    }
    .width('100%')
    .height('100%')
  }
}