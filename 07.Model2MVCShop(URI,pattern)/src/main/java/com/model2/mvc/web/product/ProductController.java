package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
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
import com.model2.mvc.service.product.ProductService;


//==> ��ǰ���� Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	/* String return Type
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product,  Model model) throws Exception {

		System.out.println("/addProduct");
		product.setManuDate(product.getManuDate().replace("-", ""));
		productService.insertProduct(product);
		
		model.addAttribute("proudct", product);
		
		return "forward:/product/readProduct.jsp";
	}
	*/
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public ModelAndView addProduct(@ModelAttribute("product") Product product, HttpServletRequest request) throws Exception {

	    // 23.09.05 ���� ���ε� �κ�
	    if (FileUpload.isMultipartContent(request)) {
	        String temDir =
	            "C:\\workspace\\07.Model2MVCShop(URI,pattern)\\src\\main\\webapp\\images\\uploadFiles\\";
	        // String temDir2= "/uploadFiles/";
	        
	        DiskFileUpload fileUpload = new DiskFileUpload();
	        fileUpload.setRepositoryPath(temDir);
	        // setSize Threshold�� ũ�⸦ ����� �Ǹ� ������ ��ġ�� �ӽ÷� �����Ѵ�.
	        fileUpload.setSizeMax(1024 * 1024 * 10);
	        // �ִ� 1�ް����� ���ε� ���� (1024 * 1024 * 100) <- 100MB
	        fileUpload.setSizeThreshold(1024 * 100); // �� ���� 100k ���� �޸𸮿� ����

	        if (request.getContentLength() < fileUpload.getSizeMax()) {
	            StringTokenizer token = null;

	            // parseRequest()�� FileItem�� �����ϰ� �ִ� List Ÿ���� ��ȯ�Ѵ�.
	            List fileItemList = fileUpload.parseRequest(request);
	            int Size = fileItemList.size(); // HTML ���������� ���� ������ ������ ���Ѵ�
	            for (int i = 0; i < Size; i++) {
	                FileItem fileItem = (FileItem) fileItemList.get(i);
	                // isFormField()�� ���� ���� �������� �Ķ�������� �����Ѵ�. �Ķ���Ͷ�� true
	                if (fileItem.isFormField()) {
	                    if (fileItem.getFieldName().equals("manuDate")) {
	                        token = new StringTokenizer(fileItem.getString("euc-kr"), "-");
	                        String manuDate = token.nextToken() + token.nextToken() + token.nextToken();
	                        product.setManuDate(manuDate);
	                    } else if (fileItem.getFieldName().equals("prodName"))
	                        product.setProdName(fileItem.getString("euc-kr"));
	                    else if (fileItem.getFieldName().equals("prodDetail"))
	                        product.setProdDetail(fileItem.getString("euc-kr"));
	                    else if (fileItem.getFieldName().equals("price"))
	                        product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
	                } else { // ���� �����̸�...
	                    if (fileItem.getSize() > 0) { // ������ �����ϴ� if
	                        int idx = fileItem.getName().lastIndexOf("\\");
	                        // getName()�� ��θ� �� �������� ������ lastIndexOf�� �߶󳽴�
	                        if (idx == -1) {
	                            idx = fileItem.getName().lastIndexOf("/");
	                        }
	                        String fileName = fileItem.getName().substring(idx + 1);
	                        product.setFileName(fileName);
	                        try {
	                            File uploadedFile = new File(temDir, fileName);
	                            fileItem.write(uploadedFile);
	                        } catch (IOException e) {
	                            System.out.println(e);
	                        }
	                    } else {
	                        product.setFileName("../../images/empty.GIF");
	                    }
	                }
	            }
	            
	        } else {
	            // ���ε��ϴ� ������ setSizeMax���� ū ���
	            int overSize = (request.getContentLength() / 1000000);
	            System.out.println("<script>alert('������ ũ��� 1MB���� �Դϴ�. �ø��� ���� �뷮��"
	                    + overSize + "MB�Դϴ�');");
	            System.out.println("history.back();</script>");
	        }
	    } else {
	        System.out.println("���ڵ� Ÿ���� multipart/form-data�� �ƴմϴ�..");
	    }

	    
	    System.out.println("/addProduct");
	    product.setManuDate(product.getManuDate().replace("-", ""));
	    
	    // Business Logic
	    productService.insertProduct(product);
	    
	    // Model�� View ����
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/product/readProduct.jsp");
	    modelAndView.addObject("product", product);
	    
	    return modelAndView;
	}

	
	/* String return Type
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception {
		
		System.out.println("/getProduct");
		//Business Logic
		Product product = productService.findProduct(prodNo);
		// Model �� View ����
		model.addAttribute("product", product);
		
		return "forward:/product/readProduct.jsp";
	}
	*/
	
	@RequestMapping(value = "getProduct", method = RequestMethod.GET)
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo) throws Exception {
	    System.out.println("/getProduct");
	    
	    // Business Logic
	    Product product = productService.findProduct(prodNo);
	    
	    // Model�� View ����
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/product/readProduct.jsp");
	    modelAndView.addObject("product", product);
	    
	    return modelAndView;
	}

	/* String return Type
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/updateProductView");
		//Business Logic
		Product product = productService.findProduct(prodNo);
		// Model �� View ����
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	*/
	
	@RequestMapping(value = "updateProduct", method = RequestMethod.GET)
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo) throws Exception {
	    System.out.println("/updateProductView");
	    
	    // Business Logic
	    Product product = productService.findProduct(prodNo);
	    
	    // Model�� View ����
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/product/updateProduct.jsp");
	    modelAndView.addObject("product", product);
	    
	    return modelAndView;
	}

	/* String return Type	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product, Model model , HttpSession session) throws Exception{

		System.out.println("/updateProduct");
		//Business Logic
		productService.updateProduct(product);
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo();
	}
	*/
	
	@RequestMapping(value = "updateProduct", method = RequestMethod.POST)
	public ModelAndView updateProduct(@ModelAttribute("product") Product product, HttpSession session) throws Exception {
	   
		System.out.println("/updateProduct");
	    
	    // Business Logic
	    productService.updateProduct(product);
	    
	    // ModelAndView ���� �� �����̷�Ʈ ����
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("redirect:/product/getProduct?prodNo=" + product.getProdNo());
	    
	    return modelAndView;
	}
	
	/* String return Type	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listProduct");
		System.out.println("���������� �� :::::"+search.getCurrentPage());
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	*/
	
	@RequestMapping(value = "listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search, HttpServletRequest request) throws Exception {
	    System.out.println("/listProduct");
	    System.out.println("���������� �� :::::" + search.getCurrentPage());
	    if (search.getCurrentPage() == 0) {
	        search.setCurrentPage(1);
	    }
	    search.setPageSize(pageSize);
	    
	    // Business logic ����
	    Map<String, Object> map = productService.getProductList(search);
	    
	    Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
	    System.out.println(resultPage);
	    
	    // ModelAndView ���� �� View, Model ����
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/product/listProduct.jsp");
	    modelAndView.addObject("list", map.get("list"));
	    modelAndView.addObject("resultPage", resultPage);
	    modelAndView.addObject("search", search);
	    
	    return modelAndView;
	}
}