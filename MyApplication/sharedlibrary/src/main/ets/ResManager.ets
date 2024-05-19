export class ResManager{
  static getPic(): Resource{
    return $r('app.media.setting');
  }
  static getDesc(): Resource{
    return $r('app.string.shared_desc');
  }
}