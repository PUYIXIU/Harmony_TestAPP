/**
 * 图标导航组件
 */
import router from '@ohos.router';
import { popMsg } from '../common/utils/msg';
import { global } from '../config/theme';

@Component
export struct IcoNavComp {

  /**
   * 父子组件需要双向同步的变量
   * 父组件：
   *  @Status name:String = 'jack'
   *  ChildCom({name_link:$name}) // 需要用$装饰
   * 子组件：
   *  @Link name_link:string
  */
  @Link list: Array<Object>;
  build(){
    Grid(){
      ForEach(this.list, (item)=>{
        GridItem(){
          Column(){
            if(item && item['ico']){
              Image(item['ico']).height(32).objectFit(ImageFit.Contain).margin({top:15})
            }
            if(item && item['text']){
              Text(item['text']).fontSize(12).margin({top:5}).fontWeight(FontWeight.Bold).fontColor(global.navToolBarColor)
            }
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .onClick(()=>{
          if(item && item['url']){
            router.pushUrl({
              url: item['url'],
              params: item['params'],
            })
          } else{
            popMsg('暂未实现')
          }
        })
      })
    }
    .columnsTemplate(`1fr 1fr 1fr 1fr 1fr`)
    .columnsGap(10)
    .rowsGap(10)
    .width('100%')
    .height(80)
    .backgroundColor(global.navMenuColor)
  }
}