package com.techstar.planmanage.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javassist.expr.NewArray;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.sql.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.techstar.planmanage.entity.checklog;
import com.techstar.planmanage.entity.plan;
import com.techstar.planmanage.entity.plancheck;
import com.techstar.planmanage.entity.power;
import com.techstar.planmanage.service.ChecklogService;
import com.techstar.planmanage.service.PlanService;
import com.techstar.planmanage.service.PlancheckService;
import com.techstar.planmanage.service.powerService;
import com.techstar.sys.Util.StringUtil;
import com.techstar.sys.config.Global;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.department.Department;
import com.techstar.sys.dingAPI.department.DepartmentHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;
import com.techstar.sys.jpadomain.Results;



/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/pccheck")
public class PCplancheckContorller {
	@Autowired
	private PlancheckService plancheckService;
	@Autowired
	private powerService powerService;
	@Autowired
	private ChecklogService checklogService;
	@RequestMapping("/getstate12")
	public String test(Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
	//	return "plan/plandeptlist";
		return "pcplan/index";
	}
	
	@RequestMapping("/checklist")
	public String checklist(Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
	//	return "plan/plandeptlist";
		return "pcplan/shenheindex";
	}
	@RequestMapping("/shenheview")
	public String shenheview(@RequestParam(value="checkid",required=false)String checkid,Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
		model.addAttribute("id", checkid);
	//	return "plan/plandeptlist";
		return "pcplan/shenheview";
	}
	@RequestMapping("/shenpiadd")
	public String shenpiadd(@RequestParam(value="checkid",required=false)String checkid,Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		plancheck planchecks=plancheckService.findById(Long.parseLong(checkid));
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plancheck", planchecks);
		return "pcplan/shenpiadd";
	}
	
	@RequestMapping("/getowerallcheck")
	public @ResponseBody Results  getstate(
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException, ParseException {
		
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		String operationerid="";
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				JSONObject userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				operationerid=userJsonObject.get("userid").toString();
			}
		}
		Calendar nowCalendar=Calendar.getInstance();
		String year= nowCalendar.get(Calendar.YEAR)+"";
		List<plancheck> listcheckList=plancheckService.findoperationeridyearcheck(operationerid, year);
		
		return  new Results(listcheckList);
	}
	
	@RequestMapping("/findshenpiall")
	public @ResponseBody Results  findshenpiall(
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException, ParseException {
		
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		String operationerid="";
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				JSONObject userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				operationerid=userJsonObject.get("userid").toString();
			}
		}
		Calendar nowCalendar=Calendar.getInstance();
		String year= nowCalendar.get(Calendar.YEAR)+"";
		List<plancheck> listcheckList=plancheckService.findshenpiall(operationerid, year);
		
		return  new Results(listcheckList);
	}
	
	
	
}
