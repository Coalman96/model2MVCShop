package com.model2.mvc.web.purchase;

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
	

	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchase(@RequestParam("prodNo") int prodNo,  Model model) throws Exception {

		System.out.println("/addPurchaseView");
		Product product=productService.findProduct(prodNo);
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase( @ModelAttribute("purchase") Purchase purchase, @RequestParam("prodNo") int prodNo,  Model model, HttpSession session) throws Exception {
		
		System.out.println("/addPurchase");
		
		Product product=productService.findProduct(prodNo);
		purchase.setPurchaseProd(product);
		purchase.setBuyer((User)session.getAttribute("user"));

		System.out.println(purchase.toString());
		
		purchaseService.addPurchase(purchase);
		model.addAttribute("purchase", purchase);
		 
		return "forward:/purchase/addPurchase.jsp";
	}
	
	
	@RequestMapping(value="getPurchase")
	public String getPurchase( @ModelAttribute("purchase") Purchase purchase, Model model ) throws Exception {
		
		System.out.println("/getPurchase");
		//Business Logic
		purchase = purchaseService.getPurchase(purchase);
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/readPurchase.jsp";
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchaseView( @ModelAttribute("purchase") Purchase purchase ,  Model model ) throws Exception{

		System.out.println("/updatePurchaseView");
		//Business Logic
		purchase = purchaseService.getPurchase(purchase);
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST )
	public String updatePurchase( @ModelAttribute("purchase") Purchase purchase, Model model , @RequestParam("tranNo") int tranNo, HttpSession session) throws Exception{

		System.out.println("/updatePurchase");
		//Business Logic
		Purchase purchaseCom=purchaseService.getPurchase(purchase);
		purchase.setBuyer(purchaseCom.getBuyer());
		purchase.setPurchaseProd(purchaseCom.getPurchaseProd());
		purchase.setOrderDate(purchaseCom.getOrderDate());
		model.addAttribute("purchase", purchase);
		return "forward:/purchase/readPurchase.jsp";
	}
	
	@RequestMapping(value="listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		HttpSession session=request.getSession(true);
		System.out.println("/listPurchase");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		
		System.out.println(((User)session.getAttribute("user")).getUserId());
		Map<String , Object> map=null;
		User user=userService.getUser(((User)session.getAttribute("user")).getUserId());
		if(user.getRole().equals("admin")) {
			map=purchaseService.getSaleList(search);
		}else {
			map=purchaseService.getPurchaseList(search, ((User)session.getAttribute("user")).getUserId().trim());
		}
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return  "forward:/purchase/listPurchase.jsp";
	}
}