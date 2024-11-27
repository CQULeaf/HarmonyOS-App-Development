export default interface MoneyItem {
  icon: Resource;
  iconSelected: Resource;
  accountType: number;
  typeText: string;
}

export const PayList: Array<MoneyItem> = [
  {
    icon: $rawfile('jdbt.png'),
    iconSelected: $rawfile('jdbt.png'),
    accountType: 0,
    typeText: '京东白条'
  },
  {
    icon: $rawfile('myhb.png'),
    iconSelected: $rawfile('myhb.png'),
    accountType: 0,
    typeText: '蚂蚁花呗'
  },
  {
    icon: $rawfile('jiekuan.png'),
    iconSelected: $rawfile('jiekuan.png'),
    accountType: 0,
    typeText: '借款'
  },
  {
    icon: $rawfile('daikuan.png'),
    iconSelected: $rawfile('daikuan.png'),
    accountType: 0,
    typeText: '贷款'
  },
  {
    icon: $rawfile('qtfz.png'),
    iconSelected: $rawfile('qtfz.png'),
    accountType: 0,
    typeText: '其他负债'
  },


  {
    icon: $rawfile('gongshang.png'),
    iconSelected: $rawfile('gongshang.png'),
    accountType: 0,
    typeText: '工商银行(信)'
  },
  {
    icon: $rawfile('jianshe.png'),
    iconSelected: $rawfile('jianshe.png'),
    accountType: 0,
    typeText: '建设银行(信)'
  },
  {
    icon: $rawfile('nongye.png'),
    iconSelected: $rawfile('nongye.png'),
    accountType: 0,
    typeText: '农业银行(信)'
  },
  {
    icon: $rawfile('zhonguo.png'),
    iconSelected: $rawfile('zhonguo.png'),
    accountType: 0,
    typeText: '中国银行(信)'
  },
  {
    icon: $rawfile('zhaoshang.png'),
    iconSelected: $rawfile('zhaoshang.png'),
    accountType: 0,
    typeText: '招商银行(信)'
  },


  {
    icon: $rawfile('jiaotong.png'),
    iconSelected: $rawfile('jiaotong.png'),
    accountType: 0,
    typeText: '交通银行(信)'
  },
  {
    icon: $rawfile('zhongxing.png'),
    iconSelected: $rawfile('zhongxing.png'),
    accountType: 0,
    typeText: '中信银行(信)'
  },
  {
    icon: $rawfile('pufa.png'),
    iconSelected: $rawfile('pufa.png'),
    accountType: 0,
    typeText: '浦发银行(信)'
  },
  {
    icon: $rawfile('guangda.png'),
    iconSelected: $rawfile('guangda.png'),
    accountType: 0,
    typeText: '光大银行(信)'
  },
  {
    icon: $rawfile('guangfa.png'),
    iconSelected: $rawfile('guangfa.png'),
    accountType: 0,
    typeText: '广发银行(信)'
  },


  {
    icon: $rawfile('youzheng.png'),
    iconSelected: $rawfile('youzheng.png'),
    accountType: 0,
    typeText: '邮政银行(信)'
  },
  {
    icon: $rawfile('huifeng.png'),
    iconSelected: $rawfile('huifeng.png'),
    accountType: 0,
    typeText: '汇丰银行(信)'
  },
  {
    icon: $rawfile('huaxia.png'),
    iconSelected: $rawfile('huaxia.png'),
    accountType: 0,
    typeText: '华夏银行(信)'
  },
  {
    icon: $rawfile('rm.png'),
    iconSelected: $rawfile('rm.png'),
    accountType: 0,
    typeText: '人民银行(信)'
  },
  {
    icon: $rawfile('qtyh.png'),
    iconSelected: $rawfile('qtyh.png'),
    accountType: 0,
    typeText: '其他银行(信)'
  }
]

export const EarnList: Array<MoneyItem> = [
  {
    icon: $rawfile('cash.png'),
    iconSelected: $rawfile('cash.png'),
    accountType: 1,
    typeText: '现金'
  },
  {
    icon: $rawfile('weixin.png'),
    iconSelected: $rawfile('weixin.png'),
    accountType: 1,
    typeText: '微信'
  },
  {
    icon: $rawfile('zhifub.png'),
    iconSelected: $rawfile('zhifub.png'),
    accountType: 1,
    typeText: '支付宝'
  },
  {
    icon: $rawfile('qitazichan.png'),
    iconSelected: $rawfile('qitazichan.png'),
    accountType: 1,
    typeText: '其他资产'
  },

  {
    icon: $rawfile('gongshang.png'),
    iconSelected: $rawfile('gongshang.png'),
    accountType: 1,
    typeText: '工商银行'
  },
  {
    icon: $rawfile('jianshe.png'),
    iconSelected: $rawfile('jianshe.png'),
    accountType: 1,
    typeText: '建设银行'
  },
  {
    icon: $rawfile('nongye.png'),
    iconSelected: $rawfile('nongye.png'),
    accountType: 1,
    typeText: '农业银行'
  },
  {
    icon: $rawfile('zhonguo.png'),
    iconSelected: $rawfile('zhonguo.png'),
    accountType: 1,
    typeText: '中国银行'
  },
  {
    icon: $rawfile('zhaoshang.png'),
    iconSelected: $rawfile('zhaoshang.png'),
    accountType: 1,
    typeText: '招商银行'
  },


  {
    icon: $rawfile('jiaotong.png'),
    iconSelected: $rawfile('jiaotong.png'),
    accountType: 1,
    typeText: '交通银行'
  },
  {
    icon: $rawfile('zhongxing.png'),
    iconSelected: $rawfile('zhongxing.png'),
    accountType: 1,
    typeText: '中信银行'
  },
  {
    icon: $rawfile('pufa.png'),
    iconSelected: $rawfile('pufa.png'),
    accountType: 1,
    typeText: '浦发银行'
  },
  {
    icon: $rawfile('guangda.png'),
    iconSelected: $rawfile('guangda.png'),
    accountType: 1,
    typeText: '光大银行'
  },
  {
    icon: $rawfile('guangfa.png'),
    iconSelected: $rawfile('guangfa.png'),
    accountType: 1,
    typeText: '广发银行'
  },


  {
    icon: $rawfile('youzheng.png'),
    iconSelected: $rawfile('youzheng.png'),
    accountType: 1,
    typeText: '邮政银行'
  },
  {
    icon: $rawfile('huifeng.png'),
    iconSelected: $rawfile('huifeng.png'),
    accountType: 1,
    typeText: '汇丰银行'
  },
  {
    icon: $rawfile('huaxia.png'),
    iconSelected: $rawfile('huaxia.png'),
    accountType: 1,
    typeText: '华夏银行'
  },
  {
    icon: $rawfile('rm.png'),
    iconSelected: $rawfile('rm.png'),
    accountType: 1,
    typeText: '人民银行'
  },
  {
    icon: $rawfile('qtyh.png'),
    iconSelected: $rawfile('qtyh.png'),
    accountType: 1,
    typeText: '其他银行'
  }
  ,
  {
    icon: $rawfile('gupiao.png'),
    iconSelected: $rawfile('gupiao.png'),
    accountType: 1,
    typeText: '股票'
  },
  {
    icon: $rawfile('jijing.png'),
    iconSelected: $rawfile('jijing.png'),
    accountType: 1,
    typeText: '基金'
  },
  {
    icon: $rawfile('zhaiquan.png'),
    iconSelected: $rawfile('zhaiquan.png'),
    accountType: 1,
    typeText: '债权'
  }



]
export const YusuanList: Array<MoneyItem> =[
  {
    icon: $rawfile('monthyusuan.png'),
    iconSelected: $rawfile('monthyusuan.png'),
    accountType: 2,
    typeText: '月度预算'
  },{
    icon: $rawfile('yearyusuan.png'),
    iconSelected: $rawfile('yearyusuan.png'),
    accountType: 2,
    typeText: '年度预算'
  }
]
export const ImageList: Record<string,Resource> = {
  '京东白条': $rawfile('jdbt.png'),
  '蚂蚁花呗': $rawfile('myhb.png'),
  '借款': $rawfile('jiekuan.png'),
  '贷款': $rawfile('daikuan.png'),
  '其他负债': $rawfile('qtfz.png'),


  '工商银行(信)': $rawfile('gongshang.png'),
  '建设银行(信)': $rawfile('jianshe.png'),
  '农业银行(信)': $rawfile('nongye.png'),
  '中国银行(信)': $rawfile('zhonguo.png'),
  '招商银行(信)': $rawfile('zhaoshang.png'),

  '交通银行(信)': $rawfile('jiaotong.png'),
  '中信银行(信)': $rawfile('zhongxing.png'),
  '浦发银行(信)': $rawfile('pufa.png'),
  '光大银行(信)': $rawfile('guangda.png'),
  '广发银行(信)': $rawfile('guangfa.png'),

  '邮政银行(信)': $rawfile('youzheng.png'),
  '汇丰银行(信)': $rawfile('huifeng.png'),
  '华夏银行(信)': $rawfile('huaxia.png'),
  '人民银行(信)': $rawfile('rm.png'),
  '其他银行(信)': $rawfile('qtyh.png'),


  '现金': $rawfile('cash.png'),
  '微信': $rawfile('weixin.png'),
  '支付宝': $rawfile('zhifub.png'),
  '其他资产': $rawfile('qitazichan.png'),

  '工商银行': $rawfile('gongshang.png'),
  '建设银行': $rawfile('jianshe.png'),
  '农业银行': $rawfile('nongye.png'),
  '中国银行': $rawfile('zhonguo.png'),
  '招商银行': $rawfile('zhaoshang.png'),

  '交通银行': $rawfile('jiaotong.png'),
  '中信银行': $rawfile('zhongxing.png'),
  '浦发银行': $rawfile('pufa.png'),
  '光大银行': $rawfile('guangda.png'),
  '广发银行': $rawfile('guangfa.png'),

  '邮政银行': $rawfile('youzheng.png'),
  '汇丰银行': $rawfile('huifeng.png'),
  '华夏银行': $rawfile('huaxia.png'),
  '人民银行': $rawfile('rm.png'),
  '其他银行': $rawfile('qtyh.png'),

  '股票': $rawfile('gupiao.png'),
  '基金': $rawfile('jijing.png'),
  '债权': $rawfile('zhaiquan.png'),

  '月度预算':  $rawfile('monthyusuan.png'),
  '年度预算':  $rawfile('yearyusuan.png'),


}