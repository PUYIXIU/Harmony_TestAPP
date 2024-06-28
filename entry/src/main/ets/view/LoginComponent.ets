/**
 * 登录组件
 */
import router from '@ohos.router'
import { getCodeImg, getLogin } from '../api/login'
import { CommonConstants } from '../common/constants/CommonConstants'
import { setToken } from '../common/store'
import { UserState } from '../common/store/UserState'
import { Log } from '../common/utils/Log'
import { globalConfig } from '../config/setting'
import { global, login } from '../config/theme'

@Component
export struct LoginComp {
  @StorageProp('isMinHeight') isMinHeight: boolean = false
  @State userName: string = ''
  @State password: string = ''
  @State captchaEnabled: boolean = true
  @State codeUrl: string = ''
  @State uuid: string = ''
  @State captchaCode: string = ''
  @State loading: boolean = false

  aboutToAppear() {
    this.captchaEnabled = globalConfig.captchaEnabled
    this.getCaptchaCode()
  }

  // 获取二维码
  getCaptchaCode() {
    if (this.captchaEnabled) {
      Log.info('获取二维码')
      getCodeImg().then((res: any) => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          this.codeUrl = 'data:image/gif;base64,' + res.img;
          this.uuid = res.uuid
        }
      })
    }
  }

  // 渲染用户名称
  @Builder
  renderUserName() {
    TextInput({ placeholder: 'Account Name' })
      .width('100%')
      .height('48vp')
      .placeholderColor(global.lightTextColor)
      .placeholderFont({ size: '16fp' })
      .backgroundColor(global.bodyBackgroundColor)
      .fontSize('16fp')
      .onChange((value: string) => {
        this.userName = value
      })
  }

  // 渲染用户密码
  @Builder
  renderPassword() {
    TextInput({ placeholder: 'password' })
      .width('100%')
      .height('48vp')
      .placeholderColor(global.lightTextColor)
      .placeholderFont({ size: '16fp' })
      .backgroundColor(global.bodyBackgroundColor)
      .fontSize('16fp')
      .type(InputType.Password)
      .onChange((value: string) => {
        this.password = value;
      })
      .margin({ top: 10 })
  }

  @Builder
  renderCaptcha() {
    GridRow() {
      GridCol({
        span: 6
      }) {
        TextInput({ placeholder: 'code' })
          .width('100%')
          .height($r('app.float.text_input_height'))
          .placeholderColor(global.lightTextColor)
          .placeholderFont({ size: $r('app.float.text_input_font_size') })
          .fontSize($r('app.float.text_input_font_size'))
          .backgroundColor(global.bodyBackgroundColor)
          .margin({ bottom: $r('app.float.input_margin_bottom') })
          .onChange((value: string) => {
            this.captchaCode = value;
          })
      }

      GridCol({
        span: 6
      }) {
        Image(this.codeUrl).height(50).onClick(() => {
          this.getCaptchaCode()
        })
      }
    }.margin({ top: 10 })
  }

  // 判断是否可以登陆
  isLoginButtonClickable(): boolean {
    if (this.loading) return false
    return this.userName !== '' && this.password !== '' && this.captchaCode != '';
  }
  // 登录按钮
  @Builder
  renderLoginBtn() {
    Button() {
      Row() {
        if (this.loading) {
          Image($r('app.media.loading'))
            .width(40)
            .height(40)
            .margin({ right: 5 })
          Text('Login...').fontSize($r('app.float.text_input_font_size'))
            .fontWeight(CommonConstants.LOGIN_TEXT_FONT_WEIGHT)
            .fontColor(this.isLoginButtonClickable() ? Color.White : $r('app.color.login_font_normal'))
            .fontWeight(FontWeight.Bold)
        } else {
          Text('Login')
            .fontSize($r('app.float.text_input_font_size'))
            .fontWeight(CommonConstants.LOGIN_TEXT_FONT_WEIGHT)
            .fontColor(this.isLoginButtonClickable() ? Color.White : $r('app.color.login_font_normal'))
            .fontWeight(FontWeight.Bold)
        }
      }.alignItems(VerticalAlign.Center)
    }
    .width(CommonConstants.BUTTON_WIDTH_PERCENT)
    .height($r('app.float.login_btn_height'))
    .borderRadius($r('app.float.login_btn_border_radius'))
    .margin({ top: $r('app.float.register_btn_margin_top') })
    .enabled(this.isLoginButtonClickable())
    .backgroundColor(this.isLoginButtonClickable() ? global.mainTextColor : global.navToolBarColor)
    .onClick(() => {
      this.loading = true
      getLogin(this.userName, this.password, this.captchaCode, this.uuid).then((res: any) => {
        setToken(res.token);
        //缓存token
        //获取用户信息
        let userState = new UserState();
        userState.loadUserInfo().then((res: any) => {
          Log.info('加载登录用户信息成功')
          this.loading = false;
          router.pushUrl({
            url: CommonConstants.HOME_PAGE_URL
          });
        }).catch(e => {
          this.loading = false;
        });
      }).catch(e => {
        this.loading = false;
      })
    })
  }

  build() {
    Column() {
      Row() {
        Image(global.logo).width(35).height(35).margin({ right: 10 });
        Text(login.subtitle.text)
          .fontSize(login.subtitle.size)
          .backgroundColor(global.mainTextColor)
          .fontColor('#fff')
          .fontWeight(FontWeight.Bold)
          .padding(5)
      }
      .justifyContent(FlexAlign.Center)
      .padding(10)
      .border({ style: BorderStyle.Solid, width: 5, color: global.mainTextColor })
      .margin({ top: 80, bottom: 50 })

      GridRow({
        columns: {
          sm: CommonConstants.GRID_ROW_SM,
          md: CommonConstants.GRID_ROW_MD,
          lg: CommonConstants.GRID_ROW_LG
        },
        gutter: { x: CommonConstants.GUTTER_X },
        breakpoints: { value: CommonConstants.BREAK_POINT }
      }) {
        // 表单
        GridCol({
          span: {
            sm: CommonConstants.SPAN_SM,
            md: CommonConstants.SPAN_MD,
            lg: CommonConstants.SPAN_LG
          },
          offset: {
            sm: CommonConstants.OFFSET_SM,
            md: CommonConstants.OFFSET_MD,
            lg: CommonConstants.OFFSET_LG
          }
        }) {
          Column() {
            // 用户名
            this.renderUserName()
            // 密码
            this.renderPassword()
            // 验证码
            this.renderCaptcha()
          }
        }

        // 登录按钮
        GridCol({
          span: {
            sm: CommonConstants.BUTTON_SPAN_SM,
            md: this.isMinHeight ? CommonConstants.BUTTON_SPAN_MD_SMALL : CommonConstants.BUTTON_SPAN_MD_BIG,
            lg: CommonConstants.BUTTON_SPAN_LG
          },
          offset: {
            sm: CommonConstants.BUTTON_OFFSET_SM,
            md: CommonConstants.BUTTON_OFFSET_MD,
            lg: CommonConstants.BUTTON_OFFSET_LG
          }
        }) {
          this.renderLoginBtn()
        }

      }

    }
  }
}