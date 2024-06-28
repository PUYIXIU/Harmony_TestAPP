import router from '@ohos.router';
import { popMsg } from '../common/utils/msg';
import { global } from '../config/theme';
@Observed
export class ExtListItem{
  cover: string | PixelMap | Resource; // 背景图
  title: string | Resource; // 标题
  subTitle: string | Resource; // 子标题
  url: string; // 链接
  params: Object; // 参数

  constructor(
    cover: string | PixelMap | Resource, // 背景图
    title: string | Resource, // 标题
    subTitle: string | Resource, // 子标题
    url: string, // 链接
    params: Object, // 参数
  ){
    this.cover = cover
    this.title = title
    this.subTitle = subTitle
    this.url = url
    this.params = params
  }
}

/**
 * 列表行组件（水平布局）
 */
@Component
export struct HorizontalListItemComp {
  @ObjectLink item: ExtListItem;

  build(){
    Row(){
      if(this.item?.cover){
        Image(this.item.cover).height(64).objectFit(ImageFit.Contain)
      }
      Column(){
        if(this.item?.title){
          Text(this.item.title)
            .margin({top:5})
            .fontWeight(FontWeight.Bold)
            .fontSize(16)
            .fontColor(global.mainTextColor)
        }
        if(this.item?.subTitle){
          Text(this.item.subTitle)
            .margin({top:5})
            .fontSize(14)
            .fontColor(global.navToolBarColor)
            .fontStyle(FontStyle.Italic)
        }
      }
      .height(64)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .margin({left:5})
    }
    .width('100%')
    .margin({top:5, left:10, right:10, bottom:5})
    .onClick(()=>{
      if(this.item && this.item.url){
        router.pushUrl({
          url: this.item.url,
          params: this.item.params
        })
      }else{
        popMsg('暂未实现')
      }
    })

  }
}

@Component
export struct VerticalListItemComp{
  @ObjectLink item : ExtListItem ;

  build(){
    Column(){
      Column(){
        if(this.item?.cover){
          Image(this.item.cover)
            .width('80%')
            .objectFit(ImageFit.Contain)
        }
        if(this.item?.title){
          Text(this.item.title)
            .margin({top:5})
            .fontWeight(FontWeight.Bold)
            .fontSize(16)
            .fontColor(global.mainTextColor)
        }
        if(this.item?.subTitle){
          Text(this.item.subTitle)
            .margin({top:5})
            .fontStyle(FontStyle.Italic)
            .fontSize(14)
            .fontColor(global.bodyBackgroundColor)
        }
      }
    }
    .width('48%')
    .margin(2)
    .padding(2)
    .borderRadius(10)
    .backgroundColor(global.whiteColor)
    .onClick(()=>{
      if(this.item?.url){
        router.pushUrl({
          url:this.item.url,
          params:this.item.params
        })
      }else{
        popMsg('暂未实现')
      }
    })
  }
}