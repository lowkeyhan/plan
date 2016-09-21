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
import com.techstar.planmanage.entity.plan;
import com.techstar.planmanage.entity.planchange;
import com.techstar.planmanage.service.PlanService;
import com.techstar.planmanage.service.PlanchangeService;
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
@RequestMapping("/plan")
public class planContorller {
	@Autowired
	private PlanService planService;
	@Autowired
	private PlanchangeService planchangeService;
	
	
	@RequestMapping("/index")
	public String test(Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
	//	return "plan/plandeptlist";
		return "plan/index";
	}
	
	
	/** 跳转部门计划列表页面
	 * @param deptid 部门id
	 * @param model 记录部门id/授权信息/年份/
	 * @param request
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/planlist")
	public String planlist(@RequestParam(value="deptid",required=false)String deptid,
			HttpServletResponse response,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
		List<Department> mydepDepartments=planService.getdept(request, response);
		Calendar nowCalendar=Calendar.getInstance();
		model.addAttribute("year", nowCalendar.get(Calendar.YEAR));
		if(StringUtil.isNotBlank(deptid)){
			for (Department department : mydepDepartments) {
				if(deptid.equals(department.id)){
					model.addAttribute("deptid",department.id );
					model.addAttribute("deptname",department.name);
					model.addAttribute("power",department.parentid);
				}
			}
			return "plan/planlist";
		}else if (mydepDepartments.size()==1){
			Department mydep=mydepDepartments.get(0);
		model.addAttribute("deptid",mydep.id );
		model.addAttribute("deptname",mydep.name);
		model.addAttribute("power",mydep.parentid);
		
		
		return "plan/planlist";
		}else {
			return "plan/plandeptlist";
		}
	}
	
	@RequestMapping("/planview")
	public String planlist(@RequestParam(value="deptid",required=false)String deptid,
			@RequestParam(value="year",required=false)String year,
			@RequestParam(value="power",required=false)String power,
			@RequestParam(value="checkid",required=false)String checkid,HttpServletResponse response,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		List<Department> dlist=DepartmentHelper.listDepartments(AuthHelper.getAccessToken());
		for (Department dep : dlist) {
			if(dep.id==deptid){
				model.addAttribute("deptname",dep.name);
			}
		}
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
		model.addAttribute("deptid",deptid );
		model.addAttribute("power",power);
		model.addAttribute("checkid",checkid);
		Calendar nowCalendar=Calendar.getInstance();
		if(StringUtil.isBlank(year)){
			model.addAttribute("year", nowCalendar.get(Calendar.YEAR));
		}else{
			model.addAttribute("year",year);
		}
		
		
		return "plan/planlist";
	}
	
	
	
	/** 跳转添加计划
	 * @param deptid 部门id
	 * @param year  年份
	 * @param model
	 * @param request
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/planadd")
	public String planadd(@RequestParam(value="deptid",required=false)String deptid,
			@RequestParam(value="year",required=false)String year,Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
		model.addAttribute("deptid", deptid);
		model.addAttribute("year", year);
		model.addAttribute("oper", "add");
		
		return "plan/planadd";
	}	
	/** 跳转编辑计划
	 * @param id 计划id
	 * @param model
	 * @param request
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/planedit")
	public String planadd2(@RequestParam(value="id",required=false)String id,
			@RequestParam(value="power",required=false)String power,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		if(StringUtil.isNotBlank(power)){
			model.addAttribute("power", power);
		}
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		model.addAttribute("oper", "edit");
		
		return "plan/planedit";
	}	
	/** 跳转添加任务
	 * @param deptid 部门id
	 * @param year  年份
	 * @param model
	 * @param request
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/taskadd")
	public String taskadd(@RequestParam(value="deptid",required=false)String deptid,
			@RequestParam(value="year",required=false)String year,
			@RequestParam(value="planid",required=false)String planid,
			@RequestParam(value="pid",required=false)String pid,
			@RequestParam(value="id",required=false)String id,Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		
		plan newPlan=new plan();
		if(StringUtil.isNotBlank(id)){
			newPlan=planService.findById(Long.parseLong(id));
			model.addAttribute("oper", "edit");
		}else{
			newPlan.setDeptid(deptid);
			newPlan.setYear(year);
			newPlan.setPid(pid);
			newPlan.setPlanid(planid);
			newPlan.setJindu("0");
			model.addAttribute("oper", "add");
		}
		
		model.addAttribute("authconfig", configstr);
		
		model.addAttribute("plan", newPlan);
		return "plan/taskadd";
	}	
	
	
	
	
	/** 跳转任务视图
	 * @param id 计划id
	 * @param model
	 * @param request
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/taskview")
	public String taskview(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		JSONObject userJsonObject=null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
			}
		}
		int index=editplanPlan.getFuzherenid().indexOf(userJsonObject.get("userid").toString());
		model.addAttribute("fuzhe", index);
		return "plan/taskview";
	}
	


	
	
	
	
	/**根据部门和年份获取计划
	 * @param deptid
	 * @param year
	 * @param model
	 * @param request
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/getplan")
	public @ResponseBody Results  getplanlist(@RequestParam(value="deptid",required=false)String deptid,
			@RequestParam(value="year",required=false)String year,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		List<plan> planlist=planService.findByDeptidAndYearAndPid(deptid,year,"0");
		return new Results(planlist);
	}
	
	//根据父id获得子任务
	@RequestMapping("/gettask")
	public @ResponseBody Results  gettask(@RequestParam(value="pid",required=false)String pid,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		List<plan> planlist=planService.findByPid(pid);
		return new Results(planlist);
	}
	
	
	/**保存计划
	 * @param planform 计划
	 * @param oper
	 * @param request
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/edit")
	public @ResponseBody
	Results edit(@ModelAttribute plan planform,
				@RequestParam(value = "oper", required = false) String oper,
				HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException {
		String message = "修改成功";
		if (StringUtils.equals("add", oper)) {
			//planform.setId(null);
			message = "保存成功";
		}
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				JSONObject userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				planform.setOperationer(userJsonObject.get("name").toString());
				planform.setOperationerid(userJsonObject.get("userid").toString());
			}
		}
		planService.save(planform);
		return new Results(true, message, planform.getId().toString());
	}	
	
	

	
	/** 获得用户信息存储cookie并返回部门列表
	 * @param code 授权码
	 * @param model
	 * @param request
	 * @param response
	 * @return  部门列表
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/authuser")
	public @ResponseBody Results  getauthuser(
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		
		return  new Results(planService.getdept(request, response));
	}
	

	/** 获得用户信息存储cookie并返回任务列表
	 * @param code 授权码
	 * @param model
	 * @param request
	 * @param response
	 * @return  部门列表
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/login")
	public @ResponseBody Results  login(@RequestParam(value="code",required=false)String code,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		
		return  new Results(planService.loginandtask(request, response, code));
	}
	
	
	
	
	/**统计部门当年进度
	 * @param deptid
	 * @param year
	 * @param model
	 * @param request
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/getplanjindu")
	public @ResponseBody Results  getplanjindu(@RequestParam(value="deptid",required=false)String deptid,
			@RequestParam(value="year",required=false)String year,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		List<plan> planlist=planService.getplanjindu(deptid,year);
		return new Results(planlist);
	}
	
	
}
