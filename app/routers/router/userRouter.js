/*
 * @Description: 用户模块路由
 * @Author: hai-27
 * @Date: 2020-02-07 16:51:56
 * @LastEditors: hai-27
 * @LastEditTime: 2020-03-27 12:41:14
 */
const Router = require('koa-router');
const userController = require('../../controllers/userController')

let userRouter = new Router();

userRouter
  .post('/users/login', userController.Login)
  .post('/users/miniProgramLogin', userController.miniProgramLogin)
  .post('/users/findUserName', userController.FindUserName)
  .post('/users/register', userController.Register)
  .post('/user/addUser', userController.AddUser)
  .post('/user/updateUser', userController.UpdateUser)
  .post('/user/deleteUser', userController.DeleteUser)
  .get('/user/queryUserList', userController.QueryUserList)
  .get('/user/getNoPagedUsers', userController.GetNoPagedUsers)
  .post('/user/getUserById', userController.GetUserById)

module.exports = userRouter;