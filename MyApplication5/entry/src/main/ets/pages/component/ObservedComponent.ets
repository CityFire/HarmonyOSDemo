class ClassA {
  public c: number;

  constructor(c: number) {
    this.c = c;
  }
}

@Observed
class ClassB {
  public a: ClassA;
  public b: number;

  constructor(a: ClassA, b: number) {
    this.a = a;
    this.b = b;
  }
}

@Component
struct ObservedComponent {
  @ObjectLink b: ClassB

  build() {
    // 赋值变化可以被观察到
    // this.b.a = new ClassA(5)
    // this.b.b = 5

    // ClassA没有被@Observed装饰，其属性的变化观察不到
    // this.b.a.c = 5
  }
}