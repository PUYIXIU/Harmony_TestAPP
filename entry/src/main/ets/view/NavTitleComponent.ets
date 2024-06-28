/**
 * 页面导航栏头
 */
import { global } from '../config/theme'

// @Observed
// export class NavHeadTitle {
//   title: string // 主标题名称
//   subTitle: string // 副标题名称
//   menuList: Array<Object> // 按钮列表
//   constructor(
//     title: string, // 主标题名称
//     subTitle: string, // 副标题名称
//     menuList: Array<Object>, // 按钮列表
//   ) {
//     this.title = title ? title : ''
//     this.subTitle = subTitle ? subTitle : ''
//     this.menuList = menuList ? menuList : []
//   }
// }

@Component
export struct NavTitleComp {
  // ObjectLink中出现数组类型报错，官网解决方案：
  // https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-observed-and-objectlink-V5#%E5%AF%B9%E8%B1%A1%E6%95%B0%E7%BB%84
  // @ObjectLink headCfg: NavHeadTitle;
  @Prop title: string;
  @Prop subTitle: string;
  @Link menuList: Array<string>;

  build() {
    Row() {
      Column() {
        // Text(this.headCfg.title)
        Text(this.title)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#fff')
        // Text(this.headCfg.subTitle)
        Text(this.subTitle)
          .fontColor(global.lightTextColor)
          .fontWeight(500)
          .fontSize(20)
          .margin({ top: 5 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 20 })

      Column() {
        // 资源名不允许出现分隔符-
        Row() {
          ForEach(this.menuList, (item) => {
            Image(item.ico)
              .width(50)
              .backgroundColor(global.bodyBackgroundColor)
              .borderRadius(25)
              .padding(7)
              .margin({ right: 10 })
          })
        }
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundImage($r('app.media.banner3'))
    .backgroundImageSize(ImageSize.Cover)
    .backgroundBlurStyle(BlurStyle.Thin)
    .height('100%')
    .width('100%')
    .shadow({
      radius: 100,
      color: '#000',
      offsetY: -10
    })
  }
}