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
import com.techstar.planmanage.entity.planchange;
import com.techstar.planmanage.entity.plancheck;
import com.techstar.planmanage.service.ChecklogService;
import com.techstar.planmanage.service.PlanService;
import com.techstar.planmanage.service.PlanchangeService;
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
@RequestMapping("/pcchange")
public class PCplanchangeContorller {
	@Autowired
	private PlanService planService;
	@Autowired
	private PlanchangeService planchangeService;
	@Autowired
	private PlancheckService plancheckService;
	@Autowired
	private ChecklogService checklogService;
	
	@RequestMapping("/taskchange")
	public String taskchange(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		return "pcplan/taskchange";
	}
	@RequestMapping("/planchange")
	public String planchange(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		return "pcplan/planchange";
	}
	
	@RequestMapping("/shenhechange")
	public String shenhechange(@RequestParam(value="id",required=false)String id,
			@RequestParam(value="tid",required=false)String tid,
			@RequestParam(value="cid",required=false)String cid,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(tid));
		planchange changePlan=planchangeService.findById(Long.parseLong(cid));
		plancheck plancheck=plancheckService.findById(Long.parseLong(id));
		
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		model.addAttribute("changeplan", changePlan);
		model.addAttribute("plancheck", plancheck);
		return "pcplan/shenhechange";
	}
	@RequestMapping("/shenheplanchange")
	public String shenheplanchange(@RequestParam(value="id",required=false)String id,
			@RequestParam(value="tid",required=false)String tid,
			@RequestParam(value="cid",required=false)String cid,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(tid));
		planchange changePlan=planchangeService.findById(Long.parseLong(cid));
		plancheck plancheck=plancheckService.findById(Long.parseLong(id));
		
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		model.addAttribute("changeplan", changePlan);
		model.addAttribute("plancheck", plancheck);
		return "pcplan/shenheplanchange";
	}
	@RequestMapping("/oldchange")
	public String oldchange(@RequestParam(value="id",required=false)String id,
			@RequestParam(value="tid",required=false)String tid,
			@RequestParam(value="cid",required=false)String cid,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		planchange changePlan=planchangeService.findById(Long.parseLong(cid));
		plancheck plancheck=plancheckService.findById(Long.parseLong(id));
		
		model.addAttribute("authconfig", configstr);
		model.addAttribute("changeplan", changePlan);
		model.addAttribute("plancheck", plancheck);
		model.addAttribute("id", id);
		return "pcplan/changelogview";
	}
	@RequestMapping("/taskdel")
	public String taskdel(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		return "pcplan/taskdel";
	}
	@RequestMapping("/plandel")
	public String plandel(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		return "pcplan/plandel";
	}
	
	@RequestMapping("/shenhedel")
	public String shenhedel(@RequestParam(value="id",required=false)String id,
			@RequestParam(value="tid",required=false)String tid,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(tid));
		plancheck plancheck=plancheckService.findById(Long.parseLong(id));
		
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		model.addAttribute("plancheck", plancheck);
		return "pcplan/shenhedel";
	}
	@RequestMapping("/shenheplandel")
	public String shenheplandel(@RequestParam(value="id",required=false)String id,
			@RequestParam(value="tid",required=false)String tid,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(tid));
		plancheck plancheck=plancheckService.findById(Long.parseLong(id));
		
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		model.addAttribute("plancheck", plancheck);
		return "pcplan/shenheplandel";
	}
	
	
}
