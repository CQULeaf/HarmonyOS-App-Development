export class Cal24Model {
  private ops: string[] = ["+", "-", "*", "/"];
  private operatorSeq: Array<string> = []; // 操作符处理顺序
  private dataSeq: Array<number[]> = []; // 数据处理顺序
  private results: Array<string> = []; // 计算结果
  private data: number[] = [];

  private getDataSeq(): Array<number[]> {
    this.dataSeq = []; // Clear previous data sequences
    for (let i = 0; i < 4; i++) {
      for (let j = 0; j < 4; j++) {
        for (let k = 0; k < 4; k++) {
          for (let m = 0; m < 4; m++) {
            if (i != j && i != k && i != m && j != k && j != m && k != m) {
              let temp: number[] = [this.data[i], this.data[j], this.data[k], this.data[m]];
              this.dataSeq.push(temp);
            }
          }
        }
      }
    }
    return this.dataSeq;
  }

  private getOperatorSeq(): Array<string> {
    this.operatorSeq = []; // Clear previous operator sequences
    for (let i = 0; i < 4; i++) {
      for (let j = 0; j < 4; j++) {
        for (let k = 0; k < 4; k++) {
          let temp: string = this.ops[i] + this.ops[j] + this.ops[k];
          this.operatorSeq.push(temp);
        }
      }
    }
    return this.operatorSeq;
  }

  private fun2Num(x: number, y: number, op: string): number {
    let res: number = 0;
    switch (op) {
      case "+":
        res = x + y;
        break;
      case "-":
        res = x - y;
        break;
      case "*":
        res = x * y;
        break;
      case "/":
        res = y == 0 ? NaN : x / y;
        break;
    }
    return res;
  }

  private doCalculate(data: number[], op: string): boolean {
    let flag = false;

    let res1 = this.fun2Num(this.fun2Num(this.fun2Num(data[0], data[1], op[0]), data[2], op[1]), data[3], op[2]);
    if (res1 === 24) {
      let temp = `((${data[0]}${op[0]}${data[1]})${op[1]}${data[2]})${op[2]}${data[3]} = 24`;
      this.results.push(temp);
      flag = true;
    }

    let res2 = this.fun2Num(this.fun2Num(data[0], data[1], op[0]), this.fun2Num(data[2], data[3], op[2]), op[1]);
    if (res2 === 24) {
      let temp = `(${data[0]}${op[0]}${data[1]})${op[1]}(${data[2]}${op[2]}${data[3]}) = 24`;
      this.results.push(temp);
      flag = true;
    }

    let res3 = this.fun2Num(this.fun2Num(data[0], this.fun2Num(data[1], data[2], op[1]), op[0]), data[3], op[2]);
    if (res3 === 24) {
      let temp = `(${data[0]}${op[0]}(${data[1]}${op[1]}${data[2]}))${op[2]}${data[3]} = 24`;
      this.results.push(temp);
      flag = true;
    }

    let res4 = this.fun2Num(data[0], this.fun2Num(this.fun2Num(data[1], data[2], op[1]), data[3], op[2]), op[0]);
    if (res4 === 24) {
      let temp = `${data[0]}${op[0]}((${data[1]}${op[1]}${data[2]})${op[2]}${data[3]}) = 24`;
      this.results.push(temp);
      flag = true;
    }

    let res5 = this.fun2Num(data[0], this.fun2Num(data[1], this.fun2Num(data[2], data[3], op[2]), op[1]), op[0]);
    if (res5 === 24) {
      let temp = `${data[0]}${op[0]}(${data[1]}${op[1]}(${data[2]}${op[2]}${data[3]})) = 24`;
      this.results.push(temp);
      flag = true;
    }

    return flag;
  }

  private cal24() {
    this.results = []; // Clear previous results
    for (let ii = 0; ii < this.dataSeq.length; ii++) {
      let tmp: number[] = this.dataSeq[ii];
      for (let jj = 0; jj < this.operatorSeq.length; jj++) {
        let op: string = this.operatorSeq[jj];
        this.doCalculate(tmp, op);
      }
    }
  }

  cal(nums: number[]): void {
    this.data = nums;
    this.getDataSeq();
    this.getOperatorSeq();
    this.cal24();
  }

  getResults(): Array<string> {
    // 过滤掉重复的结果
    this.results = this.results.filter((item, index, self) => {
      return self.indexOf(item) === index;
    });
    return this.results;
  }
}
