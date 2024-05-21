import AbilityStage from '@ohos.app.ability.AbilityStage';

export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    // 应用的HAP在首次加载的时，为该Module初始化操作
    let abilityStageContext = this.context;
  }
  onAcceptWant(want) {
    // 仅specified模式下触发
    return "MyAbilityStage";
  }
  onMemoryLevel(level) {
    // 根据系统可用内存的变化情况，释放不必要的内存
  }
}