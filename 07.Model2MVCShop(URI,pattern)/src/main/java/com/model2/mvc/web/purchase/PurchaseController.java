package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
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

	public PurchaseController(){
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
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.GET)
	public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("purchase/addPurchaseView");
	    
	    //Business Logic
	    Product product = productService.findProduct(prodNo);
	    
	    
	    // Model 과 View 연결
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/purchase/addPurchaseView.jsp");
	    modelAndView.addObject("product", product);
	    
	    return modelAndView;
	}
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.POST)
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase, 
										@RequestParam("prodNo") int prodNo,
										HttpSession session) throws Exception {
		
		System.out.println("purchase/addPurchase");

	    Product product = productService.findProduct(prodNo);
	    purchase.setPurchaseProd(product);
	    purchase.setBuyer((User) session.getAttribute("user"));

	    
	    //Business Logic
	    purchaseService.addPurchase(purchase);
	    
	    //updateProductCount에 prodNo과 prodCount전송용 map
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("purchase", purchase);
	    map.put("prodNo", prodNo);
	    productService.updateProductCount(map);
	    System.out.println(purchase.toString());
	    
	    // Model 과 View 연결
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/purchase/addPurchase.jsp");
	    modelAndView.addObject("purchase", purchase);
	    
	    return modelAndView;
	}
	
	@RequestMapping(value = "getPurchase")
	public ModelAndView getPurchase(@RequestParam("tranNo") Integer tranNo) throws Exception {
		
		System.out.println("purchase/getPurchase");
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		// Model 과 View 연결
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/purchase/getPurchase.jsp");
	    modelAndView.addObject("purchase", purchase);
	    
	    return modelAndView;
	}
	
	
	@RequestMapping(value = "updatePurchaseView", method = RequestMethod.GET)
	public ModelAndView updatePurchaseView(@RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("purchase/updatePurchaseView");
		
	    //Business Logic
	    Purchase purchase = purchaseService.getPurchase(tranNo);
	    Product product = productService.findProduct(purchase.getPurchaseProd().getProdNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/purchase/updatePurchaseView.jsp");
	    modelAndView.addObject("purchase", purchase);
	    modelAndView.addObject("product", product);
	    return modelAndView;
	}
	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.POST)
	public ModelAndView updatePurchase(@ModelAttribute("purchase") Purchase purchase,
										@RequestParam("productCount") int productCount,
										HttpSession session) throws Exception {
		
		System.out.println("purchase/updatePurchase");
		
	    
		Purchase getPurchase = purchaseService.getPurchase(purchase.getTranNo());

	    purchase.setBuyer(getPurchase.getBuyer());
	    purchase.setPurchaseProd(getPurchase.getPurchaseProd());
	    purchase.setOrderDate(getPurchase.getOrderDate());
		purchase = purchaseService.updatePurchase(purchase);
		
	    //product count 수정
	    if(productCount != purchase.getProdCount()) {
	    	
	    	Map<String, Object> map = new HashMap<String, Object>();
	    	map.put("purchase", purchase);
	    	map.put("prodNo", purchase.getPurchaseProd().getProdNo());
	    	productService.updateProductCount(map);
	    	
	    }
	    System.out.println("업데이트된 purchase는 "+purchase);
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/purchase/getPurchase.jsp");
	    modelAndView.addObject("purchase", purchase);
	    
	    return modelAndView;
	}
	
	@RequestMapping(value = "updateTranCode", method = RequestMethod.GET)
	public void updateTranCode(@RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("purchase/updateTranCode");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
	    purchaseService.updateTranCode(purchase);

	}

	@RequestMapping(value = "listPurchase")
	public ModelAndView listPurchase(@ModelAttribute("search") Search search, HttpServletRequest request) throws Exception {
	    
		System.out.println("/listPurchase");
		
	    HttpSession session = request.getSession(true);
	    
	   
	    if (search.getCurrentPage() == 0) {
	        search.setCurrentPage(1);
	    }
	    search.setPageSize(pageSize);
	    
	    //Business Logic
	    Map<String, Object> map = null;
	    
	    User user = userService.getUser(((User) session.getAttribute("user")).getUserId());
	    
	    if (user.getRole().equals("admin")) {
	        map = purchaseService.getSaleList(search);
	    } else {
	        map = purchaseService.getPurchaseList(search, ((User) session.getAttribute("user")).getUserId().trim());
	    }
	    
	    Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
	    System.out.println(resultPage);
		
	    // Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/purchase/listPurchase.jsp");
	    modelAndView.addObject("list", map.get("list"));
	    modelAndView.addObject("resultPage", resultPage);
	    modelAndView.addObject("search", search);
	    
	    return modelAndView;
	}
	
	@RequestMapping(value = "listSale")
	public ModelAndView listSale(@ModelAttribute("search") Search search, HttpServletRequest request) throws Exception {
	    
		System.out.println("/listPurchase");
		
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
		
	    // Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/purchase/listSale.jsp");
	    modelAndView.addObject("list", map.get("list"));
	    modelAndView.addObject("resultPage", resultPage);
	    modelAndView.addObject("search", search);
	    
	    return modelAndView;
	}


}