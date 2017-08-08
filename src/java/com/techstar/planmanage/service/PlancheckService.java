package com.techstar.planmanage.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;
import org.hibernate.loader.custom.Return;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.techstar.planmanage.entity.plan;
import com.techstar.planmanage.entity.plancheck;
import com.techstar.planmanage.jpa.PlanDao;
import com.techstar.planmanage.jpa.PlancheckDao;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.department.Department;
import com.techstar.sys.dingAPI.department.DepartmentHelper;
import com.techstar.sys.dingAPI.user.User;
import com.techstar.sys.dingAPI.user.UserHelper;


@Service 
@Transactional
public class PlancheckService {
	@Autowired
	private  PlancheckDao plancheckDao;
	@Autowired
	private LocalContainerEntityManagerFactoryBean entityManagerFactory;
	

	public void save(plancheck plancheck) {
		plancheckDao.save(plancheck);
	}
	public void delete(plancheck plancheck) {
		plancheckDao.delete(plancheck);
	}
	
	public plancheck findById(Long id) {
		return plancheckDao.findById(id);
	}
	public List<plancheck> findByDeptidAndYear(String deptid, String year) {
		return plancheckDao.findByDeptidAndYear(deptid,year);
	}
	
	public List<plancheck> findByDeptidInAndState(List<String> deptidlist,String state){
		return plancheckDao.findByDeptidInAndState(deptidlist,state);
	}
	public List<plancheck> findByDeptidInAndYearAndState(List<String> deptidlist,String year,String state){
		return plancheckDao.findByDeptidInAndYearAndState(deptidlist, year, state);
	}
	public List<plancheck> findByState(String state){
		return plancheckDao.findByState(state);
	}
	public List<plancheck> findoperationeridyearcheck(String operationerid,String year) throws ParseException {
		Connection conn = null;
	  		PreparedStatement pstm = null;
	  		ResultSet rs =null;
	  		List<plancheck> plancheckList=new ArrayList<plancheck>();
	  		SimpleDateFormat sdf  =   new  SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" ); 
	  		try {
	  			StringBuffer sql = new StringBuffer("SELECT c.id,c.deptid,c.deptname,c.operationdate,c.operationer,c.operationerid,c.state,c.type,c.year ,c.taskid,c.changeid,p.title pid FROM sp_plancheck c LEFT JOIN sp_plan p ON c.taskid=p.id WHERE c.operationerid='"+operationerid+"' AND c.year='"+year+"' ORDER BY c.operationdate DESC");
	  			conn = this.entityManagerFactory.getDataSource().getConnection();
	  			pstm = conn.prepareStatement(sql.toString());
	  			rs = pstm.executeQuery();
	  			while(rs.next()){
	  			//@Query("") 
	  				
	  				plancheck newPlancheck=new plancheck();
	  				newPlancheck.setId(Long.parseLong(rs.getString("id")));
	  				newPlancheck.setDeptid(rs.getString("deptid"));
	  				newPlancheck.setDeptname(rs.getString("deptname"));
	  				newPlancheck.setOperationdate(sdf.parse(rs.getString("operationdate")));
	  				newPlancheck.setOperationer(rs.getString("operationer"));
	  				newPlancheck.setOperationerid(rs.getString("operationerid"));
	  				newPlancheck.setState(rs.getString("state"));
	  				newPlancheck.setType(rs.getString("type"));
	  				newPlancheck.setTaskid(rs.getString("taskid"));
	  				newPlancheck.setChangeid(rs.getString("changeid"));
	  				newPlancheck.setPid(rs.getString("pid"));
	  				newPlancheck.setYear(rs.getString("year"));
	  				plancheckList.add(newPlancheck);
	  			}
	  			
	  		} catch (SQLException e) {
	  			e.printStackTrace();
	  		} finally{
	  			try {
	  				if(rs!=null)
	  					rs.close();
	  				if(pstm!=null)
	  					pstm.close();
	  				if(conn!=null)
	  					conn.close();
	  			} catch (Exception e2) {
	  				e2.printStackTrace();
	  			}
	  		}
		return plancheckList;
	}
	/**
	 * 获得用户审批过的check记录
	 * @param operationerid
	 * @param year
	 * @return
	 * @throws ParseException
	 */
	public List<plancheck> findshenpiall(String operationerid,String year) throws ParseException {
		Connection conn = null;
	  		PreparedStatement pstm = null;
	  		ResultSet rs =null;
	  		List<plancheck> plancheckList=new ArrayList<plancheck>();
	  		SimpleDateFormat sdf  =   new  SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" ); 
	  		try {
	  			StringBuffer sql = new StringBuffer("SELECT c.id,c.deptid,c.deptname,c.operationdate,c.operationer,c.operationerid,c.state,c.type,c.year ,c.taskid,c.changeid,p.title pid FROM sp_plancheck c LEFT JOIN sp_plan p ON c.taskid=p.id WHERE c.id IN (SELECT checkid FROM sp_checklog WHERE operationerid='"+operationerid+"') AND c.year='"+year+"' ORDER BY c.operationdate DESC");
	  			conn = this.entityManagerFactory.getDataSource().getConnection();
	  			pstm = conn.prepareStatement(sql.toString());
	  			rs = pstm.executeQuery();
	  			while(rs.next()){
	  			//@Query("") 
	  				
	  				plancheck newPlancheck=new plancheck();
	  				newPlancheck.setId(Long.parseLong(rs.getString("id")));
	  				newPlancheck.setDeptid(rs.getString("deptid"));
	  				newPlancheck.setDeptname(rs.getString("deptname"));
	  				newPlancheck.setOperationdate(sdf.parse(rs.getString("operationdate")));
	  				newPlancheck.setOperationer(rs.getString("operationer"));
	  				newPlancheck.setOperationerid(rs.getString("operationerid"));
	  				newPlancheck.setState(rs.getString("state"));
	  				newPlancheck.setType(rs.getString("type"));
	  				newPlancheck.setYear(rs.getString("year"));
	  				newPlancheck.setTaskid(rs.getString("taskid"));
	  				newPlancheck.setChangeid(rs.getString("changeid"));
	  				newPlancheck.setPid(rs.getString("pid"));
	  				plancheckList.add(newPlancheck);
	  			}
	  			
	  		} catch (SQLException e) {
	  			e.printStackTrace();
	  		} finally{
	  			try {
	  				if(rs!=null)
	  					rs.close();
	  				if(pstm!=null)
	  					pstm.close();
	  				if(conn!=null)
	  					conn.close();
	  			} catch (Exception e2) {
	  				e2.printStackTrace();
	  			}
	  		}
		return plancheckList;
	}
}
