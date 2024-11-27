import relationalStore from '@ohos.data.relationalStore';
import UserData from '../../../viewmodel/UserData';
import CommonConstants from '../../constants/CommonConstants';
import Rdb from '../Rdb'

export default class UserTable {
  private userTable = new Rdb(CommonConstants.User_TABLE.tableName, CommonConstants.User_TABLE.sqlCreate,
    CommonConstants.User_TABLE.columns);

  constructor(callback: Function = () => {
  }) {
    this.userTable.getRdbStore(callback);
  }

  getRdbStore(callback: Function = () => {
  }) {
    this.userTable.getRdbStore(callback);
  }

  insertData(user: UserData, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(user);
    this.userTable.insertData(valueBucket, callback);
  }

  updatePassword(userData: UserData, callback: Function) {

    let predicates = new relationalStore.RdbPredicates(CommonConstants.User_TABLE.tableName);
    predicates.equalTo('username', userData.username);
    this.userTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback(-1);
      } else {
        resultSet.goToFirstRow();
        const result: UserData[] = [];
        for (let i = 0; i < count; i++) {
          let tmp: UserData = {
            id: 0,username: '', password: '',realname:''
          };
          tmp.id = resultSet.getColumnIndex('id');
          tmp.username = resultSet.getString(resultSet.getColumnIndex('username'));
          tmp.password = resultSet.getString(resultSet.getColumnIndex('password'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }

        if (result[0].password === userData.password) {
          callback(true);
        } else {
          const valueBucket: relationalStore.ValuesBucket = generateBucket(userData);
          let predicates = new relationalStore.RdbPredicates(CommonConstants.User_TABLE.tableName);
          predicates.equalTo('username', userData.username);
          this.userTable.updateData(predicates, valueBucket);
          callback(false);
        }

      }
    });
  }

  query(userData: UserData, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.User_TABLE.tableName);
    predicates.equalTo('username', userData.username);
    this.userTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback(-1);
      } else {
        resultSet.goToFirstRow();
        const result: UserData[] = [];
        for (let i = 0; i < count; i++) {
          let tmp: UserData = {
            id: 0,username: '', password: '',realname:''
          };
          tmp.username = resultSet.getString(resultSet.getColumnIndex('username'));
          tmp.password = resultSet.getString(resultSet.getColumnIndex('password'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        if (result[0].password === userData.password) {
          callback(true);
        } else {
          callback(false);
        }
      }
    });
  }


}


function generateBucket(user: UserData): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.username = user.username;
  obj.password = user.password;
  obj.realname = user.realname;
  return obj;
}
