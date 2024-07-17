import { OrderType } from 'common';
import { PersonalConstants } from '../constants/PersonalConstants';
import { IconButtonModel } from '../viewmodel/IconButtonModel';
@Component
export struct IconButton {
  @ObjectLink props: IconButtonModel;
  click?: (key: OrderType) => void = () => {};

  build() {
    Column() {
      if (this.props.count) {
        Badge({
          value: `${this.props.count}`,
          style: { color: Color.White, badgeSize: PersonalConstants.BADGE_SIZE, badgeColor: Color.Red }
        }) {
          Image(this.props.icon)
            .width($r('app.float.icon_size'))
            .height($r('app.float.icon_size'))
        }
        .width($r('app.float.icon_size'))
        .height($r('app.float.icon_size'))
      } else {
        Image(this.props.icon)
          .width($r('app.float.icon_size'))
          .height($r('app.float.icon_size'))
      }
      Text(this.props.text)
        .fontSize($r('app.float.vp_twelve'))
        .fontColor(Color.Black)
        .margin({ top: $r('app.float.vp_twelve') })
    }
    .height($r('app.float.vp_fifty_six'))
    .onClick(() => {
      if (this.click !== undefined && this.props.key !== undefined) {
        this.click(this.props.key);
      }
    })
  }
}