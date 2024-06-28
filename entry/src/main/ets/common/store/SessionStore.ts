/**
 * Cookie数据库
 */
import { Log } from '../utils/Log'

export default class SessionStore {

  // 设置数据
  static set(key: string, val: any) {
    try {
      // AppStorage 程序启动时创建
      AppStorage.SetOrCreate<any>(key, val)
      // PersistentStorage 存储进次磁盘的数据
      PersistentStorage.PersistProp<any>(key, val)
    } catch (e) {
      Log.error(`sessionStore保存数据发生异常. Code:${e.code}, message:${e.message}`)
    }
  }

  // 获取数据
  static get(key: string): any {
    try {
      return AppStorage.Get<any>(key);
    } catch (e) {
      Log.error(`sessionStore获取数据发生异常. Code:${e.code}, message:${e.message}`)
    }
  }

  // 移除数据
  static remove(key: string) {
    try {
      AppStorage.Delete(key);
      PersistentStorage.DeleteProp(key)
    } catch (e) {
      Log.error(`sessionStore删除数据发生异常. Code:${e.code}, message:${e.message}`)
    }
  }
}