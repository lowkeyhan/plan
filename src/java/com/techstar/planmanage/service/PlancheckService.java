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
import com.techstar.planmanage.entity.plancheck;
import com.techstar.planmanage.jpa.PlanDao;
import com.techstar.planmanage.jpa.PlancheckDao;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.department.Department;
import com.techstar.sys.dingAPI.department.DepartmentHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;


@Service 
@Transactional
public class PlancheckService {
	@Autowired
	private  PlancheckDao plancheckDao;
	
	

	public void save(plancheck plancheck) {
		plancheckDao.save(plancheck);
	}
	public void delete(plancheck plancheck) {
		plancheckDao.delete(plancheck);
	}
	
	public plancheck findById(Long id) {
		return plancheckDao.findById(id);
	}
	public List<plancheck> findByDeptidAndYear(String deptid, String year) {
		return plancheckDao.findByDeptidAndYear(deptid,year);
	}
	
	public List<plancheck> findByDeptidInAndState(List<String> deptidlist,String state){
		return plancheckDao.findByDeptidInAndState(deptidlist,state);
	}
	public List<plancheck> findByDeptidInAndYearAndState(List<String> deptidlist,String year,String state){
		return plancheckDao.findByDeptidInAndYearAndState(deptidlist, year, state);
	}
}
