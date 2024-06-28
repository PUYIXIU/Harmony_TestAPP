/**
 * 标题栏组件
 */
import router from '@ohos.router';
import { popMsg } from '../common/utils/msg';
import { global } from '../config/theme';

/**
 * 观察多层嵌套场景的class
 */
@Observed
export class TitleBar {
  ico: string | PixelMap | Resource; // 标题图标
  icoColor: ResourceColor; // 图标颜色
  title: string | Resource; // 标题
  fontColor: ResourceColor; // 标题颜色
  more: boolean; // 是否显示更多
  url: string; // 点击后跳转的url
  params: Object; // 跳转传参

  constructor(
    ico: string | PixelMap | Resource, // 标题图标
    icoColor: ResourceColor, // 图标颜色
    title: string | Resource, // 标题
    fontColor: ResourceColor, // 标题颜色
    more: boolean, // 是否显示更多
    url: string, // 点击后跳转的url
    params: Object // 跳转传参
  ) {
    this.ico = ico
    this.icoColor = icoColor ? icoColor : global.mainTextColor
    this.title = title
    this.fontColor = fontColor ? fontColor : global.mainTextColor
    this.more = more ? more : false;
    this.url = url
    this.params = params
  }
}

@Component
export struct TitleBarComp {
  // 观察多层嵌套场景，和父组件数据源双向同步
  @ObjectLink titleBar: TitleBar;

  build() {
    Row() {
      Row() {
        Image(this.titleBar.ico)
          .height(16)
          .fillColor(this.titleBar.icoColor)
        Text(this.titleBar.title)
          .fontWeight(FontWeight.Bolder)
          .fontSize(16)
          .margin({ left: 5 })
          .fontColor(this.titleBar.fontColor)
      }

      if (this.titleBar.more) {
        Row() {
          Text('More')
            .fontSize(14)
            .margin({ right: 5 })
            .fontColor(this.titleBar.fontColor)
          Image($r('app.media.arrowRight'))
            .fillColor(this.titleBar.fontColor)
            .height(14)
        }
        .margin({ right: 15 })
        .onClick(() => {
          if (this.titleBar && this.titleBar.url) {
            router.pushUrl({
              url: this.titleBar.url,
              params: this.titleBar.params
            })
          } else {
            popMsg('暂未实现')
          }
        })
      }
    }
    .width('100%')
    .margin({ top: 5, left: 10, right: 10, bottom: 5 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}