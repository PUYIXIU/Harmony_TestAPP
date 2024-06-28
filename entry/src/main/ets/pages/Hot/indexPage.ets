/**
 * 热点界面
 */
import router from '@ohos.router'
import { global, hot, menu } from '../../config/theme'
import { NavFootComp } from '../../view/NavFootComponent'
import { NavTitleComp } from '../../view/NavTitleComponent'

const honerList = [
  {
    img: $r('app.media.level1'),
    color: global.mainTextColor
  },
  {
    img: $r('app.media.level2'),
    color: global.navToolBarColor
  },
  {
    img: $r('app.media.level3'),
    color: global.secondTextColor
  },
]


@Entry
@Component
struct Index {
  @State hotBanners: Array<Object> = [
    {
      img: $r("app.media.banner1"),
      title: 'LEVEL ONE',
      subTitle: 'XXX-XXX topic xxxxxxxxxxx',
    },
    {
      img: $r("app.media.banner2"),
      title: 'LEVEL TWO',
      subTitle: 'XXX-XXX',
    },
    {
      img: $r("app.media.banner3"),
      title: 'LEVEL THREE',
      subTitle: 'XXX-XXX',
    },
    {
      img: $r("app.media.banner1"),
      title: 'XXX-XXX',
      subTitle: 'XXX-XXX',
    },
  ]
  @State title: string = hot.title;
  @State subTitle: string = hot.subTitle;
  @State menuList: Array<Object> = menu.menuList;
  @State currentIndex: number = 1 //
  @Builder
  renderTitle() {
    Row() {
      NavTitleComp({
        title: this.title,
        subTitle: this.subTitle,
        menuList: $menuList
      })
    }.width('100%').height('100%')
  }

  // CustomBuilder 自定义底部工具栏
  @Builder
  renderToolbar() {
    Row() {
      ForEach(menu.toolbar, item => {
        Column() {
          Image(item.ico)
            .width(20)
            .height(20)
            .margin({ top: 2 })
            .fillColor(this.currentIndex == item.num ? global.navMenuColor : global.bodyBackgroundColor)
          Text(item.text)
            .fontColor(this.currentIndex == item.num ? global.navMenuColor : global.bodyBackgroundColor)
            .fontSize(10)
            .lineHeight(14)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 6 })
        }
        .width('33%')
        .height(56)
        .onClick(() => {
          if (this.currentIndex != item.num) {
            if (item.url) {
              // 页面替换
              router.replaceUrl({
                url: item.url
              })
            }
          }
        })
      })
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor(global.navToolBarColor)
    .padding({ top: 10 })
    .width('100%')
    // NavFootComp({ currentIndex: this.currentIndex })
  }

  build() {
    Navigation() {
      Column() {
        List({ space: 10 }) {
          ForEach(this.hotBanners, (item, index) => {
            ListItem() {
              Column() {
                Image(item.img)
                  .width('100%')
                  .height(100)
                  .objectFit(ImageFit.Cover)
                  .border({
                    radius: { topLeft: 20 }
                  })
                Row() {

                  if (index < 3) {
                    Column() {
                      Image(honerList[index].img).width(50).height(50).objectFit(ImageFit.Contain)
                    }

                    Text(`No. ${index + 1}`)
                      .fontWeight(FontWeight.Bolder)
                      .fontSize(16)
                      .fontColor(honerList[index].color)
                  } else {
                    Column() {
                      Image($r("app.media.star")).width(20).height(20).objectFit(ImageFit.Contain)
                    }.margin({ left: 15, right: 15 })

                    Text(`No. ${index + 1}`)
                      .fontWeight(FontWeight.Bolder)
                      .fontSize(16)
                      .fontColor(global.bodyBackgroundColor)
                  }
                  Column() {
                    Text(item.title)
                      .width(150)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .padding({ bottom: 2 })
                      .fontColor(global.mainTextColor)

                    Text(item.subTitle)
                      .width(150)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .maxLines(1)
                      .fontSize(15)
                      .fontStyle(FontStyle.Italic)
                      .fontColor(global.secondTextColor)
                      .padding({ top: 2 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: 15 })
                  .flexGrow(1)

                  Row() {
                    Text('More')
                      .fontSize(14)
                      .fontColor(global.mainTextColor)
                    Image($r('app.media.arrowRight')).width(14).height(14).fillColor(global.mainTextColor)
                  }
                  .width(50)
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .backgroundColor(global.lightTextColor)
                .width('100%')
                .padding(5)
                .border({
                  radius: { bottomRight: 20 }
                })
              }
              .borderRadius(20)
            }
          })
        }
        .width('95%')
        .margin({ top: 10 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(global.bodyBackgroundColor)
    }
    .title(this.renderTitle())
    .toolBar(this.renderToolbar())
  }
}