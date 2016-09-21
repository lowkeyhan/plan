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
import com.techstar.planmanage.entity.plancheck;
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
	@Autowired
	PlancheckService plancheckService;

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
	public List<plan> findByDeptidAndYearAndPid(String deptid, String year,String pid){
		return planDao.findByDeptidAndYearAndPid(deptid, year, pid);
	}
	public List<plan> findByPid(String pid) {
		return planDao.findByPid(pid);
	}
	public List<plan> loginandtask(HttpServletRequest request,HttpServletResponse response,String code) throws UnsupportedEncodingException, OApiException {
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
				
		
		
		List<plan>  mytasek=planDao.findByFuzherenidLikeAndDeptidInAndJinduNotOrderByStimeAsc("%"+jsonauthuser.get("userid").toString()+"%",sdept, "100");
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
	
	public List<plan> getplanjindu(String deptid,String year){
		List<plan> listallPlans=planDao.findByDeptidAndYearAndPid(deptid, year, "0");
		for (plan parentplan : listallPlans) {
			List<plan> lv1taskList=planDao.findByPidAndIsdel(parentplan.getId().toString(),"0");
			int lv1size=lv1taskList.size();
			Double planjindu=0.00;
			for (plan lv1task : lv1taskList) {
				//获得lv1任务进度
				List<plan> lv2taskList=planDao.findByPidAndIsdel(lv1task.getId().toString(),"0");
				int lv2size=lv2taskList.size();
				Double lv1jindu=0.00;
				if(lv2size>0){
					for (plan lv2task : lv2taskList) {
						lv1jindu+=Double.parseDouble(lv2task.getJindu()==null?"0":lv2task.getJindu())*(1.00/lv2size);
					}
				}else{
					lv1jindu=Double.parseDouble(lv1task.getJindu()==null?"0":lv1task.getJindu());
				}
				//获得lv1任务进度结束
				//开始累计计划任务进度
				planjindu+=lv1jindu*(1.00/lv1size);
			}
			//记录plan进度
			parentplan.setJindu(planjindu+"");
		}
		return listallPlans;
		
	}
}
