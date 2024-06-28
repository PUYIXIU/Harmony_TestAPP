import { getToken, getUserState, setToken, setUserState } from '.'
import { getInfo } from '../../api/login'
import { globalConfig } from '../../config/setting'
import { Log } from '../utils/Log'

export class UserState {
  token: any
  name: string
  avatar: string
  roles: any[]
  permissions: string[]

  constructor() {
    this.token = getToken()
  }

  // 加载用户信息
  async loadUserInfo() {
    try {
      let res: any = await getInfo()
      this.load(this, res)
      setUserState(this);
      Log.info('加载登录用户信息成功', JSON.stringify(res))
    } catch (e) {
      Log.error('加载登录用户信息发生异常', e)
    }
  }

  // 刷新登录用户信息
  async refreshUserInfo() {
    try {
      let res: any = await getInfo()
      this.load(this, res)
      Log.info('刷新登录用户信息成功', JSON.stringify(res))
    } catch (e) {
      Log.error('刷新登录用户信息发生异常', e)
    }
  }

  // 注销当前登录用户
  logout() {
    setToken('')
    let userState = getUserState()
    if (userState) {
      userState.clear()
    }
  }

  // 加载用户数据
  private load(userState: UserState, res: any) {
    const user = res.user
    const avatar = user.avatar === '' || user.avatar == null ? '' : globalConfig.baseUrl + user.avatar
    if (res.roles && res.roles.length > 0) {
      // roles非空数组
      userState.roles = res.roles
      userState.permissions = res.permissions
    } else {
      userState.roles = ['ROLE_DEFAULT']
    }
    userState.name = user.userName
    userState.avatar = avatar
  }

  clear() {
    this.token = ''
    this.name = ''
    this.avatar = ''
    this.roles = null
    this.permissions = null
  }
}