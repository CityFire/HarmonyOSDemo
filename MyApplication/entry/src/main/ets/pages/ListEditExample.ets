import { ToDo } from '../utils/ToDo';
@Entry
@Component
export struct ListEditExample {
  @State toDoData: ToDo[] = [];
  private availableThings: string[] = ['读书', '运动', '旅游', '听音乐', '看电影', '唱歌'];

  onPageShow() {
    this.toDoData.push(new ToDo(this.availableThings[0])); // 新增列表项数据toDoData
    this.toDoData.push(new ToDo(this.availableThings[1])); // 新增列表项数据toDoData
  }

  build() {
    Column() {
      Text('+')
        .onClick(() => {
          TextPickerDialog.show({
            range: this.availableThings,
            onAccept: (value: TextPickerResult) => {
              this.toDoData.push(new ToDo(this.availableThings[value.index])); // 新增列表项数据toDoData
            },
          })
        })

      List({ space: 10 }) {
        ForEach(this.toDoData, (toDoItem) => {
          ListItem() {
            Text(toDoItem).fontSize(24)
          }
        }, toDoItem => toDoItem.key)
      }
    }
  }
}