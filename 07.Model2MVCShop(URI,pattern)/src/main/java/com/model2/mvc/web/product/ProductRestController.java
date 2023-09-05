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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
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
	public Product addProduct(@RequestBody Product product, HttpServletRequest request) throws Exception {
		System.out.println("아씨발");
	    // 23.09.05 파일 업로드 부분
	    if (FileUpload.isMultipartContent(request)) {
	        //String temDir =
	          //  "C:\\workspace\\07.Model2MVCShop(URI,pattern)\\src\\main\\webapp\\images\\uploadFiles\\";
	        String temDir2= "/uploadFiles/";
	        
	        DiskFileUpload fileUpload = new DiskFileUpload();
	        fileUpload.setRepositoryPath(temDir2);
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
	                            File uploadedFile = new File(temDir2, fileName);
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
	    

	    System.out.println("/product/json/addProduct");
	    product.setManuDate(product.getManuDate().replace("-", ""));
	    
	    // Business Logic
	    productService.insertProduct(product);
	    
	    return product;
	}

	
}