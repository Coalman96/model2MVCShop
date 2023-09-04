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


//==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
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

	    // 23.09.05 파일 업로드 부분
	    if (FileUpload.isMultipartContent(request)) {
	        String temDir =
	            "C:\\workspace\\07.Model2MVCShop(URI,pattern)\\src\\main\\webapp\\images\\uploadFiles\\";
	        // String temDir2= "/uploadFiles/";
	        
	        DiskFileUpload fileUpload = new DiskFileUpload();
	        fileUpload.setRepositoryPath(temDir);
	        // setSize Threshold의 크기를 벗어나게 되면 지정한 위치에 임시로 저장한다.
	        fileUpload.setSizeMax(1024 * 1024 * 10);
	        // 최대 1메가까지 업로드 가능 (1024 * 1024 * 100) <- 100MB
	        fileUpload.setSizeThreshold(1024 * 100); // 한 번에 100k 까지 메모리에 저장

	        if (request.getContentLength() < fileUpload.getSizeMax()) {
	            StringTokenizer token = null;

	            // parseRequest()는 FileItem을 포함하고 있는 List 타입을 반환한다.
	            List fileItemList = fileUpload.parseRequest(request);
	            int Size = fileItemList.size(); // HTML 페이지에서 받은 값들의 개수를 구한다
	            for (int i = 0; i < Size; i++) {
	                FileItem fileItem = (FileItem) fileItemList.get(i);
	                // isFormField()를 통해 파일 형식인지 파라미터인지 구분한다. 파라미터라면 true
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
	                } else { // 파일 형식이면...
	                    if (fileItem.getSize() > 0) { // 파일을 저장하는 if
	                        int idx = fileItem.getName().lastIndexOf("\\");
	                        // getName()은 경로를 다 가져오기 때문에 lastIndexOf로 잘라낸다
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
	            // 업로드하는 파일이 setSizeMax보다 큰 경우
	            int overSize = (request.getContentLength() / 1000000);
	            System.out.println("<script>alert('파일의 크기는 1MB까지 입니다. 올리신 파일 용량은"
	                    + overSize + "MB입니다');");
	            System.out.println("history.back();</script>");
	        }
	    } else {
	        System.out.println("인코딩 타입이 multipart/form-data가 아닙니다..");
	    }

	    
	    System.out.println("/addProduct");
	    product.setManuDate(product.getManuDate().replace("-", ""));
	    
	    // Business Logic
	    productService.insertProduct(product);
	    
	    // Model과 View 연결
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
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/readProduct.jsp";
	}
	*/
	
	@RequestMapping(value = "getProduct", method = RequestMethod.GET)
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo) throws Exception {
	    System.out.println("/getProduct");
	    
	    // Business Logic
	    Product product = productService.findProduct(prodNo);
	    
	    // Model과 View 연결
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
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	*/
	
	@RequestMapping(value = "updateProduct", method = RequestMethod.GET)
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo) throws Exception {
	    System.out.println("/updateProductView");
	    
	    // Business Logic
	    Product product = productService.findProduct(prodNo);
	    
	    // Model과 View 연결
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
	    
	    // ModelAndView 생성 및 리다이렉트 설정
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("redirect:/product/getProduct?prodNo=" + product.getProdNo());
	    
	    return modelAndView;
	}
	
	/* String return Type	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listProduct");
		System.out.println("현재페이지 수 :::::"+search.getCurrentPage());
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	*/
	
	@RequestMapping(value = "listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search, HttpServletRequest request) throws Exception {
	    System.out.println("/listProduct");
	    System.out.println("현재페이지 수 :::::" + search.getCurrentPage());
	    if (search.getCurrentPage() == 0) {
	        search.setCurrentPage(1);
	    }
	    search.setPageSize(pageSize);
	    
	    // Business logic 수행
	    Map<String, Object> map = productService.getProductList(search);
	    
	    Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
	    System.out.println(resultPage);
	    
	    // ModelAndView 생성 및 View, Model 설정
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("forward:/product/listProduct.jsp");
	    modelAndView.addObject("list", map.get("list"));
	    modelAndView.addObject("resultPage", resultPage);
	    modelAndView.addObject("search", search);
	    
	    return modelAndView;
	}
}