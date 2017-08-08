package com.techstar.planmanage.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.hibernate.loader.custom.Return;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
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
	@Autowired
	private  PlanDao planDao;
	
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
		return powerDao.findByTypeOrderByOperationdateDesc(type);
	}
	public List<power> findByTypeAndDeptidLike(String type,String deptid) {
		return powerDao.findByTypeAndDeptidLike(type, deptid);
	}//主管副总审批
	public List<power> findByAdminidLikeAndType(String adminid ,String type){
		return powerDao.findByAdminidLikeAndType(adminid, type);
	}

	
	public HSSFWorkbook GetAllRecord() throws OApiException{
		
		HSSFWorkbook workbook = new HSSFWorkbook();
		
		
		 //添加标题
		    HashMap map = new HashMap();
		    map.put("计划编号",0);
		    map.put("计划级别",1);
		    map.put("计划类别",2);
		    map.put("计划名称",3);
		    map.put("权重分配",4);
		    map.put("考核指标",5);
		    map.put("Ⅰ级任务",6);
		    map.put("Ⅱ级任务",7);
		    map.put("开始时间",8);
		    map.put("结束时间",9);
		    map.put("进度%",10);
		    //map.put("描述",11);
		    map.put("责任部门",11);
		    map.put("责任人",12);
		    map.put("资源配置",13);
		    int sheetcount=0;
		    List<Department> dlist=DepartmentHelper.listDepartments(AuthHelper.getAccessToken());
		for (Department department : dlist) {
			int rowNum=0;
			 String departmentid=department.id;
			   String departmentname=department.name;
		
				HSSFSheet sheet = workbook.createSheet();
				workbook.setSheetName(sheetcount++, departmentname , HSSFWorkbook.ENCODING_UTF_16);
				// 设置居中  
			    HSSFCellStyle headstyle = workbook.createCellStyle();        
			    headstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中    
			    headstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中   
			    headstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框    
			    headstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框    
			    headstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框    
			    headstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框  
			    //假日单元格样式
			    HSSFCellStyle holdaystyle = workbook.createCellStyle();
			    holdaystyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中    
			    holdaystyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中    		
			    holdaystyle.setFillBackgroundColor(HSSFColor.GREY_40_PERCENT.index);
			    holdaystyle.setFillForegroundColor(HSSFColor.GREY_40_PERCENT.index);
			    holdaystyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			    holdaystyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框    
			    holdaystyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框    
			    holdaystyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框    
			    holdaystyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框  
			    
			    
			    Set set = map.keySet();
			    /** 设置第一行标题 */
			    HSSFRow row0 = sheet.createRow(rowNum);
			    rowNum++;
			    row0.setHeight((short) 300);
			    
			    for(Iterator iter = set.iterator(); iter.hasNext();)
			    {
			     String key = (String)iter.next();
			     int value = (int)map.get(key);
			     HSSFCell cell0 = row0.createCell((short) value);
				    cell0.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell0.setCellValue(key); 
				    cell0.setCellStyle(headstyle);
			    }
			    //开始获得数据并填写,首先默认技术服务中心
			  
			   Calendar nowCalendar=Calendar.getInstance();
			   String year= nowCalendar.get(Calendar.YEAR)+"";
			   List<plan> deptPlans=planDao.findByDeptidAndYearAndPid(departmentid, year, "0");
			   for (plan planitem : deptPlans) {
				   int begionrow=rowNum;
				   HSSFRow rowplan = sheet.createRow(rowNum);
				   HSSFCell cell0 = rowplan.createCell((short) ((int)map.get("计划编号")));
				    cell0.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell0.setCellValue(planitem.getId()); 
				    cell0.setCellStyle(headstyle);
				    //计划级别
				    HSSFCell cell1 = rowplan.createCell((short) ((int)map.get("计划级别")));
				    cell1.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell1.setCellValue(planitem.getLevel()); 
				    cell1.setCellStyle(headstyle);
				    //map.put("计划类别",2);
				    HSSFCell cell2 = rowplan.createCell((short) ((int)map.get("计划类别")));
				    cell2.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell2.setCellValue(planitem.getType()); 
				    cell2.setCellStyle(headstyle);
				    //map.put("计划名称",3);
				    HSSFCell cell3 = rowplan.createCell((short) ((int)map.get("计划名称")));
				    cell3.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell3.setCellValue(planitem.getTitle()); 
				    cell3.setCellStyle(headstyle);
				    //map.put("权重分配",4);
				    HSSFCell cell4 = rowplan.createCell((short) ((int)map.get("权重分配")));
				    cell4.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell4.setCellValue(planitem.getWeight()); 
				    cell4.setCellStyle(headstyle);
				    //map.put("考核指标",5);
				    HSSFCell cell5 = rowplan.createCell((short) ((int)map.get("考核指标")));
				    cell5.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell5.setCellValue(planitem.getSsessmentindex()); 
				    cell5.setCellStyle(headstyle);
				    //map.put("Ⅰ级任务",6); 开始循环一级任务
				    List<plan> Lvonetask=planDao.findByDeptidAndYearAndPid(departmentid, year, planitem.getId().toString());
				    for (plan Lvoneitem : Lvonetask) {
				    	int onebegion=rowNum;
				    	HSSFRow rowtask = sheet.createRow(rowNum);
				    	HSSFCell cell6 = rowtask.createCell((short) ((int)map.get("Ⅰ级任务")));
					    cell6.setEncoding(HSSFCell.ENCODING_UTF_16);
						cell6.setCellValue(Lvoneitem.getTitle()); 
					    cell6.setCellStyle(headstyle);
					    //map.put("Ⅰ级任务",6); 开始循环一级任务
					    List<plan> Lvtwotask=planDao.findByDeptidAndYearAndPid(departmentid, year, Lvoneitem.getId().toString());
					   if(Lvtwotask.size()>0){
							   for (plan Lvtwoitem : Lvtwotask) {
								   HSSFRow tworowtask = sheet.createRow(rowNum++);
								   HSSFCell cell7 = tworowtask.createCell((short) ((int)map.get("Ⅱ级任务")));
								    cell7.setEncoding(HSSFCell.ENCODING_UTF_16);
									cell7.setCellValue(Lvtwoitem.getTitle()); 
								    cell7.setCellStyle(headstyle);
								    HSSFCell cell8 = tworowtask.createCell((short) ((int)map.get("开始时间")));
								    cell8.setEncoding(HSSFCell.ENCODING_UTF_16);
									cell8.setCellValue(Lvtwoitem.getStime()); 
								    cell8.setCellStyle(headstyle);
								    HSSFCell cell9 = tworowtask.createCell((short) ((int)map.get("结束时间")));
								    cell9.setEncoding(HSSFCell.ENCODING_UTF_16);
									cell9.setCellValue(Lvtwoitem.getEndtime()); 
								    cell9.setCellStyle(headstyle);
								    HSSFCell cell10 = tworowtask.createCell((short) ((int)map.get("进度%")));
								    cell10.setEncoding(HSSFCell.ENCODING_UTF_16);
									cell10.setCellValue(Lvtwoitem.getJindu()); 
								    cell10.setCellStyle(headstyle);
								    HSSFCell cell12 = tworowtask.createCell((short) ((int)map.get("责任部门")));
								    cell12.setEncoding(HSSFCell.ENCODING_UTF_16);
									cell12.setCellValue(departmentname); 
								    cell12.setCellStyle(headstyle);
								    HSSFCell cell13 = tworowtask.createCell((short) ((int)map.get("责任人")));
								    cell13.setEncoding(HSSFCell.ENCODING_UTF_16);
									cell13.setCellValue(Lvtwoitem.getFuzherenname()); 
								    cell13.setCellStyle(headstyle);
								    HSSFCell cell14 = tworowtask.createCell((short) ((int)map.get("资源配置")));
								    cell14.setEncoding(HSSFCell.ENCODING_UTF_16);
									cell14.setCellValue(Lvtwoitem.getZiyuanpeizhi()); 
								    cell14.setCellStyle(headstyle);
							}
					   }else{
						   HSSFCell cell8 = rowtask.createCell((short) ((int)map.get("开始时间")));
						    cell8.setEncoding(HSSFCell.ENCODING_UTF_16);
							cell8.setCellValue(Lvoneitem.getStime()); 
						    cell8.setCellStyle(headstyle);
						    HSSFCell cell9 = rowtask.createCell((short) ((int)map.get("结束时间")));
						    cell9.setEncoding(HSSFCell.ENCODING_UTF_16);
							cell9.setCellValue(Lvoneitem.getEndtime()); 
						    cell9.setCellStyle(headstyle);
						    HSSFCell cell10 = rowtask.createCell((short) ((int)map.get("进度%")));
						    cell10.setEncoding(HSSFCell.ENCODING_UTF_16);
							cell10.setCellValue(Lvoneitem.getJindu()); 
						    cell10.setCellStyle(headstyle);
						    HSSFCell cell12 = rowtask.createCell((short) ((int)map.get("责任部门")));
						    cell12.setEncoding(HSSFCell.ENCODING_UTF_16);
							cell12.setCellValue(departmentname); 
						    cell12.setCellStyle(headstyle);
						    HSSFCell cell13 = rowtask.createCell((short) ((int)map.get("责任人")));
						    cell13.setEncoding(HSSFCell.ENCODING_UTF_16);
							cell13.setCellValue(Lvoneitem.getFuzherenname()); 
						    cell13.setCellStyle(headstyle);
						    HSSFCell cell14 = rowtask.createCell((short) ((int)map.get("资源配置")));
						    cell14.setEncoding(HSSFCell.ENCODING_UTF_16);
							cell14.setCellValue(Lvoneitem.getZiyuanpeizhi()); 
						    cell14.setCellStyle(headstyle);
						    rowNum++;
					   }
					   //计算合并问题  一级任务开始行号onebegion  结束行号rownum 
					   if(onebegion+1<rowNum){
						   //TODO:合并单元格,写下载
						// 单元格合并      
			                // 四个参数分别是：起始行，起始列，结束行，结束列      
			                sheet.addMergedRegion(new Region(onebegion, (short)((int)map.get("Ⅰ级任务")), (rowNum-1),(short)((int)map.get("Ⅰ级任务"))));      
					   }
					   
					}
				    
				    if(begionrow+1<rowNum){
						   //TODO:合并单元格,写下载
						// 单元格合并      
			                // 四个参数分别是：起始行，起始列，结束行，结束列      
			                sheet.addMergedRegion(new Region(begionrow, (short)((int)map.get("计划名称")), (rowNum-1),(short)((int)map.get("计划名称"))));      
			                sheet.addMergedRegion(new Region(begionrow, (short)((int)map.get("计划编号")), (rowNum-1),(short)((int)map.get("计划编号"))));      
			                sheet.addMergedRegion(new Region(begionrow, (short)((int)map.get("计划级别")), (rowNum-1),(short)((int)map.get("计划级别"))));
			                sheet.addMergedRegion(new Region(begionrow, (short)((int)map.get("计划类别")), (rowNum-1),(short)((int)map.get("计划类别"))));
			                sheet.addMergedRegion(new Region(begionrow, (short)((int)map.get("权重分配")), (rowNum-1),(short)((int)map.get("权重分配"))));
			                sheet.addMergedRegion(new Region(begionrow, (short)((int)map.get("考核指标")), (rowNum-1),(short)((int)map.get("考核指标"))));
				    }else if(begionrow+1>rowNum){
						   rowNum++;
					   }
					 /* 
				    map.put("Ⅱ级任务",7);
				    map.put("开始时间",8);
				    map.put("结束时间",9);
				    map.put("进度%",10);
				    map.put("描述",11);
				    map.put("责任部门",12);
				    map.put("责任人",13);
				    map.put("资源配置",14);
				    */
			   }
		
		}
	   
	    return workbook;
	}
}
