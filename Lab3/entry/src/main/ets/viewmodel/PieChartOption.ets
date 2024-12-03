// 定义饼图配置接口
interface GeneratedTypeLiteralInterface_2 {
  shadowBlur: number;
  shadowOffsetX: number;
  shadowColor: string;
}

interface GeneratedTypeLiteralInterface_1 {
  itemStyle?: GeneratedTypeLiteralInterface_2;
}

export interface PieChartOption {
  categories: string[]; // 分类名
  amounts: number[]; // 每个分类的金额
  emphasis?: GeneratedTypeLiteralInterface_1;
  radius?: string | number; // 饼图半径
  center?: [string, string]; // 饼图中心位置
  color?: string[]; // 自定义颜色
}
