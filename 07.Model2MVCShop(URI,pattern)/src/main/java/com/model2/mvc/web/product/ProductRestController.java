package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;


//==> ��ǰ���� Controller
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductRestController(){
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

	@RequestMapping(value="/json/addProduct", method=RequestMethod.POST)
	public Product addProduct(@ModelAttribute("product") Product product, 
			@RequestParam("file") MultipartFile[] files,
				HttpServletRequest request) throws Exception {
		
	   
	    System.out.println("/product/json/addProduct");
	    List<String> fileNames = new ArrayList<>();
		for (MultipartFile file : files) {
	        if (!file.isEmpty()) {
	            String originalFileName = file.getOriginalFilename();
	            String uploadPath = request.getServletContext().getRealPath("/images/uploadFiles/");

	            File uploadDir = new File(uploadPath);
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs(); // ���丮�� �������� ������ ����
	            }

	            try {
	                String uploadedFilePath = uploadPath + File.separator + originalFileName;
	                file.transferTo(new File(uploadedFilePath));
	                // ���� �̸��� ����Ʈ�� �߰�
	                fileNames.add(originalFileName);
	                product.setFileName(fileNames.toString().replace("[", "").replace("]", ""));
	            } catch (IOException e) {
	                e.printStackTrace();
	                // ���� ���ε� �� ���� �߻� �� ���� ó��
	            }
	        }
	    }
		
	    System.out.println("/product/addProduct");

	    product.setManuDate(product.getManuDate().replace("-", ""));
	    
	    // Business Logic
	    productService.insertProduct(product);
	    
	    
	    return product;
	}
	
	@RequestMapping(value = "json/listProduct", method=RequestMethod.POST)
	public Map<String , Object> listProduct(@RequestBody Search search) throws Exception {
	    
		System.out.println("json/listProduct");
	   
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}else {
			
			search.setCurrentPage(search.getCurrentPage()+1);
			
		}
		
	    search.setPageSize(pageSize);
	    
	    // Business logic ����
	    Map<String, Object> map = productService.getProductList(search);
	    
	    Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
	    System.out.println(resultPage);
	    
	    // AutoComplete�߰� �ڵ�
		 List<String> resultList = new ArrayList<>();
		 List<Product> productList = (List<Product>) map.get("list");
		
		for (Product product : productList) {
			 if ("0".equals(search.getSearchCondition())) {
		            // searchCondition�� 0�� ��� userId�� ����Ʈ�� �߰�
		            resultList.add(""+product.getProdNo());
		        } else if ("1".equals(search.getSearchCondition())) {
		            // searchCondition�� 1�� ��� userName�� ����Ʈ�� �߰�
		            resultList.add(product.getProdName());
		        } else if ("2".equals(search.getSearchCondition())) {
		            // searchCondition�� 1�� ��� userName�� ����Ʈ�� �߰�
		            resultList.add(""+product.getPrice());
		        }
	        // �ٸ� ���ǿ� ���� �߰� �۾� ���� ����
	    }

	    map.put("resultList", resultList);
	    // �߰� �ڵ� ��
	    map.put("list", map.get("list"));
	    map.put("resultPage", resultPage);
	    map.put("search", search);
	    
	    return map;
	}
	
}