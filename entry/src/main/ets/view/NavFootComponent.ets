/**
 * 底部菜单栏
 */
import router from '@ohos.router'
import { Log } from '../common/utils/Log'
import { global, menu } from '../config/theme'

@Component
export struct NavFootComp {
  @State tools: Array<Object> = menu.toolbar // 底部栏
  @Prop currentIndex: number // 参数


  build() {
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
  }
}