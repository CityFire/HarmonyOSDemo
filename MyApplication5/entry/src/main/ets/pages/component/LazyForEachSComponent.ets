class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];
  private originDataArray: string[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): string {
    return this.originDataArray[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}

class MyDataSource extends BasicDataSource {
  dataArray: string[] = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): string {
    return this.dataArray[index];
  }

  // 添加数据
  public addData(index: number, data: string): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  // 添加数据
  public pushData(data: string): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  // 删除数据
  public deleteData(index: number): void {
    this.dataArray.splice(index, 1);
    this.notifyDataDelete(index);
  }

  // 改变多个数据
  public changeData_(index: number): void {
    this.notifyDataChange(index);
  }

  public reloadData(): void {
    this.notifyDataReload();
  }

  public modifyAllData(): void {
    this.dataArray = this.dataArray.map((item: string) => {
      return item + '0';
    })
  }

  // 交换数据
  public moveData(from: number, to: number): void {
    let temp: string = this.dataArray[from];
    this.dataArray[from] = this.dataArray[to];
    this.dataArray[to] = temp;
    this.notifyDataMove(from, to);
  }

  // 改变单个数据
  public changeData(index: number, data: string): void {
    this.dataArray.splice(index, 1, data);
    this.notifyDataChange(index);
  }
}

@Entry
@Component
struct MyComponent {
  private moved: number[] = [];
  private data: MyDataSource = new MyDataSource();

  aboutToAppear() {
    for (let i = 0; i <= 20; i++) {
      this.data.pushData(`Hello ${i}`)
    }
  }

  build() {
    List({ space: 3 }) {
      LazyForEach(this.data, (item: string, index: number) => {
        ListItem() {
          Row() {
            Text(item).fontSize(50)
              .onAppear(() => {
                console.info("appear:" + item)
              })
          }.margin({ left: 10, right: 10 })
        }
        .onClick(() => {
          // 点击追加子组件
          // this.data.pushData(`Hello ${this.data.totalCount()}`);
          
          // 点击删除子组件
          // this.data.deleteData(this.data.dataArray.indexOf(item));
          // 重置所有子组件的index索引
          // this.data.reloadData();

          /*
          // 交换数据
          this.moved.push(this.data.dataArray.indexOf(item));
          if (this.moved.length === 2) {
            // 点击移动子组件
            this.data.moveData(this.moved[0], this.moved[1]);
            this.moved = [];
          }
          */

          // 改变单个数据
          // this.data.changeData(index, item + '00');

          // 改变多个数据
          this.data.modifyAllData();
          this.data.reloadData();
        })
      }, (item: string, index: number) => item + index.toString())
    }.cachedCount(5)
  }
}