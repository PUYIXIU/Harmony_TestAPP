/**
 * 判断是否登录
 */
import router from '@ohos.router'
import { getToken } from '../store'
import { Log } from './Log'

export function validLogin() {
  let token = getToken()
  Log.info('判断是否登录：', token)
  if (!token) {
    router.replaceUrl({
      url: 'pages/LoginPage'
    })
  }
}