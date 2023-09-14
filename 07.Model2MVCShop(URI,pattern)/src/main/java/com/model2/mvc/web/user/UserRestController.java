package com.model2.mvc.web.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping( value="json/updateUser/{userId}", method=RequestMethod.GET )
	public User updateUser( @PathVariable String userId) throws Exception{

		System.out.println("/user/json/updateUser : GET");
		
		//Business Logic
		User user = userService.getUser(userId);
		
		
		return user;
	}
	
	@RequestMapping( value="json/checkDuplication/{userId}", method=RequestMethod.POST )
	public Map checkDuplication( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/checkDuplication : POST"+userId);
		
		//Business Logic
		boolean result=userService.checkDuplication(userId);

		// Model �� View ����
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", new Boolean(result));
		map.put("userId", userId);

		return map;
	}
	
	@RequestMapping( value="json/listUser", method=RequestMethod.POST )
	public Map<String , Object> listUser( @RequestBody Search search) throws Exception{
		
		System.out.println("/user/json/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}else {
			
			search.setCurrentPage(search.getCurrentPage()+1);
			
		}

		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// AutoComplete�߰� �ڵ�
		 List<String> resultList = new ArrayList<>();
		 List<User> userList = (List<User>) map.get("list");
		
		for (User user : userList) {
			 if ("0".equals(search.getSearchCondition())) {
		            // searchCondition�� 0�� ��� userId�� ����Ʈ�� �߰�
		            resultList.add(user.getUserId());
		        } else if ("1".equals(search.getSearchCondition())) {
		            // searchCondition�� 1�� ��� userName�� ����Ʈ�� �߰�
		            resultList.add(user.getUserName());
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