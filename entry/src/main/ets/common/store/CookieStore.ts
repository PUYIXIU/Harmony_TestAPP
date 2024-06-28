import { Log } from '../utils/Log'

const TokenKey = 'Admin-Token'
/**
 * Cookie数据库
 */
export default class CookieStore {
  static setToken(token: string) {
    try {
      Log.info('CookieStore保存token')
      AppStorage.SetOrCreate<string>(TokenKey, token)
    } catch (e) {
      Log.error(`CookieStore保存token发生异常. Code:${e.code},message:${e.message}`);
    }
  }

  static getToken() {
    try {
      Log.info('CookieStore获取token')
      return AppStorage.Get<string>(TokenKey)
    } catch (e) {
      Log.error(`CookieStore获取token发生异常. Code:${e.code},message:${e.message}`);
    }
  }

  static deleteToken() {
    try {
      Log.info('CookieStore删除token')
      AppStorage.Delete(TokenKey)
      PersistentStorage.DeleteProp(TokenKey)
    } catch (e) {
      Log.error(`CookieStore删除token发生异常. Code:${e.code},message:${e.message}`);
    }
  }
}