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
import com.model2.mvc.service.product.ProductService;


//==> 상품관리 Controller
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
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
	                uploadDir.mkdirs(); // 디렉토리가 존재하지 않으면 생성
	            }

	            try {
	                String uploadedFilePath = uploadPath + File.separator + originalFileName;
	                file.transferTo(new File(uploadedFilePath));
	                // 파일 이름을 리스트에 추가
	                fileNames.add(originalFileName);
	                product.setFileName(fileNames.toString().replace("[", "").replace("]", ""));
	            } catch (IOException e) {
	                e.printStackTrace();
	                // 파일 업로드 중 오류 발생 시 예외 처리
	            }
	        }
	    }
		
	    System.out.println("/product/addProduct");

	    product.setManuDate(product.getManuDate().replace("-", ""));
	    
	    // Business Logic
	    productService.insertProduct(product);
	    
	    
	    return product;
	}

	
}