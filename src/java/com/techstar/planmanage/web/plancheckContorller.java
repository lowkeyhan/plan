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
import com.techstar.sys.dingAPI.message.MessageHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;
import com.techstar.sys.jpadomain.Results;



/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/check")
public class plancheckContorller {
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
		return "plan/index";
	}
	
	@RequestMapping("/checklist")
	public String checklist(Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
	//	return "plan/plandeptlist";
		return "plan/shenheindex";
	}
	@RequestMapping("/shenheview")
	public String shenheview(@RequestParam(value="checkid",required=false)String checkid,Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
		model.addAttribute("id", checkid);
	//	return "plan/plandeptlist";
		return "plan/shenheview";
	}
	@RequestMapping("/shenpiadd")
	public String shenpiadd(@RequestParam(value="checkid",required=false)String checkid,Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		plancheck planchecks=plancheckService.findById(Long.parseLong(checkid));
		String configstr= AuthHelper.getConfig(request);
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plancheck", planchecks);
		return "plan/shenpiadd";
	}
	
	/**
	 * 根据部门和年份获取当前计划状态
	 * @param deptid
	 * @param year
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/getstate")
	public @ResponseBody Results  getstate(@RequestParam(value="deptid",required=false)String deptid,
			@RequestParam(value="year",required=false)String year,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		List<plancheck> listcheckList=plancheckService.findByDeptidAndYear(deptid, year);
		String stateString="1";
		String checkidString="";
		if(listcheckList.size()<=0){
			stateString="1";
		}else{
			stateString=listcheckList.get(0).getState();
			checkidString=listcheckList.get(0).getId()+"";
		}
		return  new Results(checkidString,stateString);
	}
	
	/**
	 * 计划提交审核
	 * @param deptid 部门id
	 * @param year  计划年份
	 * @param deptname  编码的部门名称
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/subplan")
	public @ResponseBody Results  subplan(@RequestParam(value="deptid",required=false)String deptid,
			@RequestParam(value="year",required=false)String year,
			@RequestParam(value="deptname",required=false)String deptname,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		//获得用户信息
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		JSONObject userJsonObject = null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				 userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
			}
		}
		//根据部门和年份查询是否有审核信息
		List<plancheck> listcheckList=plancheckService.findByDeptidAndYear(deptid, year);
		plancheck subPlancheck=new plancheck();
		if(listcheckList.size()<=0){
			//没有审核信息时生成本年度审核信息
			subPlancheck.setDeptid(deptid);
			subPlancheck.setDeptname(deptname);
			subPlancheck.setType("计划审核");
			subPlancheck.setOperationer(userJsonObject.get("name").toString());
			subPlancheck.setOperationerid(userJsonObject.get("userid").toString());
			subPlancheck.setYear(year);
			subPlancheck.setState("2");
		}else{
			subPlancheck=listcheckList.get(0);
			subPlancheck.setState("2");
		}
		plancheckService.save(subPlancheck);
		
		//发送通知消息
		List<power> listpowerList=powerService.findByTypeAndDeptidLike("主管副总审批", "%"+deptid+"%");
		String tousers="";
		for (power power : listpowerList) {
			tousers+=power.getAdminid()+"|";
		}
		if(tousers.length()>0){
			tousers=tousers.substring(0, tousers.length()-1);
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理",deptname+"提交了计划需要主管审批", subPlancheck.getOperationer(), "", tousers, request);
		}
		return  new Results(year+"年计划提交成功");
	}
	
	/**
	 * 根据角色获得待审核列表
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/getcheck")
	public @ResponseBody Results  getcheck(
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		//获得缓存用户
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		JSONObject userJsonObject = null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				 userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				//planform.setOperationer(userJsonObject.get("name").toString());
				//planform.setOperationerid(userJsonObject.get("userid").toString());
			}
		}
		//获取带审核列表 ，state (1：未提交，2：已提交主管未审核，3：主管审核总监未审核，4：审核通过)
		List<plancheck> planchecks=new ArrayList<plancheck>();
		//获得用户主管角色权限
		List<power> listpowerList=powerService.findByAdminidAndType(userJsonObject.get("userid").toString(), "主管副总审批");
		if(listpowerList.size()>0){
			//根据主管部门获得部门计划审核列表
			List<String> idList=new ArrayList<String>();
			String[] idstrStrings=listpowerList.get(0).getDeptid().split(",");
			Collections.addAll(idList, idstrStrings);
			planchecks=plancheckService.findByDeptidInAndState(idList, "2");
		}
		if(planchecks.size()<=0){
			//获得用户总监权限
			List<power> zlistpowerList=powerService.findByAdminidAndType(userJsonObject.get("userid").toString(), "总经理助理审批");
			if(zlistpowerList.size()>0){
				//总监处理所有部门计划总监审核
				planchecks=plancheckService.findByState( "3");
			}
		}
		return  new Results(planchecks);
	}
	
	/**
	 * 保存审核结果并记录
	 * @param state 1：未提交，2：已提交主管未审核，3：主管审核总监未审核，4：审核通过)
	 * @param checkid 审核id
	 * @param shuju  说明
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/shenpistate")
	public @ResponseBody Results  shenpistate(@RequestParam(value="state",required=false)String state,
			@RequestParam(value="checkid",required=false)String checkid,
			@RequestParam(value="shuju",required=false)String shuju,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		plancheck plancheckstate=plancheckService.findById(Long.parseLong(checkid));
		//获得原来的状态信息判断审核人身份
		String oldstateString=plancheckstate.getState();
		String checktype="zhuguan";
		String titlenameString="主管";
		if(oldstateString.equals("3")){
			checktype="zongjian";
			titlenameString="战规总监";
		}
		//赋予新的状态
		plancheckstate.setState(state);
		plancheckService.save(plancheckstate);
		//获得用户信息
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		JSONObject userJsonObject = null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				 userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				//planform.setOperationer(userJsonObject.get("name").toString());
				//planform.setOperationerid(userJsonObject.get("userid").toString());
			}
		}
		//保存审核记录，记录审核人审核信息
		checklog checklog=new checklog();
		checklog.setCheckid(plancheckstate.getId().toString());
		checklog.setDeptid(plancheckstate.getDeptid());
		checklog.setDeptname(plancheckstate.getDeptname());
		checklog.setOperationer(userJsonObject.get("name").toString());
		checklog.setOperationerid(userJsonObject.get("userid").toString());
		checklog.setShuoming("审核通过");
		if(state.equals("1")){
			checklog.setShuoming("审核不通过");
			/*发送通知消息
			List<power> listpowerList=powerService.findByTypeAndDeptidLike("主管副总审批", "%"+deptid+"%");
			String tousers="";
			for (power power : listpowerList) {
				tousers+=power.getAdminid()+"|";
			}*/
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理",titlenameString+"审批不通过", checklog.getOperationer(), "审批意见："+shuju, plancheckstate.getOperationerid(), request);
			
		}else{
			if(checktype.equals("zhuguan"))
			{
				List<power> listpowerList=powerService.findByType("总经理助理审批");
				String tousers="";
				for (power power : listpowerList) {
					tousers+=power.getAdminid()+"|";
				}
				tousers+=plancheckstate.getOperationerid();
				MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理",titlenameString+"审批通过需战规总监审批", checklog.getOperationer(), "主管审批意见："+shuju, tousers, request);
					
			}else if(checktype.equals("zongjian")){
				MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理",titlenameString+"审批通过", checklog.getOperationer(), "审批意见："+shuju, plancheckstate.getOperationerid(), request);
				
			}
			
		}
		checklog.setShuju(shuju);
		checklog.setType(checktype);
		checklog.setYear(plancheckstate.getYear());
		checklog.setState(state);
		checklogService.save(checklog);
		return  new Results("审核完成");
	}
	
	
}
