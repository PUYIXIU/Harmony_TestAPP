import promptAction from '@ohos.promptAction'
export function popMsg(msg){
  promptAction.showToast({
    message:msg,
    bottom:500,
    duration: 2 * 1000
  })
}