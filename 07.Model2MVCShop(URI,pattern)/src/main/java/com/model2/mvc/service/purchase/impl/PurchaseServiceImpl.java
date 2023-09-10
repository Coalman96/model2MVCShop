package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchas.PurchaseDao;
import com.model2.mvc.service.purchas.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{

	
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	public PurchaseServiceImpl() {
		this.purchaseDao =purchaseDao;
	}
	@Override
	public Purchase addPurchase(Purchase purchase) throws Exception {
		purchase=purchaseDao.insertPurchase(purchase);
		return purchase; 
	}
	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDao.findPurchase(tranNo);
	}
	@Override
	public Map<String,Object> getPurchaseList(Search search, String userId) throws Exception{
		return purchaseDao.getPurchaseList(search, userId);
	}
	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		return purchaseDao.getSaleList(search);
	}
	@Override
	public Purchase updatePurchase(Purchase purchase) throws Exception {
		return purchaseDao.updatePurchase(purchase);
	}
	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
		
	}
	
}
