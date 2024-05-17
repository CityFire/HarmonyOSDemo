import image from '@ohos.multimedia.image';

@Component
struct ChildComponent {
  build() {
    // 根节点唯一且必要，可为非容器组件
    // Image($r('app.media.img_example1'))
    Image('test.jpg')
  }
}