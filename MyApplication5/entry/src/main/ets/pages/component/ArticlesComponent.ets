@Entry
@Component
struct ArticlesComponent {
  @State isListReachEnd: boolean = false;
  @State articleList: Array<Article> = [
    new Article('001', '第1篇文章', '文章简介内容', false, 100),
    new Article('002', '第2篇文章', '文章简介内容', false, 100),
    new Article('003', '第3篇文章', '文章简介内容', false, 100),
    new Article('004', '第4篇文章', '文章简介内容', false, 100),
    new Article('005', '第5篇文章', '文章简介内容', false, 100),
    new Article('006', '第6篇文章', '文章简介内容', false, 100)
  ]

  @State simpleList: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8];

  loadMoreArticles() {
    this.articleList.push(new Article('007', '加载的新文章', '文章简介内容', false, 100));
  }

  build() {

    /*
   Column() {
     ForEach(this.simpleList, (item: string) => {
       ArticleSkeletonView()
         .margin({ top: 20 })
     }, (item: string) => item)
   }
   .padding(20)
   .width('100%')
   .height('100%')
   */


    Column({ space: 5 }) {
      List() {
        ForEach(this.articleList, (item: Article) => {
          ListItem() {
            ArticleCard({ article: item })
              .margin({ top: 20 })
          }
        }, (item: Article) => item.id)
      }
      .onReachEnd(() => {
        this.isListReachEnd = true;
      })
      .parallelGesture(
        PanGesture({ direction: PanDirection.Up, distance: 80 })
          .onActionStart(() => {
            if (this.isListReachEnd) {
              this.loadMoreArticles();
              this.isListReachEnd = false;
            }
          })
      )
      .padding(20)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }

}

class Article {
  id: string;
  title: string;
  brief: string;
  isLiked: boolean;
  likesCount: number;

  constructor(id: string, title: string, brief: string, isLiked: boolean, likesCount: number) {
    this.id = id;
    this.title = title;
    this.brief = brief;
    this.isLiked = isLiked;
    this.likesCount = likesCount;
  }
}

@Component
struct ArticleListView {
  @State isListReachEnd: boolean = false;
  @State count: number = 0;
  @State articleList: Array<Article> = [
    new Article('001', '第1篇文章', '文章简介内容', false, 100),
    new Article('002', '第2篇文章', '文章简介内容', false, 100),
    new Article('003', '第3篇文章', '文章简介内容', false, 100),
    new Article('004', '第4篇文章', '文章简介内容', false, 100),
    new Article('005', '第5篇文章', '文章简介内容', false, 100),
    new Article('006', '第6篇文章', '文章简介内容', false, 100)
  ]

  loadMoreArticles() {
    this.articleList.push(new Article('007', '加载的新文章', '文章简介内容', false, 100));
  }

  build() {
    Column({ space: 5 }) {
      List() {
        ForEach(this.articleList, (item: Article) => {
          ListItem() {
            ArticleCard({
              article: item
            })
              .margin({ top: 20 })
          }
        }, (item: Article) => item.id)
      }
      .padding(20)
      .scrollBar(BarState.Off)
      .backgroundColor(0xF1F3F5)
      .onReachEnd(() => {
        this.isListReachEnd = true;
      })
      .parallelGesture(
        PanGesture({ direction: PanDirection.Up, distance: 80 })
          .onActionStart(() => {
            if (this.isListReachEnd) {
              this.loadMoreArticles();
              this.isListReachEnd = false;
            }
          })
      )
      .padding(20)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }
}

@Component
struct ArticleCard {
  // in low version, DevEco may throw a warning, but it does not matter.
  // you can still compile and run,
  @Prop article: Article; //   ObjectLink

  handleLiked() {
    this.article.isLiked = !this.article.isLiked;
    this.article.likesCount = this.article.isLiked ? this.article.likesCount + 1 : this.article.likesCount - 1;
  }

  build() {
    Row() {
      Image($r('app.media.icon'))
        .width(80)
        .height(80)
        .margin({ right: 20 })

      Column() {
        Text(this.article.title)
          .fontSize(20)
          .margin({ bottom: 8 })
        Text(this.article.brief)
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 8 })

        Row() { // $r('app.media.iconLiked') : $r('app.media.iconUnLiked')
          Image(this.article.isLiked ? $r('app.media.ic_send') : $r('app.media.ic_share'))
            .width(24)
            .height(24)
            .margin({ right: 8 })
          Text(this.article.likesCount.toString())
            .fontSize(16)
        }
        .onClick(() => this.handleLiked())
        .justifyContent(FlexAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .width('80%')
      .height('100%')
    }
    .padding(20)
    .borderRadius(12)
    .backgroundColor('#FFECECEC')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}


@Builder
function textArea(width: number | Resource | string = '100%', height: number | Resource | string = '100%') {
  Row()
    .width(width)
    .height(height)
    .backgroundColor('#FFF2F3F4')
}

@Component
struct ArticleSkeletonView {
  build() {
    Row() {
      Column() {
        textArea(80, 80)
      }
      .margin({ right: 20 })

      Column() {
        textArea('60%', 20)
        textArea('50%', 20)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceAround)
      .height('100%')
    }
    .padding(20)
    .borderRadius(12)
    .backgroundColor('#FFECECEC')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}