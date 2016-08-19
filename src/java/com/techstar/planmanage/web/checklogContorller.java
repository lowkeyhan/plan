package com.techstar.planmanage.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javassist.expr.NewArray;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
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
import com.techstar.planmanage.service.ChecklogService;
import com.techstar.planmanage.service.PlanService;
import com.techstar.planmanage.service.PlancheckService;
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
@RequestMapping("/checklog")
public class checklogContorller {
	@Autowired
	private ChecklogService checklogService;
	@Autowired
	private PlanService planService;
	
	//@RequestMapping("/getstate12")
	//public String test(Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		//String configstr= AuthHelper.getConfig(request);
		//model.addAttribute("authconfig", configstr);
	//	return "plan/plandeptlist";
		//return "plan/index";
	//}
	
	


	@RequestMapping("/getlog")
	public @ResponseBody Results  getstate(@RequestParam(value="taskid",required=false)String taskid,
			@RequestParam(value="type",required=false)String type,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		List<checklog> listcheckList=checklogService.findByTaskidAndTypeOrderByIdDesc(taskid, type);
		
		return  new Results(listcheckList);
	}
	
	@RequestMapping("/getchecklog")
	public @ResponseBody Results  getchecklog(@RequestParam(value="checkid",required=false)String checkid,
			@RequestParam(value="type",required=false)String type,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		List<checklog> listcheckList=checklogService.findByCheckidAndTypeOrderByIdDesc(checkid, type);
		
		return  new Results(listcheckList);
	}
	
	@RequestMapping("/addjindu")
	public @ResponseBody Results  addjindu(@RequestParam(value="taskid",required=false)String taskid,
			@RequestParam(value="shuju",required=false)String shuju,
			@RequestParam(value="shuoming",required=false)String shuoming,
			@RequestParam(value="type",required=false)String type,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		plan jinduPlan=planService.findById(Long.parseLong(taskid));
		jinduPlan.setJindu(shuju);
		planService.save(jinduPlan);
		
		checklog addlogChecklog=new checklog();
		JSONObject userJsonObject=null;
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
			}
		}
		addlogChecklog.setShuju(shuju);
		addlogChecklog.setShuoming(shuoming);
		addlogChecklog.setTaskid(taskid);
		addlogChecklog.setType(type);
		addlogChecklog.setOperationer(userJsonObject.get("name").toString());
		addlogChecklog.setOperationerid(userJsonObject.get("userid").toString());
		checklogService.save(addlogChecklog);
		return  new Results("提交进度成功");
	}
	
}
