export class Logger {
  private domain: number;
  private prefix: string;
  private format: string = `%{public}s, %{public}s`;

  constructor(prefix: string) {
    this.prefix = prefix;
    this.domain = 0xFF00;
  }

  static info(msg: string): void {
    console.info(msg);
  }
}

