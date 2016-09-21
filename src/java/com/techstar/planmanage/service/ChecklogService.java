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
import com.techstar.planmanage.entity.checklog;
import com.techstar.planmanage.entity.plan;
import com.techstar.planmanage.entity.plancheck;
import com.techstar.planmanage.jpa.PlanDao;
import com.techstar.planmanage.jpa.PlancheckDao;
import com.techstar.planmanage.jpa.checklogDao;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.department.Department;
import com.techstar.sys.dingAPI.department.DepartmentHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;


@Service 
@Transactional
public class ChecklogService {
	@Autowired
	private  checklogDao checklogdao;
	
	

	public void save(checklog checklog) {
		checklogdao.save(checklog);
	}
	public void delete(checklog checklog) {
		checklogdao.delete(checklog);
	}
	
	public checklog findById(Long id) {
		return checklogdao.findById(id);
	}
	public List<checklog> findByCheckid(String checkid) {
		return checklogdao.findByCheckid(checkid);
	}
	public List<checklog> findByTaskid(String taskid) {
		return checklogdao.findByTaskid(taskid);
	}
	public List<checklog> findByTaskidAndTypeOrderByIdDesc(String taskid,String type) {
		return checklogdao.findByTaskidAndTypeOrderByIdDesc(taskid, type);
	}
	public List<checklog> findByCheckidAndTypeOrderByIdDesc(String taskid,String type) {
		return checklogdao.findByCheckidAndTypeOrderByIdDesc(taskid, type);
	}
	public List<checklog> findByCheckidAndTypeInOrderByIdDesc(String taskid,List<String> typelist){
		
		return checklogdao.findByCheckidAndTypeInOrderByIdDesc(taskid, typelist);
	}
}
