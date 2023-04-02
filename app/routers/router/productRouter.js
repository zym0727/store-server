/*
 * @Description: 商品模块路由
 * @Author: hai-27
 * @Date: 2020-02-07 16:51:56
 * @LastEditors: hai-27
 * @LastEditTime: 2020-04-07 22:52:56
 */
const Router = require('koa-router');
const productController = require('../../controllers/productController')

let productRouter = new Router();

productRouter
  .post('/product/getAllProduct', productController.GetAllProduct)
  .post('/product/getPromoProduct', productController.GetPromoProduct)
  .post('/product/getHotProduct', productController.GetHotProduct)
  .post('/product/getProductByCategory', productController.GetProductByCategory)
  .post('/product/getCategory', productController.GetCategory)
  .post('/product/getProductBySearch', productController.GetProductBySearch)
  .post('/product/getDetails', productController.GetDetails)
  .post('/product/getDetailsPicture', productController.GetDetailsPicture)
  .get('/user/product/getNoPagedProducts', productController.GetNoPagedProducts)
  .get('/user/product/queryProductList', productController.QueryProductList)
  .post('/user/product/deleteProduct', productController.DeleteProduct)
  .post('/user/product/backAddProduct', productController.BackAddProduct)
  .post('/user/product/updateProduct', productController.UpdateProduct)
  
module.exports = productRouter;