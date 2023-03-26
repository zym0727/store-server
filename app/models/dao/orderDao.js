/*
 * @Description: 订单模块数据持久层
 * @Author: hai-27
 * @Date: 2020-02-24 16:36:19
 * @LastEditors: hai-27
 * @LastEditTime: 2020-02-27 14:31:56
 */
const db = require('./db.js');

function getQuerySql(sql, order_id, userName) {
  if(order_id) {
    sql += ` and o.order_id="${ order_id }"`
  }
  if(userName) {
    sql += ` and u.userName="${ userName }"`
  }
  return sql
}

module.exports = {
  // 连接数据库获取所有的订单id
  GetOrderGroup: async (user_id) => {
    let sql = 'select order_id from orders where user_id = ? and isDel = 0 group by order_id order by order_id desc';
    return await db.query(sql, user_id);
  },
  // 连接数据库获取所有的订单详细信息
  GetOrder: async (user_id) => {
    let sql = 'select * from orders where user_id =? and isDel = 0 order by order_time desc';
    return await db.query(sql, user_id);
  },
  // 连接数据库插入订单信息
  AddOrder: async (length, data) => {
    let sql = 'insert into orders(`id`,`order_id`,`user_id`,`product_id`,`product_num`,`product_price`,`order_time`) values(null,?,?,?,?,?,?)';
    for (let i = 0; i < length - 1; i++) {
      sql += ",(null,?,?,?,?,?,?)"
    }

    return await db.query(sql, data);
  },
  DeleteOrder: async (id) => {
    const sql = 'update orders set isDel=1 where order_id =?';
    return await db.query(sql, [id]);
  },
  QueryOrderList: async (order_id, userName, offset, rows) => {
    let sql = `select * from orders o left join product p on o.product_id = p.product_id left join users u on o.user_id = u.user_id  where o.isDel = 0`;
    sql = getQuerySql(sql, order_id, userName)
    if (rows !== 0) {
      sql += "  order by o.order_id desc limit " + offset + "," + rows;
    }
    return await db.query(sql, []);
  },
  CountOrder: async (order_id, userName) => {
    let sql = `select count(1) as total from orders o left join product p on o.product_id = p.product_id left join users u on o.user_id = u.user_id  where o.isDel = 0`;
    sql = getQuerySql(sql, order_id, userName)
    sql += ' group by o.order_id order by o.order_id desc'
    return await db.query(sql, []);
  },
}