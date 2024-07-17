import { OrderType } from 'common'

@Observed
export class IconButtonModel {
  icon: Resource;
  text: Resource;
  key?: OrderType;
  count?: number;

  constructor(icon: Resource, text: Resource, key?: OrderType, count?: number) {
    this.icon = icon;
    this.text = text;
    this.key = key;
    this.count = count;
  }
}

export class OrderCount {
  payment: number = 0;
  ship: number = 0;
  receipt: number = 0;
  evaluation: number = 0;
  sale: number = 0;
}