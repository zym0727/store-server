/*
 * @Description: 商品模块控制器
 * @Author: hai-27
 * @Date: 2020-02-07 16:51:56
 * @LastEditors: hai-27
 * @LastEditTime: 2020-02-27 15:41:11
 */
const productDao = require('../models/dao/productDao');
module.exports = {
  /**
   * 获取商品分类
   * @param {Object} ctx
   */
  GetCategory: async ctx => {
    const category = await productDao.GetCategory();

    ctx.body = {
      code: '001',
      category
    }
  },
  /**
   * 根据商品分类名称获取首页展示的商品信息
   * @param {Object} ctx
   */
  GetPromoProduct: async ctx => {
    let { categoryName } = ctx.request.body;
    // 根据商品分类名称获取分类id
    const categoryID = await productDao.GetCategoryId(categoryName);
    // 根据商品分类id获取首页展示的商品信息
    const Product = await productDao.GetPromoProduct(categoryID);

    ctx.body = {
      code: '001',
      Product
    }
  },
  /**
   * 根据商品分类名称获取热门商品信息
   * @param {Object} ctx
   */
  GetHotProduct: async ctx => {
    let { categoryName } = ctx.request.body;
    const categoryID = [];

    for (let i = 0; i < categoryName.length; i++) {
      // 根据商品分类名称获取分类id
      const category_id = await productDao.GetCategoryId(categoryName[i]);
      categoryID.push(category_id);
    }
    // 根据商品分类id获取商品信息
    const Product = await productDao.GetProductByCategory(categoryID, 0, 7);

    ctx.body = {
      code: '001',
      Product
    }
  },
  /**
   * 分页获取所有的商品信息
   * @param {Object} ctx
   */
  GetAllProduct: async ctx => {
    let { currentPage, pageSize } = ctx.request.body;
    // 计算开始索引
    const offset = (currentPage - 1) * pageSize;
    const Product = await productDao.GetAllProduct(offset, pageSize);
    // 获取所有的商品数量,用于前端分页计算
    const total = (await productDao.GetAllProduct()).length;
    ctx.body = {
      code: '001',
      Product,
      total
    }
  },
  /**
   * 根据分类id,分页获取商品信息
   * @param {Object} ctx
   */
  GetProductByCategory: async ctx => {
    let { categoryID, currentPage, pageSize } = ctx.request.body;
    // 计算开始索引
    const offset = (currentPage - 1) * pageSize;
    // 分页获取该分类的商品信息
    const Product = await productDao.GetProductByCategory(categoryID, offset, pageSize);
    // 获取该分类所有的商品数量,用于前端分页计算
    const total = (await productDao.GetProductByCategory(categoryID)).length;

    ctx.body = {
      code: '001',
      Product,
      total
    }
  },
  /**
   * 根据搜索条件,分页获取商品信息
   * @param {Object} ctx
   */
  GetProductBySearch: async ctx => {
    let { search, currentPage, pageSize } = ctx.request.body;
    // 计算开始索引
    const offset = (currentPage - 1) * pageSize;
    // 获取分类列表
    const category = await productDao.GetCategory();

    let Product;
    let total;

    for (let i = 0; i < category.length; i++) {
      // 如果搜索条件为某个分类名称,直接返回该分类的商品信息
      if (search == category[i].category_name) {
        // 获取该分类的商品信息
        Product = await productDao.GetProductByCategory(category[i].category_id, offset, pageSize);
        // 获取该分类所有的商品数量,用于前端分页计算
        total = (await productDao.GetProductByCategory(category[i].category_id)).length;

        ctx.body = {
          code: '001',
          Product,
          total
        }
        return;
      }
    }
    // 否则返回根据查询条件模糊查询的商品分页结果
    Product = await productDao.GetProductBySearch(search, offset, pageSize);
    // 获取模糊查询的商品结果总数
    total = (await productDao.GetProductBySearch(search)).length;

    ctx.body = {
      code: '001',
      Product,
      total
    }
  },
  /**
   * 根据商品id,获取商品详细信息
   * @param {Object} ctx
   */
  GetDetails: async ctx => {
    let { productID } = ctx.request.body;

    const Product = await productDao.GetProductById(productID);

    ctx.body = {
      code: '001',
      Product,
    }
  },
  /**
   * 根据商品id,获取商品图片,用于食品详情的页面展示
   * @param {Object} ctx
   */
  GetDetailsPicture: async ctx => {
    let { productID } = ctx.request.body;

    const ProductPicture = await productDao.GetDetailsPicture(productID);

    ctx.body = {
      code: '001',
      ProductPicture,
    }
  },
  /**
   * 获取所有的商品(没有分页)
   * @param {Object} ctx
   */
  GetNoPagedProducts: async ctx => {
    try {
      // 连接数据库获取商品信息
      let result = await productDao.GetNoPagedProducts()

      ctx.body = {
        code: '001',
        result,
        msg: '查询成功'
      }
    } catch (error) {
      console.log(error)
    }
  },
   /**
   * 后台查询商品列表
   * @param {Object} ctx
   */
  QueryProductList: async ctx => {
    let { product_id, product_name, category_id, pageNo, pageSize } = ctx.request.query;
    try {
      // 连接数据库分页获取商品
      let result = await productDao.QueryProductList(product_id, product_name, category_id, pageNo, pageSize);
      let count = await productDao.CountProduct(product_id, product_name, category_id);

      ctx.body = {
        code: '001',
        result,
        total: count[0].total,
        msg: '查询成功'
      }
    } catch (error) {
      console.log(error)
    }
  },
  /**
   * 后台删除商品
   * @param {Object} ctx
   */
  DeleteProduct: async ctx => {
    let { product_id } = ctx.request.body;

    try {
      // 连接数据库更新商品
      let result = await productDao.DeleteProduct(product_id);
      // 操作所影响的记录行数为1,则代表更新成功
      if (result.affectedRows === 1) {
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
   * 后台添加商品
   * @param {Object} ctx
   */
  BackAddProduct: async ctx => {
    const { product_name,category_id,product_title,product_intro,product_price,product_selling_price,product_sales } = ctx.request.body;
    let files = ctx.request.files.files
    if(!Array.isArray(files)){ // 可以是对象
      files = [files]
    }
    const paths = files.map(file => {
      const index = file.path.indexOf('upload_')
      const path = 'public/imgs/upload/' + file.path.substring(index)
      return path
    })
    try {
      // 把商品插入数据库
      const result = await productDao.BackAddProduct([product_name,category_id,product_title,product_intro,paths[0],product_price,product_selling_price,product_sales]);
      // 插入成功
      if (result.affectedRows == 1) {
        const product_id = result.insertId
        const subPaths = paths.slice(1)
        const picutres = subPaths.map(path => {
          return {product_id, product_picture: path}
        })
        const data = []
        picutres.forEach(element => {
          data.push(...[element.product_id, element.product_picture])
        });
        const subResult = await productDao.AddProductPicture(picutres.length, data)
        // 插入图片详情成功
        if (subResult.affectedRows == picutres.length) {
          ctx.body = {
            code: '001',
            msg: '添加商品成功'
          }
          return
        }
      }
      ctx.body = {
        code: '004',
        msg: '添加商品失败,未知原因'
      }
    } catch (error) {
      console.log(error)
    }
  },
  /**
   * 后台更新商品
   * @param {Object} ctx
   */
  UpdateProduct: async ctx => {
    let { product_name,category_id,product_title,product_intro,product_picture,product_price,product_selling_price,product_sales, deletePictureIds, product_id } = ctx.request.body;
    let files = ctx.request.files.files
    if (!Array.isArray(files)){ // 上传0个files是underfined, 上传1个是对象，2个是数组
      files = files ? [files] : []
    }
    const paths = files.map(file => {
      const index = file.path.indexOf('upload_')
      const path = 'public/imgs/upload/' + file.path.substring(index)
      return path
    })
    // 主图片没有用上传的第一张
    const mainPicture = product_picture ? product_picture : paths[0]
    // 有id表示有要删除的副图
    const deleteIds = deletePictureIds ? deletePictureIds.split(',') : []
    // 有要加入的副图路径； 有主图片的paths都是副图路径， 否则取后面的
    const subPaths = product_picture ? paths : paths.slice(1)
    try {
      // 连接数据库更新商品
      let result = await productDao.UpdateProduct([product_name,category_id,product_title,product_intro,mainPicture,product_price,product_selling_price,product_sales,product_id]);
      let deleteResult = {affectedRows: deleteIds.length}
      let addResult = {affectedRows: subPaths.length}
      if (deleteIds.length > 0) {
        // 删除关联的商品详情图片
        deleteResult = await productDao.DeleteProductPicture(deleteIds.length, deleteIds)
      }
      // 有paths表示有可能要加入副图
      if (paths.length > 0) {
        const picutres = subPaths.map(path => {
          return {product_id, product_picture: path}
        })
        const data = []
        picutres.forEach(element => {
          data.push(...[element.product_id, element.product_picture])
        });
        // 增加新的商品详情图片
        addResult = await productDao.AddProductPicture(picutres.length, data)
      }
      if ((result.affectedRows == 1) && (deleteResult.affectedRows == deleteIds.length) && (addResult.affectedRows == subPaths.length)) {
        ctx.body = {
          code: '001',
          msg: '更新成功'
        }
        return;
      }
      // 否则失败
      ctx.body = {
        code: '500',
        msg: '未知错误，更新失败'
      }
    } catch (error) {
      console.log(error)
    }
  }
}