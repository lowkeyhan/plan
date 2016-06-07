package com.techstar.planmanage.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;
import org.hibernate.loader.custom.Return;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.techstar.planmanage.entity.plan;
import com.techstar.planmanage.jpa.PlanDao;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.department.Department;
import com.techstar.sys.dingAPI.department.DepartmentHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;


@Service 
@Transactional
public class PlanService {
	@Autowired
	private  PlanDao planDao;
	
	

	public void save(plan repair) {
		planDao.save(repair);
	}
	public void delete(plan repair) {
		planDao.delete(repair);
	}
	
	public plan findById(Long id) {
		return planDao.findById(id);
	}
	public List<plan> findByDeptidAndYear(String deptid, String year) {
		return planDao.findByDeptidAndYear(deptid,year);
	}
	public List<Department> getdept(HttpServletRequest request,HttpServletResponse response,String code) throws UnsupportedEncodingException, OApiException {
		String authuser="";
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				authuser=URLDecoder.decode(cookie.getValue(),"UTF-8");
			}
		}
		if(authuser.equals("")){
			JSONObject jsonuser=UserHelper.getUserInfo(AuthHelper.getAccessToken(), code);
					//System.out.println(code);
			User dingdingUser=UserHelper.getUser(AuthHelper.getAccessToken(), jsonuser.getString("userid"));
			authuser=dingdingUser.toJSONString();
			Cookie cookie =new Cookie("user",URLEncoder.encode(authuser,"UTF-8") );
			cookie.setMaxAge(3600*24);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
		List<Department> mydList=new ArrayList<>();
		JSONObject jsonauthuser=JSON.parseObject(authuser);	
		String listdep=jsonauthuser.getString("isLeaderInDepts");
		
		if(!listdep.equals("null")){
		String[] arrydep=(listdep.replace("{", "").replace("}", "")).split(",");
		//获得所有部门
		List<Department> dlist=DepartmentHelper.listDepartments(AuthHelper.getAccessToken());
		//所在部门列表
		
		for (String dep : arrydep) {
			String[] depStrings=dep.split(":");
			for (Department onedep : dlist) {
				if((onedep.id).equals(depStrings[0])){
					onedep.parentid=depStrings[1];
					mydList.add(onedep);
				}
			}
		}
		}
		return mydList;
	}
}
