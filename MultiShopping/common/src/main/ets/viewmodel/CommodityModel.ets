
export class KV {
  key: string = '';
  value: string = '';
  image?: string = ''
}

export class Specification {
  id: string = '';
  title: string = '';
  data: KV[] = [];
}

export class Commodity {
  category_id?: string = '';
  id: string = '';
  title: string = '';
  promotion?: string = '';
  description: string = '';
  images: string[] = [];
  detail?: string[] = [];
  price: number = 0;
  specifications?: Specification[] = [];
}

export class Opt {
  yy: string = '';
  mm: string = '';
  dd: string = '';
  HH: string = '';
  MM: string = '';
  SS: string = '';
}

export class InsertOrderParams {
  orderId: string = '';
  uid: string = '';
  status: number = 0;
  createTime: string = '';
}
