@Builder function overBuilder() {}

@Component
struct Child {
  @Builder doNothingBuilder() {};

  // 使用自定义组件的自定义构建函数初始化@BuilderParam
  @BuilderParam customBuilderParam: () => void = this.doNothingBuilder;
  // 使用全局自定义构建函数初始化@BuilderParam
  @BuilderParam customOverBuilderParam: () => void = overBuilder;
  build(){}
}