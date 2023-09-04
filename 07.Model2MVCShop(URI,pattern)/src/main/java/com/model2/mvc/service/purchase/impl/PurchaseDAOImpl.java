package com.model2.mvc.service.purchase.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
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
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchas.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDAOImpl implements PurchaseDao {

	/// Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public PurchaseDAOImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Purchase findPurchase(Purchase purchase) throws Exception {
		purchase=sqlSession.selectOne("PurchaseMapper.findPurchase", purchase);
		System.out.println(purchase.toString());
		return purchase;
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String userId) throws Exception {
		Map<String , Object>  map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("buyerId", userId);
	
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map); 
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setBuyer((User)sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()));
			list.get(i).setPurchaseProd((Product)sqlSession.selectOne("ProductMapper.getProduct", list.get(i).getPurchaseProd().getProdNo()));
		}
		
		map.put("totalCount", sqlSession.selectOne("PurchaseMapper.getTotalCount", userId));

		map.put("list", list);

	return map;
	}
	
	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		Map<String , Object>  map = new HashMap<String, Object>();
		
		map.put("search", search);
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getSaleList", map); 
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setBuyer((User)sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()));
			list.get(i).setPurchaseProd((Product)sqlSession.selectOne("ProductMapper.getProduct", list.get(i).getPurchaseProd().getProdNo()));
		}
		
		map.put("totalCount", sqlSession.selectOne("PurchaseMapper.getSaleCount"));

		map.put("list", list);
		
		return map;
	}
	
	@Override
	public Purchase insertPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
		return purchase;
	}

	@Override
	public Purchase updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
		return purchase;
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	@Override
	public int getTotalCount(String userId) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", userId);
	}
}
