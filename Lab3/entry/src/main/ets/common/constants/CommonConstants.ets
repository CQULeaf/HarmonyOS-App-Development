import relationalStore from '@ohos.data.relationalStore';
export interface AccountTable {
  tableName: string;
  sqlCreate: string;
  columns: string[];
}
export interface UserTable {
  tableName: string;
  sqlCreate: string;
  columns: string[];
}
export interface MoneyTable {
  tableName: string;
  sqlCreate: string;
  columns: string[];
}
export default class CommonConstants {
  static readonly STORE_CONFIG: relationalStore.StoreConfig = {
    name: 'database.db',
    securityLevel: relationalStore.SecurityLevel.S1
  };

  static readonly ACCOUNT_TABLE: AccountTable = {
    tableName: 'accountTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS accountTable(id INTEGER PRIMARY KEY AUTOINCREMENT, accountType INTEGER, ' +
      'typeText TEXT, amount INTEGER,Date Text, remark Text)',
    columns: ['id', 'accountType', 'typeText', 'amount','Date','remark']
  };
  static readonly User_TABLE: UserTable = {
    tableName: 'userTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS userTable(id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
    'username TEXT, password Text, realname Text)',
    columns: ['id', 'username', 'password', 'realname']
  };
  static readonly Money_TABLE: MoneyTable = {
    tableName: 'moneyTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS moneyTable(id INTEGER PRIMARY KEY AUTOINCREMENT, accountType INTEGER, ' +
    'typeText TEXT, amount INTEGER, remark TEXT)',
    columns: ['id', 'accountType', 'typeText', 'remark']
  };
  static readonly SEARCH_TEXT = '输入关键字';
  static readonly TOAST_TEXT_1 = '账目类型不能为空';
  static readonly TOAST_TEXT_2 = '账目金额不为正整数';
  static readonly TOAST_TEXT_3 = '请选择账目日期';
  static readonly TOAST_TEXT_4 = '用户名或密码不能为空';
  static readonly TOAST_TEXT_5 = '注册成功';
  static readonly FULL_WIDTH = '100%';
  static readonly FULL_HEIGHT = '100%';
  static readonly DIALOG_HEIGHT = '95%';
  static readonly TABS_HEIGHT = '70%';
  static readonly MINIMUM_SIZE = 0;
  static readonly FULL_SIZE = 1;
  static readonly PROMPT_BOTTOM = '70vp';
  static readonly EDIT_POSITION_X = '43.5%';
  static readonly EDIT_POSITION_Y = '90%';
  static readonly RDB_TAG = '[Debug.Rdb]';
  static readonly TABLE_TAG = '[Debug.AccountTable]';
  static readonly INDEX_TAG = '[Debug.Index]';
}