/*
 * @Description: 订单模块路由
 * @Author: hai-27
 * @Date: 2020-02-24 16:29:26
 * @LastEditors: hai-27
 * @LastEditTime: 2020-04-07 22:52:48
 */
const Router = require('koa-router');
const orderController = require('../../controllers/orderController')

let orderRouter = new Router();

orderRouter
  .post('/user/order/getOrder', orderController.GetOrder)
  .post('/user/order/addOrder', orderController.AddOrder)
  .post('/user/order/backAddOrder', orderController.BackAddOrder)
  .post('/user/order/updateOrder', orderController.UpdateOrder)
  .post('/user/order/deleteOrder', orderController.DeleteOrder)
  .get('/user/order/queryOrderList', orderController.QueryOrderList)

module.exports = orderRouter;