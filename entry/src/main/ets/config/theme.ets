// 首页底部导航栏配置
export const menu = {
  toolbar: [
    {
      text: 'HOME',
      ico: $r('app.media.home'),
      url: 'pages/HomePage',
      num: 0
    },
    {
      text: 'HOT',
      ico: $r('app.media.heart'),
      url: 'pages/Hot/indexPage',
      num: 1
    },
    {
      text: 'MY',
      ico: $r('app.media.user'),
      url: 'pages/MinePage',
      num: 2
    }
  ],
  menuList: [
    {
      ico: $r('app.media.coffeeCup'),
    },
    {
      ico: $r('app.media.candyIcon'),
    },
    {
      ico: $r('app.media.donateIcon'),
    },
  ]
}
// 字体配置
export const globalFont = {
  // ch_normal:$rawfile('../common/font/AlibabaHealthFont2.0CN-45R.ttf')
}
// 全局页面配置
export const global = {
  logo: $r('app.media.toby'),

  whiteColor: '#fff', // 白色
  bodyBackgroundColor: '#b2a496', // 背景色
  navMenuColor: '#dde5b6', // 头栏颜色
  navToolBarColor: '#886e58', // 工具栏颜色
  mainTextColor: '#735238', // 正常字体
  secondTextColor: '#ff734138', // 字体颜色2
  lightTextColor: '#ffdddac1', // 浅色字体

  brownLinear: [
    '#7f4f24',
    '#936639',
    '#a68a64',
    '#b6ad90',
    '#c2c5aa',
    '#a4ac86',
    '#656d4a',
  ],
}
// 首页配置
export const home = {
  title: 'HOME',
  subTitle: 'Welcome Back!'
}
// 热门配置
export const hot = {
  title: 'HOT',
  subTitle: 'NEWS TOPIC'
}
// 我的配置
export const mine = {
  title: 'ACCOUNT',
  subTitle: 'TAKE CHANGE',
  navList: [
    {
      text: 'FRUIT',
      ico: $r('app.media.qiyiIcon'),
      color: global.lightTextColor,
      num: 0
    },
    {
      text: 'DONATE',
      ico: $r('app.media.donateIcon'),
      color: global.navToolBarColor,
      num: 1
    },
    {
      text: 'DIET',
      ico: $r('app.media.nygIcon'),
      color: global.mainTextColor,
      num: 2
    },
    {
      text: 'VEG',
      ico: $r('app.media.tomatoIcon'),
      color: global.secondTextColor,
      num: 3
    },
  ],
  menuList: [
    {
      text: 'Edit',
      ico: $r('app.media.eggIcon'),
      url: '',
      num: 0,
      color: '',
    },
    {
      text: 'Problem',
      ico: $r('app.media.pizzaIcon'),
      url: '',
      num: 1,
    },
    {
      text: 'About',
      ico: $r('app.media.hmgIcon'),
      url: '',
      num: 2,
    },
    {
      text: 'Setting',
      ico: $r('app.media.lemonIcon'),
      url: '',
      num: 3,
    },
  ]
}
//登录页配置
export const login = {
  title: {
    text: 'Login',
    size: '20fp',
    color: global.mainTextColor
  },
  subtitle: {
    text: 'Harmony Demo',
    size: 21
  }
}