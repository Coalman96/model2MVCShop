package com.model2.mvc.service.product.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;


@Repository("productDaoImpl")
public class ProductDAOImpl implements ProductDao{

	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	public ProductDAOImpl() {
		System.out.println(this.getClass());
	}
	
	public void insertProduct(Product product) throws Exception{
		sqlSession.insert("ProductMapper.addProduct", product);
	}

	public Product findProduct(int prodNo) throws Exception{
		return sqlSession.selectOne("ProductMapper.getProduct",prodNo);
	}
	
	public List<Product> getProductList(Search search) throws Exception{
		return sqlSession.selectList("ProductMapper.getProductList",search);
	}
	
	public void updateProduct(Product product) throws Exception{
		sqlSession.update("ProductMapper.updateProduct",product);
	}

	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}
	
}
