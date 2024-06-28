/**
 * 个人信息界面
 */
import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'
import { getUserState } from '../common/store'
import { UserState } from '../common/store/UserState'
import { Log } from '../common/utils/Log'
import { global, menu, mine } from '../config/theme'
import { NavFootComp } from '../view/NavFootComponent'
import { NavTitleComp } from '../view/NavTitleComponent'

@Entry
@Component
struct MinePage {
  @State user: UserState = null; // 用户信息
  @State navList: Array<Object> = mine.navList // 内部横向菜单
  @State rowMenuList: Array<Object> = mine.menuList // 内部列项菜单
  @State total: number = 100
  @State progress: number = 0
  @State currentIndex: number = 2
  @State title: string = mine.title
  @State subTitle: string = mine.subTitle
  @State menuList: Array<Object> = menu.menuList
  @State loading: boolean = false;

  // 初始化钩子函数
  aboutToAppear() {
    this.getUserInfo()
  }

  getUserInfo() {
    let userState = getUserState()
    Log.info('获取当前登录人信息成功', JSON.stringify(userState))
    this.user = userState
  }

  // 标题头
  @Builder
  renderHeadTitle() {
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

  // 个人信息
  @Builder
  renderProfile() {
    Row() {
      // 左侧头像+名称
      Column() {
        // 加载中
        if (this.loading) {
          // 显示环形进度条
        } else {
          Image(this.user?.avatar ? this.user?.avatar : $r('app.media.toby'))
            .width($r('app.float.user_profile_image_width'))
            .height($r('app.float.user_profile_image_height'))
            .objectFit(ImageFit.Contain)
            .borderRadius(100)
            .onClick(() => {

            })
        }
        Text(this.user ? this.user.name : 'Login')
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 7 })
          .fontSize(16)
          .width('100%')

      }
      .width('100%')
      // .height('70%')
      .padding({ top: 20 })
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

    }
    .width('100%')
    .height('28%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Top)
    .backgroundColor(global.navMenuColor)
  }
  // 导航
  @Builder
  renderNav() {
    Row() {
      ForEach(this.navList, item => {
        Column() {
          Image(item.ico)
            .width(40)
            .height(40)
            .objectFit(ImageFit.Contain)
          Text(item.text)
            .fontColor(item.color)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 5 })
        }
        .width('25%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          if (!item.url) {
            promptAction.showDialog({
              title: 'Tip',
              message: "This function is under Building",
              buttons: [
                {
                  text: 'Close',
                  color: global.mainTextColor
                }
              ]
            }).then((data) => {
              Log.info('关闭')
            })
            return
          }
          router.pushUrl({
            url: item.url
          })
        })
      })
    }
    .width('90%')
    .height(100)
    .backgroundColor(global.bodyBackgroundColor)
    .offset({ y: '-80px' })
    .borderRadius(16)
    .padding({ top: 16, bottom: 16 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
  // 菜单
  @Builder
  renderMenu() {
    Column() {
      List() {
        ForEach(this.rowMenuList, (item, index) => {
          ListItem() {
            Row() {
              Row() {
                Image(item.ico)
                  .height(40)
                  .width(40)
                  .objectFit(ImageFit.Contain)
                Text(item.text)
                  .height('45vp')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 10 })
                  .fontColor(global.whiteColor)
              }
              .width('100%')

              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)

              Image($r('app.media.arrowRight'))
                .width(16)
                .height(16)
                .objectFit(ImageFit.Contain)
                .fillColor(global.whiteColor)
            }
            .padding({
              left: 20,
              right: 40,
              top: 10,
              bottom: 10
            })
            .backgroundColor(global.brownLinear[index % global.brownLinear.length])
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .onClick(() => {
            if (!item.url) {
              promptAction.showDialog({
                title: 'Tip',
                message: 'Function is under building',
                buttons: [
                  {
                    text: 'Close',
                    color: global.mainTextColor
                  }
                ]
              })
                .then((data) => {
                  Log.info('关闭')
                })
              return
            }
            router.pushUrl({
              url: item.url
            })
          })
        })
      }
      .borderRadius(16)
      .divider({
        strokeWidth: 1,
        color: $r('app.color.item_divider')
      })
    }
    .width('90%')
    .padding({})
    .margin({ top: -10 })
  }
  // 页面体
  @Builder
  renderBody() {
    Column() {
      Scroll() {
        GridRow({
          columns: { // 总列数
            sm: CommonConstants.GRID_ROW_SM,
            md: CommonConstants.GRID_ROW_MD,
            lg: CommonConstants.GRID_ROW_LG,
          },
          breakpoints: { value: CommonConstants.BREAK_POINT } // 设备断点
        }) {
          GridCol({
            span: { // 占列数
              sm: CommonConstants.MINE_SPAN_SM,
              md: CommonConstants.MINE_SPAN_MD,
              lg: CommonConstants.MINE_SPAN_LG
            },
            // offset: {
            // lg: CommonConstants.OFFSET_LG
            // }
          }) {
            Column() {
              this.renderProfile()
              this.renderNav()
              this.renderMenu()
            }
          }
        }
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(global.lightTextColor)
  }

  build() {
    Navigation() {
      this.renderBody()
    }
    .title(this.renderHeadTitle())
    .toolBar(this.renderToolbar())
  }
}