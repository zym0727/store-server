/*
 * @Description: 订单模块控制器
 * @Author: hai-27
 * @Date: 2020-02-24 16:35:22
 * @LastEditors: hai-27
 * @LastEditTime: 2020-02-27 14:32:16
 */
const orderDao = require('../models/dao/orderDao');
const shoppingCartDao = require('../models/dao/shoppingCartDao');
const productDao = require('../models/dao/productDao');
const checkLogin = require('../middleware/checkLogin');

module.exports = {
  /**
   * 获取用户的所有订单信息
   * @param {Object} ctx
   */
  GetOrder: async ctx => {
    let { user_id } = ctx.request.body;
    // 校验用户是否登录
    if (!checkLogin(ctx, user_id)) {
      return;
    }
    // 获取所有的订单id
    const ordersGroup = await orderDao.GetOrderGroup(user_id);

    // 该用户没有订单,直接返回信息
    if (ordersGroup.length == 0) {
      ctx.body = {
        code: '002',
        msg: '该用户没有订单信息'
      }
      return;
    }

    // 获取所有的订单详细信息
    const orders = await orderDao.GetOrder(user_id);

    let ordersList = [];
    // 生成每个订单的详细信息列表
    for (let i = 0; i < ordersGroup.length; i++) {
      const orderID = ordersGroup[i];
      let tempOrder = [];

      for (let j = 0; j < orders.length; j++) {
        const order = orders[j];

        if (orderID.order_id == order.order_id) {
          // 获取每个商品详细信息
          const product = await productDao.GetProductById(order.product_id);
          order.product_name = product[0].product_name;
          order.product_picture = product[0].product_picture;

          tempOrder.push(order);
        }
      }
      ordersList.push(tempOrder);
    }

    ctx.body = {
      code: '001',
      orders: ordersList
    }

  },
  /**
   * 添加用户订单信息
   * @param {Object} ctx
   */
  AddOrder: async ctx => {
    let { user_id, products } = ctx.request.body;
    // 校验用户是否登录
    if (!checkLogin(ctx, user_id)) {
      return;
    }

    // 获取当前时间戳
    const timeTemp = new Date().getTime();
    // 生成订单id：用户id+时间戳(string)
    const orderID = +("" + user_id + timeTemp);

    let data = [];
    // 根据数据库表结构生成字段信息
    for (let i = 0; i < products.length; i++) {
      const temp = products[i];
      let product = [orderID, user_id, temp.productID, temp.num, temp.price, timeTemp];
      data.push(...product);
    }

    try {
      // 把订单信息插入数据库
      const result = await orderDao.AddOrder(products.length, data);

      // 插入成功
      if (result.affectedRows == products.length) {
        //删除购物车
        let rows = 0;
        for (let i = 0; i < products.length; i++) {
          const temp = products[i];
          const res = await shoppingCartDao.DeleteShoppingCart(user_id, temp.productID);
          rows += res.affectedRows;
        }
        //判断删除购物车是否成功
        if (rows != products.length) {
          ctx.body = {
            code: '002',
            msg: '购买成功,但购物车没有更新成功'
          }
          return;
        }

        ctx.body = {
          code: '001',
          msg: '购买成功'
        }
      } else {
        ctx.body = {
          code: '004',
          msg: '购买失败,未知原因'
        }
      }
    } catch (error) {
      console.log(error)
    }
  },
   /**
   * 后台添加用户订单信息
   * @param {Object} ctx
   */
  BackAddOrder: async ctx => {
    let { user_id, orderUserId, products, order_time } = ctx.request.body;
    // 校验用户是否登录
    if (!checkLogin(ctx, user_id)) {
      return;
    }

    // 获取当前时间戳
    const timeTemp = new Date().getTime();
    // 生成订单id：用户id+时间戳(string)
    const orderID = +("" + user_id + timeTemp);
    let data = [];
    // 根据数据库表结构生成字段信息
    for (let i = 0; i < products.length; i++) {
      const temp = products[i];
      let product = [orderID, orderUserId, temp.productID, temp.num, temp.price, order_time];
      data.push(...product);
    }

    try {
      // 把订单信息插入数据库
      const result = await orderDao.AddOrder(products.length, data);

      // 插入成功
      if (result.affectedRows == products.length) {
        ctx.body = {
          code: '001',
          msg: '添加订单成功'
        }
      } else {
        ctx.body = {
          code: '004',
          msg: '添加订单失败,未知原因'
        }
      }
    } catch (error) {
      console.log(error)
    }
  },
   /**
   * 更新用户订单信息
   * @param {Object} ctx
   */
  UpdateOrder: async ctx => {
    let { order_id, user_id, orderUserId, products, order_time } = ctx.request.body;
    // 校验用户是否登录
    if (!checkLogin(ctx, user_id)) {
      return;
    }

    try {
      // 连接数据库更新订单信息
      let result = await orderDao.DeleteOrder(order_id);
      if (result.affectedRows > 0) {
        let data = [];
        // 根据数据库表结构生成字段信息
        for (let i = 0; i < products.length; i++) {
          const temp = products[i];
          let product = [order_id, orderUserId, temp.productID, temp.num, temp.price, order_time];
          data.push(...product);
        }

        const result = await orderDao.AddOrder(products.length, data);

        // 插入成功
        if (result.affectedRows == products.length) {
          ctx.body = {
            code: '001',
            msg: '更新成功'
          }
          return;
        }
      }
      // 否则失败
      ctx.body = {
        code: '500',
        msg: '未知错误，更新失败'
      }
    } catch (error) {
      console.log(error)
    }
  },
  /**
   * 删除用户订单信息
   * @param {Object} ctx
   */
  DeleteOrder: async ctx => {
    let { order_id } = ctx.request.body;

    try {
      // 连接数据库更新订单信息
      let result = await orderDao.DeleteOrder(order_id);
      if (result.affectedRows > 0) {
        ctx.body = {
          code: '001',
          msg: '删除成功'
        }
        return;
      }
      // 否则失败
      ctx.body = {
        code: '500',
        msg: '未知错误，删除失败'
      }
    } catch (error) {
      console.log(error)
    }
  },
  /**
   * 后台查询订单列表
   * @param {Object} ctx
   */
  QueryOrderList: async ctx => {
    let { order_id, userName, pageNo, pageSize } = ctx.request.query;
    try {
      // 连接数据库获取订单信息
      let count = await orderDao.CountOrder(order_id, userName);
      const offset = (pageNo - 1) * pageSize
      const before = count.slice(0, offset)
      const after = count.slice(offset, offset + pageSize)
      let result = await orderDao.QueryOrderList(order_id, userName, before.reduce((sum,cur) => {sum += cur.total; return sum}, 0), after.reduce((sum,cur) => {sum += cur.total; return sum}, 0));
      result = result.reduce((final, cur) => {
        const product =  {
          name: cur.product_name,
          num: cur.product_num,
          price: cur.product_selling_price,
          productID: cur.product_id
        }
        let item = final.find(ele => ele.order_id === cur.order_id)
        if(!item) {
          const temp = {
            order_id: cur.order_id,
            userName: cur.userName,
            productsDetail: [product],
            price: product.num * product.price,
            order_time: cur.order_time,
            orderUserId: cur.user_id
          }
          final.push(temp)
        } else {
          item.productsDetail.push(product)
          item.price += product.num * product.price
        }
        return final
      }, [])

      ctx.body = {
        code: '001',
        result,
        total: count.length,
        msg: '查询成功'
      }
    } catch (error) {
      console.log(error)
    }
  }
}