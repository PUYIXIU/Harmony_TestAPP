// 媒体查询监听器
import MediaQuery from '@system.mediaquery'
import mediaQuery from '@ohos.mediaquery'

class MediaQueryModel {
  // 设置媒体查询条件
  private listener = mediaQuery.matchMediaSync(`(height <= 360vp)`)

  private onPortrait(mediaQueryResult: mediaQuery.MediaQueryResult): void {
    AppStorage.Set<boolean>('isMinHeight', mediaQueryResult.matches)
  }

  public register(): void {
    let portraitFunc = this.onPortrait.bind(this)
    this.listener.on('change', portraitFunc)
  }

  public unRegister(): void {
    let portraitFunc = this.onPortrait.bind(this)
    this.listener.off('change', portraitFunc)
  }
}

let mediaQueryModel = new MediaQueryModel();

export default mediaQueryModel as MediaQueryModel