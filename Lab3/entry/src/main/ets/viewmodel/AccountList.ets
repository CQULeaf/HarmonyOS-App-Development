export interface AccountItem {
  icon: Resource;
  iconSelected: Resource;
  accountType: number;
  typeText: string;
}

export const PayList: Array<AccountItem> = [
  {
    icon: $rawfile('cy.png'),
    iconSelected: $rawfile('cy.png'),
    accountType: 0,
    typeText: '餐饮'
  },
  {
    icon: $rawfile('gw.png'),
    iconSelected: $rawfile('gw.png'),
    accountType: 0,
    typeText: '购物'
  },
  {
    icon: $rawfile('ry.png'),
    iconSelected: $rawfile('ry.png'),
    accountType: 0,
    typeText: '日用'
  },
  {
    icon: $rawfile('jt.png'),
    iconSelected: $rawfile('jt.png'),
    accountType: 0,
    typeText: '交通'
  },


  {
    icon: $rawfile('sg.png'),
    iconSelected: $rawfile('sg.png'),
    accountType: 0,
    typeText: '水果'
  },
  {
    icon: $rawfile('ls.png'),
    iconSelected: $rawfile('ls.png'),
    accountType: 0,
    typeText: '零食'
  },
  {
    icon: $rawfile('yl.png'),
    iconSelected: $rawfile('yl.png'),
    accountType: 0,
    typeText: '娱乐'
  },
  {
    icon: $rawfile('tx.png'),
    iconSelected: $rawfile('tx.png'),
    accountType: 0,
    typeText: '通讯'
  },

  {
    icon: $rawfile('fs.png'),
    iconSelected: $rawfile('fs.png'),
    accountType: 0,
    typeText: '服饰'
  },
  {
    icon: $rawfile('mr.png'),
    iconSelected: $rawfile('mr.png'),
    accountType: 0,
    typeText: '美容'
  },
  {
    icon: $rawfile('zf.png'),
    iconSelected: $rawfile('zf.png'),
    accountType: 0,
    typeText: '住房'
  },
  {
    icon: $rawfile('lx.png'),
    iconSelected: $rawfile('lx.png'),
    accountType: 0,
    typeText: '旅行'
  },

  {
    icon: $rawfile('qy.png'),
    iconSelected: $rawfile('qy.png'),
    accountType: 0,
    typeText: '亲友'
  },
  {
    icon: $rawfile('kd.png'),
    iconSelected: $rawfile('kd.png'),
    accountType: 0,
    typeText: '快递'
  },
  {
    icon: $rawfile('gy.png'),
    iconSelected: $rawfile('gy.png'),
    accountType: 0,
    typeText: '公益'
  },
  {
    icon: $rawfile('qt.png'),
    iconSelected: $rawfile('qt.png'),
    accountType: 0,
    typeText: '其他支出'
  },
]

export const EarnList: Array<AccountItem> = [
  {
    icon: $rawfile('gz.png'),
    iconSelected: $rawfile('gz.png'),
    accountType: 1,
    typeText: '工资'
  },
  {
    icon: $rawfile('jz.png'),
    iconSelected: $rawfile('jz.png'),
    accountType: 1,
    typeText: '兼职'
  },
  {
    icon: $rawfile('lc.png'),
    iconSelected: $rawfile('lc.png'),
    accountType: 1,
    typeText: '理财'
  },
  {
    icon: $rawfile('jj.png'),
    iconSelected: $rawfile('jj.png'),
    accountType: 1,
    typeText: '奖金'
  },


  {
    icon: $rawfile('fh.png'),
    iconSelected: $rawfile('fh.png'),
    accountType: 1,
    typeText: '分红'
  },
  {
    icon: $rawfile('jxj.png'),
    iconSelected: $rawfile('jxj.png'),
    accountType: 1,
    typeText: '奖学金'
  },
  {
    icon: $rawfile('yysr.png'),
    iconSelected: $rawfile('yysr.png'),
    accountType: 1,
    typeText: '营业收入'
  },
  {
    icon: $rawfile('qtsr.png'),
    iconSelected: $rawfile('qtsr.png'),
    accountType: 1,
    typeText: '其他收入'
  }
]

export const ImageList: Record<string,Resource> = {
  '餐饮': $rawfile('cy.png'),
  '购物': $rawfile('gw.png'),
  '日用': $rawfile('ry.png'),
  '交通': $rawfile('jt.png'),

  '水果': $rawfile('sg.png'),
  '零食': $rawfile('ls.png'),
  '娱乐': $rawfile('yl.png'),
  '通讯': $rawfile('tx.png'),

  '服饰': $rawfile('fs.png'),
  '美容': $rawfile('mr.png'),
  '住房': $rawfile('zf.png'),
  '旅行': $rawfile('lx.png'),

  '亲友': $rawfile('qy.png'),
  '快递': $rawfile('kd.png'),
  '公益': $rawfile('gy.png'),
  '其他支出': $rawfile('qt.png'),


  '工资': $rawfile('gz.png'),
  '兼职': $rawfile('jz.png'),
  '理财': $rawfile('lc.png'),
  '奖金': $rawfile('jj.png'),
  '分红': $rawfile('fh.png'),
  '奖学金': $rawfile('jxj.png'),
  '营业收入': $rawfile('yysr.png'),
  '其他收入': $rawfile('qtsr.png'),
}