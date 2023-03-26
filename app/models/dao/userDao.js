/*
 * @Description: 用户模块数据持久层
 * @Author: hai-27
 * @Date: 2020-02-07 16:51:56
 * @LastEditors: hai-27
 * @LastEditTime: 2020-02-27 02:12:30
 */
const db = require('./db.js');

function getQuerySql(sql, userName, userPhoneNumber, isAdmin) {
  if(userName) {
    sql += ` and userName like "%${ userName }%"`
  }
  if(userPhoneNumber) {
    sql += ` and userPhoneNumber like "%${ userPhoneNumber }%"`
  }
  if(isAdmin) {
    sql += ` and isAdmin="${ isAdmin }"`
  }
  return sql
}

module.exports = {
  // 连接数据库根据用户名和密码查询用户信息
  Login: async (userName, password) => {
    const sql = 'select * from users where userName = ? and password = ? and isDel = 0';
    return await db.query(sql, [userName, password]);
  },
  // 连接数据库根据用户名查询用户信息
  FindUserName: async (userName) => {
    const sql = 'select * from users where userName = ? and isDel = 0';
    return await db.query(sql, [userName]);
  },
  // 连接数据库插入用户信息
  Register: async (userName, password) => {
    const sql = 'insert into users(userName,password) values(?,?)';
    return await db.query(sql, [userName, password]);
  },
  AddUser: async (data) => {
    const sql = 'insert into users(userName,password,isAdmin,userPhoneNumber,address) values(?,?,?,?,?)';
    return await db.query(sql, data);
  },
  UpdateUser: async (data) => {
    const sql = 'update users set userName=?,password=?,isAdmin=?,userPhoneNumber=?,address=? where user_id =?';
    return await db.query(sql, data);
  },
  DeleteUser: async (id) => {
    const sql = 'update users set isDel=1 where user_id =?';
    return await db.query(sql, [id]);
  },
  QueryUserList: async (userName, userPhoneNumber, isAdmin, pageNo, pageSize) => {
    let sql = `select * from users where isDel = 0`;
    sql = getQuerySql(sql, userName, userPhoneNumber, isAdmin)
    if (pageSize !== 0) {
      const offset = (pageNo - 1) * pageSize
      sql += " order by user_id desc limit " + offset + "," + pageSize;
    }
    return await db.query(sql, []);
  },
  CountUser: async (userName, userPhoneNumber, isAdmin) => {
    let sql = `select count(1) as total from users where isDel = 0`;
    sql = getQuerySql(sql, userName, userPhoneNumber, isAdmin)
    return await db.query(sql, []);
  },
  GetAllUser: async () => {
    const sql = 'select * from users where isDel = 0';
    return await db.query(sql, []);
  }
}