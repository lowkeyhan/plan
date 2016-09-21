package com.techstar.planmanage.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.techstar.planmanage.entity.planchange;
import com.techstar.planmanage.entity.plancheck;
import com.techstar.planmanage.jpa.PlanDao;
import com.techstar.planmanage.jpa.PlanchangeDao;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.department.Department;
import com.techstar.sys.dingAPI.department.DepartmentHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;


@Service 
@Transactional
public class PlanchangeService {
	@Autowired
	private  PlanchangeDao planchangeDao;
	@Autowired
	PlancheckService plancheckService;

	public void save(planchange repair) {
		planchangeDao.save(repair);
	}
	public void delete(planchange repair) {
		planchangeDao.delete(repair);
	}
	
	public planchange findById(Long id) {
		return planchangeDao.findById(id);
	}
	public List<planchange> findByTaskidOrderByOperationdateDesc(String Taskid) {
		return planchangeDao.findByTaskidOrderByOperationdateDesc(Taskid);
	}
	public List<planchange> findByDeptidAndYear(String deptid, String year) {
		return planchangeDao.findByDeptidAndYear(deptid,year);
	}
	public List<planchange> findByDeptidAndYearAndPid(String deptid, String year,String pid){
		return planchangeDao.findByDeptidAndYearAndPid(deptid, year, pid);
	}
	public List<planchange> findByPid(String pid) {
		return planchangeDao.findByPid(pid);
	}
	public List<planchange> loginandtask(HttpServletRequest request,HttpServletResponse response,String code) throws UnsupportedEncodingException, OApiException {
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
		JSONObject jsonauthuser=JSON.parseObject(authuser);	
		//获得年份
		Calendar nowCalendar=Calendar.getInstance();
		String yearString=nowCalendar.get(Calendar.YEAR)+"";
		//获得用户部门
		String listdep=jsonauthuser.getString("isLeaderInDepts");
		List<String> deptList=new ArrayList<String>();
		//查询部门计划是否审核
		if(!listdep.equals("null")){
			String[] arrydep=(listdep.replace("{", "").replace("}", "")).split(",");
			for (String dep : arrydep) {
				String[] depStrings=dep.split(":");
				deptList.add(depStrings[0]);
			}
		}
		List<plancheck> sPlanchecks=plancheckService.findByDeptidInAndYearAndState(deptList, yearString, "4");
		//获得已审核部门
		List<String> sdept=new ArrayList<String>();
		sdept.add("0");
		for (plancheck p:sPlanchecks) {
			sdept.add(p.getDeptid());
		}
				
		
		
		List<planchange>  mytasek=planchangeDao.findByFuzherenidLikeAndDeptidInAndJinduNotOrderByStimeAsc("%"+jsonauthuser.get("userid").toString()+"%",sdept, "100");
		return mytasek;
	}
	
	public List<Department> getdept(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException, OApiException {
		String authuser="";
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				authuser=URLDecoder.decode(cookie.getValue(),"UTF-8");
			}
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
				//TODO 判断主管
				//if((onedep.id).equals(depStrings[0])&&depStrings[1].equals("true")){
				if((onedep.id).equals(depStrings[0])){	
					mydList.add(onedep);
				}
			}
		}
		}
		return mydList;
	}
}
