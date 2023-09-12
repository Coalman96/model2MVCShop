package com.model2.mvc.web.purchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchas.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;


//==> 상품관리 Controller
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음

	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value = "json/updateTranCode/{tranNo}/{updateTranCode}", method = RequestMethod.GET)
	public void updateTranCode(@PathVariable("tranNo") int tranNo,
								@PathVariable("updateTranCode") String updateTranCode) throws Exception {
		
		System.out.println("purchase/json/updateTranCode");
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(updateTranCode);
		purchase.setTranNo(tranNo);

	    purchaseService.updateTranCode(purchase);

		
		
		

	}

	@RequestMapping(value = "json/listPurchase")
	public Map<String , Object> listPurchase(@RequestBody Search search, HttpServletRequest request) throws Exception {
	    
		System.out.println("json/listPurchase");
		
	    HttpSession session = request.getSession(true);
	    
	   
	    if (search.getCurrentPage() == 0) {
	        search.setCurrentPage(1);
	    }
	    search.setPageSize(pageSize);
	    
	    //Business Logic
	    Map<String, Object> map = null;
	    
	    User user = userService.getUser(((User) session.getAttribute("user")).getUserId());
	    
	    if (user.getRole().equals("admin")) {
	    	System.out.println("앙 기모띠");
	        map = purchaseService.getSaleList(search);
	    } else {
	    	System.out.println("하 시발");
	        map = purchaseService.getPurchaseList(search, ((User) session.getAttribute("user")).getUserId().trim());
	        
	    }
	    
	    Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
	    System.out.println(resultPage);
		
	    // AutoComplete추가 코드
	 		 List<String> resultList = new ArrayList<>();
	 		 List<Purchase> saleList = (List<Purchase>) map.get("list");
	 		
	 		for (Purchase sale : saleList) {
	 			 if ("0".equals(search.getSearchCondition())) {
	 		            // searchCondition이 0인 경우 상품번호를 리스트에 추가
	 		            resultList.add(""+sale.getPurchaseProd().getProdName());
	 		        }
	 	        
	 	    }

		    map.put("resultList", resultList);
		    // 추가 코드 끝
		    map.put("list", map.get("list"));
		    map.put("resultPage", resultPage);
		    map.put("search", search);
		    
		    return map;
	}
	/*
	@RequestMapping(value = "json/listSale")
	public  Map<String , Object> listSale(@RequestBody Search search, HttpServletRequest request) throws Exception {
	    
		System.out.println("json/listSale");
		
	    HttpSession session = request.getSession(true);
	    
	   
	    if (search.getCurrentPage() == 0) {
	        search.setCurrentPage(1);
	    }
	    search.setPageSize(pageSize);
	    
	    //Business Logic
	    Map<String, Object> map = null;
	    
	    map = purchaseService.getSaleList(search);

	    Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
	    System.out.println(resultPage);
		
	    // AutoComplete추가 코드
	    List<String> resultList = new ArrayList<>();
		 List<Purchase> saleList = (List<Purchase>) map.get("list");
		
	 		for (Purchase sale : saleList) {
	 			 if ("0".equals(search.getSearchCondition())) {
	 		            // searchCondition이 0인 경우 상품번호를 리스트에 추가
	 		            resultList.add(""+sale.getPurchaseProd().getProdName());
	 		        }
	 	        
	 	    }

		    map.put("resultList", resultList);
		    // 추가 코드 끝
		    map.put("list", map.get("list"));
		    map.put("resultPage", resultPage);
		    map.put("search", search);
		    
		    return map;
	}
*/

}