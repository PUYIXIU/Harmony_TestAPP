/**
 * 登录页面
 */
import { global } from '../config/theme'
import MediaQueryModel from '../model/MediaQueryModel'
import { LoginComp } from '../view/LoginComponent'
import { PrivacyStatementComponent } from '../view/PrivacyStatementComponent'

@Entry
@Component
struct LoginPage {
  // 组件即将出现
  aboutToAppear() {
    MediaQueryModel.register()
  }

  aboutToDisappear() {
    MediaQueryModel.unRegister()
  }

  // 显示标题
  @Builder
  renderTitle() {
    Row() {

    }
    .width('100%')
    .height('56vp')
    .backgroundColor(global.navToolBarColor)
  }

  build() {
    Column() {
      this.renderTitle()
      Scroll() {
        Column() {
          LoginComp()

          Blank()

          PrivacyStatementComponent()
        }
        .height('100%')
        .constraintSize({ minHeight: '304vp' })
        .alignItems(HorizontalAlign.Start)
        .padding('24vp')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(global.lightTextColor)
  }
}