 /*
@Component
struct Child {
  // 使用父组件@Builder装饰的方法初始化子组件@BuilderParam
  @BuilderParam customBuilderParam: () => void;

  build() {
    Column() {
      this.customBuilderParam()
    }
  }
}

@Entry
@Component
struct Parent {
  @Builder componentBuilder() {
    Text(`Parent builder `)
  }

  build() {
    Column() {
      Child({ customBuilderParam: this.componentBuilder })
    }
  }
}
*/

 /*
 @Component
 struct Child {
   label: string = `Child`
   @BuilderParam customBuilderParam: () => void;

   build() {
     Column() {
       this.customBuilderParam()
     }
   }
 }

 @Entry
 @Component
 struct Parent {
   label: string = `Parent`

   @Builder componentBuilder() {
     Text(`${this.label}`)
   }

   build() {
     Column() {
       this.componentBuilder()
       Child({ customBuilderParam: this.componentBuilder })
     }
   }
 }
 */

 @Builder function overBuilder($$ : {label: string }) {
  Text($$.label)
    .width(400)
    .height(50)
    .backgroundColor(Color.Green)
 }

@Component
struct Child {
  label: string = 'Child'
  // 无参数类型，指向的componentBuilder也是无参数类型
  @BuilderParam customBuilderParam: () => void;
  // 有参数类型，指向的GlobalBuilder1也是有参数类型的方法
  @BuilderParam customOverBuilderParam: ($$ : { label : string}) => void;

  build() {
    Column() {
      this.customBuilderParam()
      this.customOverBuilderParam({label: 'global Builder label' } )
    }
  }
}

@Entry
@Component
struct Parent {
  label: string = 'Parent'

  @Builder componentBuilder() {
    Text(`${this.label}`)
  }

  build() {
    Column() {
      this.componentBuilder()
      Child({ customBuilderParam: this.componentBuilder, customOverBuilderParam: overBuilder })
    }
  }
}
