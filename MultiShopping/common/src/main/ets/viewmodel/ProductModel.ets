
@Observed
export class Product {
  uid?: string = '';
  id: string = '';
  name: string = '';
  img: string[] = [];
  commodityId: string = '';
  description: string = '';
  price: number = 0;
  count: number = 0;
  selected: boolean = false;
  specifications: ProductSpecification[] = [];
  update_time?: string = '';
  create_time?: string = '';
}

export class ProductSpecification {
  name: string = '';
  value: string = '';
}

export class ShopProps {
  id: string = '';
  commodityId: string = '';
  count: number = 0;
  specifications: ProductSpecification[] = [];
}

export class UpdateShopProps {
  id: string = '';
  count?: number = 0;
  selected?: boolean = false;
  specifications?: ProductSpecification[] = [];
}

export class SelectProducts {
  selected: boolean = false;
  key: string = '';
}