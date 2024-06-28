import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
// 生命周期
export default class EntryAbility extends UIAbility {
  // 页面初始化 UIAbility实例创建
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }
  // 销毁
  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  // WindowStage创建 UI加载，WindowStage事件订阅
  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 事件订阅
    try{
      windowStage.on('windowStageEvent',(data)=>{
        let stageEventType:window.WindowStageEventType = data;
        switch(stageEventType){
          case window.WindowStageEventType.SHOWN: // 切换到前台
            console.info("windowStage foreground");
            break;
          case window.WindowStageEventType.ACTIVE: // 聚焦状态
            console.info("windowStage active");
            break;
          case window.WindowStageEventType.INACTIVE: // 失焦状态
            console.info("windowStage inactive");
            break;
          case window.WindowStageEventType.HIDDEN: // 切换后台
            console.info("windowStage background");
            break;
          default:
            break;
        }
      })
    }catch(exception){
      console.error('Failed to enable the listener for window stage event changes. Cause:' + JSON.stringify(exception))
    }

    // 设置要加载页面
    windowStage.loadContent('pages/HomePage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

}
