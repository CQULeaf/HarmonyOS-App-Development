import relationalStore from '@ohos.data.relationalStore';
import MoneyData from '../../../viewmodel/MoneyData';
import CommonConstants from '../../constants/CommonConstants';
import Rdb from '../Rdb';

export default class MoneyTable {
  private moneyTable = new Rdb(CommonConstants.Money_TABLE.tableName, CommonConstants.Money_TABLE.sqlCreate,
    CommonConstants.Money_TABLE.columns);

  constructor(callback: Function = () => {
  }) {
    this.moneyTable.getRdbStore(callback);
  }

  getRdbStore(callback: Function = () => {
  }) {
    this.moneyTable.getRdbStore(callback);
  }

  insertData(money: MoneyData, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(money);
    this.moneyTable.insertData(valueBucket, callback);
  }

  deleteData(money: MoneyData, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.Money_TABLE.tableName);
    predicates.equalTo('id', money.id);
    this.moneyTable.deleteData(predicates, callback);
  }

  updateData(money: MoneyData, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(money);
    let predicates = new relationalStore.RdbPredicates(CommonConstants.Money_TABLE.tableName);
    predicates.equalTo('id', money.id);
    this.moneyTable.updateData(predicates, valueBucket, callback);
  }

  query(money: number, callback: Function, isAll: boolean = true) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.Money_TABLE.tableName);
    if (!isAll) {
      predicates.equalTo('amount', money);
    }
    this.moneyTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result:MoneyData[] = [];
        for (let i = 0; i < count; i++) {
          let tmp: MoneyData = {
            id: 0, accountType: 0, typeText: '', amount: 0, remark:''
          };
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.accountType = resultSet.getDouble(resultSet.getColumnIndex('accountType'));
          tmp.typeText = resultSet.getString(resultSet.getColumnIndex('typeText'));
          tmp.amount = resultSet.getDouble(resultSet.getColumnIndex('amount'));
          tmp.remark = resultSet.getString(resultSet.getColumnIndex('remark'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
}

function generateBucket(money: MoneyData): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.accountType = money.accountType;
  obj.typeText = money.typeText;
  obj.amount = money.amount;
  obj.remark = money.remark;
  return obj;
}