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
import com.techstar.planmanage.entity.power;
import com.techstar.planmanage.jpa.PlanDao;
import com.techstar.planmanage.jpa.PlancheckDao;
import com.techstar.planmanage.jpa.checklogDao;
import com.techstar.planmanage.jpa.powerDao;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.department.Department;
import com.techstar.sys.dingAPI.department.DepartmentHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;


@Service 
@Transactional
public class powerService {
	@Autowired
	private  powerDao powerDao;
	
	public List<power> findAll() {
		return powerDao.findAll();
	}

	public void save(power power) {
		powerDao.save(power);
	}
	public void delete(power power) {
		powerDao.delete(power);
	}
	
	public power findById(Long id) {
		return powerDao.findById(id);
	}
	public List<power> findByAdminidAndType(String Adminid,String type) {
		return powerDao.findByAdminidAndType(Adminid, type);
	}
	public List<power> findByType(String type) {
		return powerDao.findByType(type);
	}
}
