/*
 * @Description: 商品模块数据持久层
 * @Author: hai-27
 * @Date: 2020-02-07 16:51:56
 * @LastEditors: hai-27
 * @LastEditTime: 2020-02-27 15:42:52
 */
const db = require('./db.js');

function getQuerySql(sql, product_id, product_name, category_id) {
  if(product_id) {
    sql += ` and p.product_id="${ product_id }"`
  }
  if(product_name) {
    sql += ` and p.product_name like "%${ product_name }%"`
  }
  if(category_id) {
    sql += ` and p.category_id="${ category_id }"`
  }
  return sql
}


module.exports = {
  // 连接数据库获取商品分类
  GetCategory: async () => {
    const sql = "select * from category where isDel = 0";
    return await db.query(sql, []);
  },
  // 连接数据库根据商品分类名称获取分类id
  GetCategoryId: async (categoryName) => {
    const sql = "select * from category where isDel = 0 and category_name = ?";
    const category = await db.query(sql, [categoryName]);
    return category[0].category_id;
  },
  // 连接数据库,根据商品分类id获取首页展示的商品信息
  GetPromoProduct: async (categoryID) => {
    const sql = "select * from product where isDel = 0 and category_id = ? order by product_sales desc limit 7";
    return await db.query(sql, categoryID);
  },
  // 连接数据库,分页获取所有的商品信息
  GetAllProduct: async (offset = 0, rows = 0) => {
    let sql = "select * from product where isDel = 0 ";
    if (rows != 0) {
      sql += "limit " + offset + "," + rows;
    }
    return await db.query(sql, []);
  },
  // 连接数据库,根据商品分类id,分页获取商品信息
  GetProductByCategory: async (categoryID, offset = 0, rows = 0) => {
    let sql = "select * from product where isDel = 0 and category_id = ? ";

    for (let i = 0; i < categoryID.length - 1; i++) {
      sql += "or category_id = ? ";
    }
    if (rows != 0) {
      sql += "order by product_sales desc limit " + offset + "," + rows;
    }

    return await db.query(sql, categoryID);
  },
  // 连接数据库,根据搜索条件,分页获取商品信息
  GetProductBySearch: async (search, offset = 0, rows = 0) => { 
    let sql = `select * from product where isDel = 0 and product_name like "%${ search }%" or product_title like "%${ search }%" or product_intro like "%${ search }%"`;

    if (rows != 0) {
      sql += "order by product_sales desc limit " + offset + "," + rows;
    }
    
    return await db.query(sql, []);
  },
  // 连接数据库,根据商品id,获取商品详细信息
  GetProductById: async (id) => {
    const sql = 'select * from product where product_id = ? and isDel = 0';
    return await db.query(sql, id);
  },
  // 连接数据库,根据商品id,获取商品图片
  GetDetailsPicture: async (productID) => {
    const sql = "select * from product_picture where product_id = ? and isDel = 0";
    return await db.query(sql, productID);
  },
  // 连接数据库,获取所有的商品(没有分页)
  GetNoPagedProducts: async () => {
    const sql = 'select * from product where isDel = 0';
    return await db.query(sql, []);
  },
  // 连接数据库后台分页查询商品
  QueryProductList: async (product_id, product_name, category_id, pageNo, pageSize) => {
    let sql = 'select * from product p left join category c on p.category_id = c.category_id where p.isDel = 0';
    sql = getQuerySql(sql, product_id, product_name, category_id)
    if (pageSize !== 0) {
      const offset = (pageNo - 1) * pageSize
      sql += " order by p.product_id desc limit " + offset + "," + pageSize;
    }
    return await db.query(sql, []);
  },
  // 连接数据库根据条件统计所有商品数量
  CountProduct: async (product_id, product_name, category_id) => {
    let sql = 'select count(1) as total from product p left join category c on p.category_id = c.category_id where p.isDel = 0';
    sql = getQuerySql(sql, product_id, product_name, category_id)
    return await db.query(sql, []);
  },
  // 连接数据库后台删除商品
  DeleteProduct: async (id) => {
    const sql = 'update product set isDel=1 where product_id =?';
    return await db.query(sql, [id]);
  },
  // 连接数据库后台插入商品
  BackAddProduct: async (data) => {
    const sql = 'insert into product(product_name,category_id,product_title,product_intro,product_picture,product_price,product_selling_price,product_sales) values(?,?,?,?,?,?,?,?)';
    return await db.query(sql, data);
  },
  // 连接数据库后台更新商品
  UpdateProduct: async (data) => {
    const sql = 'update product set product_name=?,category_id=?,product_title=?,product_intro=?,product_picture=?,product_price=?,product_selling_price=?,product_sales=? where product_id =?';
    return await db.query(sql, data);
  },
  // 连接数据库后台插入商品详情图片
  AddProductPicture: async (length, data) => {
    let sql = 'insert into product_picture(`product_id`,`product_picture`) values(?,?)';
    for (let i = 0; i < length - 1; i++) {
      sql += ",(?,?)"
    }
    return await db.query(sql, data);
  },
  // 连接数据库后台删除商品详情图片
  DeleteProductPicture: async (length, data) => {
    let sql = 'update product_picture set isDel=1 where id =?';
    for (let i = 0; i < length - 1; i++) {
      sql += " or id =?"
    }
    return await db.query(sql, data);
  }
}