package com.techstar.calendermanage.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.techstar.calendermanage.entity.Events;
import com.techstar.calendermanage.service.EventsService;
import com.techstar.sys.Util.StringUtil;
import com.techstar.sys.config.Global;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;
import com.techstar.sys.jpadomain.Results;


@Controller
@RequestMapping("/calender")
public class EventsContorller {
	@Autowired
	private EventsService eventsService;
	
	@RequestMapping("/test")
	public String test(@RequestParam(value="code",required=false)String code,Model model) throws OApiException {
		//model.addAttribute("code", code);
		return "calender/testcalenderInfoview";
	}
	/**
	 * 
	 * 
	 * starttime 格式（yyyy-MM-dd）
	 * */
	@RequestMapping("/tab")
	public String getall(@RequestParam(value="code",required=false)String code,
			@RequestParam(value="starttime",required=false)String starttime,
			Model model) throws OApiException {
		//model.addAttribute("code", code);
		//获取默认选择的日期
		 String time;
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
		if(StringUtil.isNotBlank(starttime)){
		    time=starttime;
		}else{
			
			time=sdf.format(new Date());
		}
		model.addAttribute("starttime",time);
		return "calender/calenderList";
	}
	
	@RequestMapping("/daylist")
	public String getdaylist(@RequestParam(value="time",required=false)String time,
			HttpServletRequest request,HttpServletResponse response,
			Model model) throws OApiException, ParseException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		String userid="";
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
		 model.addAttribute(cookie.getName(), URLDecoder.decode(cookie.getValue(),"UTF-8"));
		 if(cookie.getName().equals("userid")){
			 userid=URLDecoder.decode(cookie.getValue(),"UTF-8");
		 }
		}
		Long timestamp = Long.parseLong(time)*1000; 		
		Date starDate=new Date(timestamp);
		SimpleDateFormat startformat=new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		SimpleDateFormat endFormat=new SimpleDateFormat("yyyy-MM-dd 23:59:59");
	
		Date sDate=startformat.parse(startformat.format(starDate));
		Date eDate=endFormat.parse(endFormat.format(starDate));
		Calendar ss =Calendar.getInstance();
		ss.setTime(eDate);
		ss.add(Calendar.DATE, 1);
		eDate=ss.getTime();
		
		List<Events> eventslist=eventsService.findByStarttimeGreaterThanAndStarttimeLessThanAndOperationerid(sDate ,eDate,userid);
		List<Events> ceventslist=eventsService.findByStarttimeGreaterThanAndStarttimeLessThanAndParticipantidLikeAndOperationeridNot(sDate, eDate,userid,userid);
		for (Events aevents : ceventslist) {
			eventslist.add(aevents);
		}
		model.addAttribute("list", eventslist);
		return "calender/eventdaylist";
	}
	@RequestMapping("/event")
	public String getevent(@RequestParam(value="id",required=false)String id,
			@RequestParam(value="starttime",required=false)String starttime,
			HttpServletRequest request,HttpServletResponse response,Model model) throws OApiException, UnsupportedEncodingException, ParseException {
		//model.addAttribute("code", code);
		Events events=new Events();
		if(StringUtil.isNotBlank(id)){
			events=eventsService.findById(Long.parseLong(id));
			model.addAttribute("oper","edit");
		}else {
			if(StringUtil.isNotBlank(starttime)){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				events.setStarttime(sdf.parse(starttime));
			}
			model.addAttribute("oper","add");
		}
		model.addAttribute("events",events);
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
		 model.addAttribute(cookie.getName(), URLDecoder.decode(cookie.getValue(),"UTF-8"));
		}
		return "calender/calenderInfo";
	}
	
	@RequestMapping("/eventview")
	public String geteventview(@RequestParam(value="id",required=false)String id,
			HttpServletRequest request,HttpServletResponse response,Model model) throws OApiException, UnsupportedEncodingException {
		//model.addAttribute("code", code);
		if(StringUtil.isNotBlank(id)){
			Events events=eventsService.findById(Long.parseLong(id));
			model.addAttribute("events",events);
			model.addAttribute("oper","view");
		}
		
		
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
		 model.addAttribute(cookie.getName(), URLDecoder.decode(cookie.getValue(),"UTF-8"));
		}
		return "calender/calenderInfoview";
	}
	/**
	 * 日历页面查询
	 * @param viewStart 日历开始日期
	 * @param viewEnd 日历结束日期
	 * @param session
	 * @return
	 * @throws OApiException 
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/list")
	public @ResponseBody Results search(
			@RequestParam(value="viewStart",required=false)String viewStart,
			@RequestParam(value="viewEnd",required=false)String viewEnd,
			@RequestParam(value="code",required=false)String code,
			HttpServletRequest request,HttpServletResponse response,
			HttpSession session) throws OApiException, UnsupportedEncodingException {
		//String getuserurlString="https://oapi.dingtalk.com/user/getuserinfo?access_token="+AuthHelper.getAccessToken()+"&code="+code;
		
		String useridString="";
		String nameString="";
		//查看是否有缓存用户
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("userid")){
				useridString=URLDecoder.decode(cookie.getValue(),"UTF-8");
			}else if(cookie.getName().equals("username")){
				nameString=URLDecoder.decode(cookie.getValue(),"UTF-8");
			}
		}
		if(useridString.equals("")||nameString.equals("")){
			JSONObject jsonuser=UserHelper.getUserInfo(AuthHelper.getAccessToken(), code);
			//System.out.println(code);
			User dingdingUser=UserHelper.getUser(AuthHelper.getAccessToken(), jsonuser.getString("userid"));
			useridString=dingdingUser.userid;
			nameString=dingdingUser.name;
			Cookie cookie =new Cookie("userid",URLEncoder.encode(dingdingUser.userid,"UTF-8") );
			cookie.setMaxAge(3600*24);
			cookie.setPath("/");
			response.addCookie(cookie);
			Cookie cookiename =new Cookie("username", URLEncoder.encode(dingdingUser.name,"UTF-8"));
			cookiename.setMaxAge(3600*24);
			cookiename.setPath("/");
			response.addCookie(cookiename);
		}
		
		Long timestamp = Long.parseLong(viewStart)*1000; 		
		Date starDate=new Date(timestamp);
		Calendar ss =Calendar.getInstance();
		ss.setTime(starDate);
		ss.add(Calendar.DAY_OF_MONTH, -1);
		starDate=ss.getTime();
		timestamp = Long.parseLong(viewEnd)*1000; 
		Date endDate=new Date(timestamp);	
		ss.setTime(endDate);
		ss.add(Calendar.DAY_OF_MONTH, 1);
		endDate=ss.getTime();
		List<Events> eventslist=eventsService.findByStarttimeGreaterThanAndStarttimeLessThanAndOperationerid(starDate, endDate,useridString);
		List<Events> ceventslist=eventsService.findByStarttimeGreaterThanAndStarttimeLessThanAndParticipantidLikeAndOperationeridNot( starDate, endDate,"%"+useridString+"%",useridString);
		for (Events aevents : ceventslist) {
			eventslist.add(aevents);
		}
		System.out.println((new Date()).toString()+":"+useridString+nameString+eventslist.size()+","+ceventslist.size());
		return new Results(true, eventslist);
	}
	
	@RequestMapping("/edit")
	public @ResponseBody
	Results edit(HttpServletRequest request,
			@RequestParam(value = "oper", required = false) String oper,
			@RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "starttime", required = false) String starttime,
			@RequestParam(value = "endtime", required = false) String endtime,
			@RequestParam(value = "remindertime", required = false) String remindertime,
			@RequestParam(value = "participantname", required = false) String participantname,
			@RequestParam(value = "participantid", required = false) String participantid,
			@RequestParam(value = "backcolor", required = false) String backcolor,
			@RequestParam(value = "selecttime", required = false) String selecttime,
			@RequestParam(value = "remark", required = false) String remark) throws ParseException, UnsupportedEncodingException {
		String message = "修改成功";
		Events editEvents=new Events();
		if (StringUtils.equals("add", oper)) {
			
			message = "保存成功";
			Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
			for(Cookie cookie : cookies){
				if(cookie.getName().equals("userid")){
					editEvents.setOperationerid(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				}else if(cookie.getName().equals("username")){
					editEvents.setOperationer(URLDecoder.decode(cookie.getValue(),"UTF-8"));
				}
			}
			editEvents.setOperationdate(new Date());
		}else {
			editEvents=eventsService.findById(Long.parseLong(id));;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		editEvents.setTitle(title);
		if (!StringUtils.equals("", starttime)) {
			editEvents.setStarttime(sdf.parse(starttime));
		}
		if (!StringUtils.equals("", endtime)) {
		editEvents.setEndtime(sdf.parse(endtime));
		}else{
			editEvents.setEndtime(sdf.parse(starttime.substring(0,10)+" 23:59:59"));
		}
			
		editEvents.setRemark(remark);
		if (!StringUtils.equals("", remindertime)) {
		editEvents.setRemindertime(sdf.parse(remindertime));
		}
		editEvents.setParticipantid(participantid);
		editEvents.setParticipantname(participantname);
		if(backcolor=="")
		{
			backcolor="#3BA1BF";
		}
		editEvents.setBackcolor(backcolor);
		editEvents.setSelecttime(selecttime);
		eventsService.save(editEvents);
		return new Results(true, message, editEvents);
	}
	@RequestMapping("/finish")
	public @ResponseBody
	Results finish(HttpServletRequest request,@RequestParam(value = "id", required = false) String id) {
		String message = "已完成";
		Events event=eventsService.findById(Long.parseLong(id));
		event.setIsfinish("1");
		eventsService.save(event);
		return new Results(true, message);
	}
	@RequestMapping("/delect")
	public @ResponseBody
	Results delect(HttpServletRequest request,@RequestParam(value = "id", required = false) String id) {
		String message = "删除成功";
		Events event=eventsService.findById(Long.parseLong(id));
		eventsService.delete(event);
		return new Results(true, message);
	}
	
}
