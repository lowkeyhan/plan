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
import com.techstar.planmanage.entity.power;
import com.techstar.planmanage.service.ChecklogService;
import com.techstar.planmanage.service.PlanService;
import com.techstar.planmanage.service.PlanchangeService;
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
@RequestMapping("/change")
public class planchangeContorller {
	@Autowired
	private PlanService planService;
	@Autowired
	private PlanchangeService planchangeService;
	@Autowired
	private PlancheckService plancheckService;
	@Autowired
	private ChecklogService checklogService;
	@Autowired
	private powerService powerService;
	
	@RequestMapping("/taskchange")
	public String taskchange(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		return "plan/taskchange";
	}
	@RequestMapping("/planchange")
	public String planchange(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		return "plan/planchange";
	}
	@RequestMapping("/savechange")
	public @ResponseBody
	Results savechange(@ModelAttribute planchange planform,
				HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException, OApiException {
		plancheck newPlancheck=new plancheck();
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				JSONObject userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				newPlancheck.setOperationer(userJsonObject.get("name").toString());
				newPlancheck.setOperationerid(userJsonObject.get("userid").toString());
			}
		}
		
		newPlancheck.setDeptid(planform.getDeptid());
		newPlancheck.setDeptname(DepartmentHelper.findoneDepartments(AuthHelper.getAccessToken(),planform.getDeptid()).name);
		newPlancheck.setType("变更");
		newPlancheck.setYear(planform.getYear());
		newPlancheck.setTaskid(planform.getTaskid().toString());
		newPlancheck.setState("2");
		newPlancheck.setPid(planform.getPid());
		planform.setState("2");
		planform.setId(null);
		planchangeService.save(planform);
		newPlancheck.setChangeid(planform.getId().toString());
		plancheckService.save(newPlancheck);
		//发送通知消息
				List<power> listpowerList=powerService.findByTypeAndDeptidLike("主管副总审批", "%"+planform.getDeptid()+"%");
				String tousers="";
				for (power power : listpowerList) {
					tousers+=power.getAdminid()+"|";
				}
				if(tousers.length()>0){
					tousers=tousers.substring(0, tousers.length()-1);
					MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理","计划："+planform.getTitle()+"提交了变更申请需主管审批", planform.getOperationer(), "", tousers, request);
				}
		return new Results(true, "提交成功，等待审核", planform.getId().toString());
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
		return "plan/shenhechange";
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
		return "plan/shenheplanchange";
	}
	/**
	 * 保存审核结果并记录
	 * @param state 1：未提交，2：已提交主管未审核，3：主管审核总监未审核，4：审核通过,5：审核不通过)
	 * @param checkid 审核id
	 * @param shuju  是否正常变更年 1为正常变更，0为非正常变更，最后总监审核才有
	 * @param model
	 * @param request
	 * @param response
	 * @return 
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/shstate")
	public @ResponseBody Results  shstate(@RequestParam(value="state",required=false)String state,
			@RequestParam(value="id",required=false)String checkid,
			@RequestParam(value="tid",required=false)String tid,
			@RequestParam(value="cid",required=false)String cid,
			@RequestParam(value="changexz",required=false)String changexz,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		plancheck plancheckstate=plancheckService.findById(Long.parseLong(checkid));
		//获得原来的状态信息判断审核人身份
		String oldstateString=plancheckstate.getState();
		String checktype="zhuguan";
		if(oldstateString.equals("3")){
			checktype="zongjian";
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
		plan plan=planService.findById(Long.parseLong(tid));
		//保存审核记录，记录审核人审核信息
		checklog checklog=new checklog();
		checklog.setCheckid(plancheckstate.getId().toString());
		checklog.setDeptid(plancheckstate.getDeptid());
		checklog.setDeptname(plancheckstate.getDeptname());
		checklog.setOperationer(userJsonObject.get("name").toString());
		checklog.setOperationerid(userJsonObject.get("userid").toString());
		checklog.setShuoming("变更审核通过");
		if(state.equals("5")){
			checklog.setShuoming("变更审核不通过");
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理","计划："+plan.getTitle()+"变更审批不通过", checklog.getOperationer(), "", plancheckstate.getOperationerid(), request);
			
		}
		//changexz 1：正常变更，0：非正常变更
		checklog.setShuju(changexz);
		checklog.setType(checktype);
		checklog.setYear(plancheckstate.getYear());
		checklog.setState(state);
		checklogService.save(checklog);
		
		//总监审核成功则用changepaln中的数据覆盖plan中的数据做最后变更，并在changeplan中标记状态和是否正常变更
		if(checktype.equals("zongjian")&&state.equals("4")){
			planchange planchange=planchangeService.findById(Long.parseLong(cid));
			
			//标记状态和变更性质
			planchange.setState(state);
			planchange.setIsnormal(changexz);
			
			//任务作变更字段
			plan.setTitle(planchange.getTitle());
			plan.setStime(planchange.getStime());
			plan.setEndtime(planchange.getEndtime());
			plan.setFuzherenid(planchange.getFuzherenid());
			plan.setFuzherenname(planchange.getFuzherenname());
			plan.setZiyuanpeizhi(planchange.getZiyuanpeizhi());
			//计划作变更字段
			plan.setLevel(planchange.getLevel());
			plan.setType(planchange.getType());
			plan.setTarget(planchange.getTarget());
			plan.setWeight(planchange.getWeight());
			plan.setSsessmentindex(planchange.getSsessmentindex());
			
			//记录变更次数
			if(changexz.equals("1")){
				plan.setZcbg(plan.getZcbg()+1);
			}else if(changexz.equals("0")){
				plan.setFzcbg(plan.getFzcbg()+1);
			}
			planService.save(plan);
			planchangeService.save(planchange);
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理","计划："+plan.getTitle()+"变更审批通过", checklog.getOperationer(), "变更性质："+changexz, plancheckstate.getOperationerid(), request);
		}else if(checktype.equals("zhuguan")&&state.equals("3")){
			List<power> listpowerList=powerService.findByType("总经理助理审批");
			String tousers="";
			for (power power : listpowerList) {
				tousers+=power.getAdminid()+"|";
			}
			tousers+=plancheckstate.getOperationerid();
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理","计划："+plan.getTitle()+"变更申请主管通过需战规总监审批", checklog.getOperationer(), "", tousers, request);
			
		}
		return  new Results(true,"审核完成");
	}
	
	
	@RequestMapping("/taskdel")
	public String taskdel(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		return "plan/taskdel";
	}
	@RequestMapping("/plandel")
	public String plandel(@RequestParam(value="id",required=false)String id,
			Model model,HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		String configstr= AuthHelper.getConfig(request);
		plan editplanPlan=planService.findById(Long.parseLong(id));
		model.addAttribute("authconfig", configstr);
		model.addAttribute("plan", editplanPlan);
		return "plan/plandel";
	}
	@RequestMapping("/savedel")
	public @ResponseBody
	Results savedel(@RequestParam(value="id",required=false)String id,
			@RequestParam(value="delsm",required=false)String delsm,
				HttpServletRequest request,HttpSession session) throws UnsupportedEncodingException, OApiException {
		plan delplan=planService.findById(Long.parseLong(id));
		plancheck newPlancheck=new plancheck();
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				JSONObject userJsonObject=JSON.parseObject(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				newPlancheck.setOperationer(userJsonObject.get("name").toString());
				newPlancheck.setOperationerid(userJsonObject.get("userid").toString());
			}
		}
		
		newPlancheck.setDeptid(delplan.getDeptid());
		newPlancheck.setDeptname(DepartmentHelper.findoneDepartments(AuthHelper.getAccessToken(),delplan.getDeptid()).name);
		newPlancheck.setType("撤销");
		newPlancheck.setYear(delplan.getYear());
		newPlancheck.setTaskid(delplan.getId().toString());
		newPlancheck.setState("2");
		newPlancheck.setPid(delplan.getPid());
		
		plancheckService.save(newPlancheck);
		delplan.setDelsm(delsm);
		planService.save(delplan);
		//发送通知消息
		List<power> listpowerList=powerService.findByTypeAndDeptidLike("主管副总审批", "%"+delplan.getDeptid()+"%");
		String tousers="";
		for (power power : listpowerList) {
			tousers+=power.getAdminid()+"|";
		}
		if(tousers.length()>0){
			tousers=tousers.substring(0, tousers.length()-1);
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理","计划："+delplan.getTitle()+"提交了变更申请需主管审批", newPlancheck.getOperationer(), "", tousers, request);
		}
		return new Results(true, "提交成功，等待审核", delplan);
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
		return "plan/shenhedel";
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
		return "plan/shenheplandel";
	}
	
	@RequestMapping("/shdel")
	public @ResponseBody Results  shdel(@RequestParam(value="state",required=false)String state,
			@RequestParam(value="id",required=false)String checkid,
			@RequestParam(value="tid",required=false)String tid,
			@RequestParam(value="changexz",required=false)String changexz,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws OApiException, UnsupportedEncodingException {
		plancheck plancheckstate=plancheckService.findById(Long.parseLong(checkid));
		plan plan=planService.findById(Long.parseLong(tid));
		//获得原来的状态信息判断审核人身份
		String oldstateString=plancheckstate.getState();
		String powernameString="主管";
		String checktype="zhuguan";
		if(oldstateString.equals("3")){
			checktype="zongjian";
			powernameString="总监";
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
		checklog.setShuoming("撤销审核"+powernameString+"通过");
		if(state.equals("5")){
			checklog.setShuoming("撤销审核"+powernameString+"不通过");
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理","计划："+plan.getTitle()+"撤销审批不通过", checklog.getOperationer(), "", plancheckstate.getOperationerid(), request);
			
		}
		checklog.setType(checktype);
		checklog.setYear(plancheckstate.getYear());
		checklog.setState(state);
		checklogService.save(checklog);
		
		//总监审核成功则用changepaln中的数据覆盖plan中的数据做最后变更，并在changeplan中标记状态和是否正常变更
		
		if(checktype.equals("zongjian")&&state.equals("4")){
			
			plan.setIsdel("1");
			plan.setDelxz(changexz);
			planService.save(plan);
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理","计划："+plan.getTitle()+"撤销审批通过", checklog.getOperationer(), "变更性质："+changexz, plancheckstate.getOperationerid(), request);
		}else if(checktype.equals("zhuguan")&&state.equals("3")){
			List<power> listpowerList=powerService.findByType("总经理助理审批");
			String tousers="";
			for (power power : listpowerList) {
				tousers+=power.getAdminid()+"|";
			}
			tousers+=plancheckstate.getOperationerid();
			MessageHelper.sendmessage("/pcplan/index", "/plan/index", "计划管理","计划："+plan.getTitle()+"撤销申请主管通过需战规总监审批", checklog.getOperationer(), "", tousers, request);
			
		}
		return  new Results(true,"审核完成");
	}
}
