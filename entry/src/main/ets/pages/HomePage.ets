/**
 * 主页
 */
import router from '@ohos.router';
import { popMsg } from '../common/utils/msg';
import { global, home, menu } from '../config/theme';
import { IcoNavComp } from '../view/IcoNavComponent';
import { TitleBar, TitleBarComp } from '../view/TitleBarComponent';
import { ExtListItem, HorizontalListItemComp, VerticalListItemComp } from '../view/ListItemComponent';
import { NavTitleComp } from '../view/NavTitleComponent';
import { NavFootComp } from '../view/NavFootComponent';
import { validLogin } from '../common/utils/auth';

@Entry // 作为UI页面入口
@Component // 将实现build的struct组件化
struct HomePage {
  private swiperController: SwiperController = new SwiperController()
  private scroller: Scroller = new Scroller();
  @State tools: Array<Object> = menu.toolbar // 底部栏

  @State currentIndex: number = 0 //
  // 轮播图
  @State advList: Array<Object> = [
    { img: $r("app.media.banner1") },
    { img: $r("app.media.banner2") },
    { img: $r("app.media.banner3") },
  ]
  // 中间模块选项
  @State icoNavList: Array<Object> = [
    {
      text: "Order",
      ico: $r("app.media.orderIcon"),
      url: ''
    },
    {
      text: "Bread",
      ico: $r("app.media.breadIcon"),
      url: ''
    },
    {
      text: "Coffee",
      ico: $r("app.media.coffeeIcon"),
      url: ''
    },
    {
      text: "Milk",
      ico: $r("app.media.milkIcon"),
      url: ''
    },
    {
      text: "Cake",
      ico: $r("app.media.cakeIcon"),
      url: ''
    },
  ]

  // 今日推荐消息数据
  @State newsList: Array<ExtListItem> = [
    new ExtListItem($r("app.media.eggIcon"), "News1 ", 'xxx', '', {}),
    new ExtListItem($r("app.media.kiwi"), "News2 ", 'xxx', '', {}),
  ]

  // 今日热门消息数据
  @State topicList: Array<ExtListItem> = [
    new ExtListItem($r("app.media.eggIcon"), "News1 ", 'xxx', '', {}),
    new ExtListItem($r("app.media.kiwi"), "News2 ", 'xxx', '', {}),
  ]
  @State title: string = home.title;
  @State subTitle: string = home.subTitle;
  @State menuList: Array<Object> = menu.menuList;

  // 页面显示触发
  onPageShow() {
    validLogin()
  }

  // 自定义组件 显示轮播图
  @Builder
  renderSwiper() {
    Column() {
      Swiper(this.swiperController) {
        ForEach(this.advList, (item, index) => {
          Image(item.img).width(`100%`).objectFit(ImageFit.Contain)
        })
      }
      .autoPlay(true)
    }.width('100%')
  }

  // 显示图标导航
  @Builder
  renderIcoNav() {
    IcoNavComp({ list: $icoNavList })
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

  // 自定义标题
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

  // 今日推荐板块
  @Builder
  renderRecommend() {
    // space：内容间隔
    List({ space: 2, initialIndex: 0 }) {
      // 头部标题栏
      ListItem() {
        TitleBarComp({
          titleBar: new TitleBar(
            $r('app.media.heart'), // 图标
            global.lightTextColor, // 图标颜色
            'Today Recommend', // 标题
            global.lightTextColor, //标题颜色
            true, // 显示更多
            '', // 跳转url
            null // 跳转传参
          )
        })
      }
      .backgroundColor(global.navToolBarColor)

      ForEach(this.newsList, (item) => {
        ListItem() {
          // 循环内不用加$
          HorizontalListItemComp({ item: item as ExtListItem })
        }
        .backgroundColor("#fff")
        .onClick(() => {
          popMsg('暂未实现')
        })
      })
    }
    .width('95%')
    .borderRadius(10)
    .margin({ top: 10, bottom: 10 })
  }

  // 今日热点模块
  @Builder
  renderTopic() {
    Column({ space: 5 }) {
      Row() {
        TitleBarComp({
          titleBar: new TitleBar(
            $r('app.media.hot'), // 图标
            global.mainTextColor, // 图标颜色
            'Current Hot', // 标题
            global.mainTextColor, //标题颜色
            true, // 显示更多
            '', // 跳转url
            null // 跳转传参
          )
        })
          .backgroundColor(global.lightTextColor)
          .borderRadius(5)
      }
      .justifyContent(FlexAlign.Start)

      Flex({
        wrap: FlexWrap.Wrap,
        justifyContent: FlexAlign.SpaceBetween
      }) {
        ForEach(this.topicList, (item) => {
          VerticalListItemComp({ item: item })
        })
      }
    }
    .width('95%')
    .margin({ bottom: 10 })
  }

  build() {
    // 路由容器组件
    Navigation() {
      Column() {
        Scroll(this.scroller) {
          Column() {
            this.renderSwiper()
            this.renderIcoNav()
            this.renderRecommend()
            this.renderTopic()
          }
        }
      }
      .backgroundColor(global.bodyBackgroundColor)
      .height('100%')
      .width('100%')
    }
    .mode(NavigationMode.Auto) // 自动分栏格式
    .titleMode(NavigationTitleMode.Free) // 界面名称-操作入口
    .title(this.renderTitle())
    .hideBackButton(true)
    .size({ width: '100%', height: '100%' }) // 尺寸
    // .menus(menuBtns) // 菜单
    .toolBar(this.renderToolbar()) // 底部菜单

  }
}