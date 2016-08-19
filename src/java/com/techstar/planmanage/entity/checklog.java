
package com.techstar.planmanage.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * 
 * @author hxb
 *
 */
@Entity
@Table(name = "sp_checklog")
public class checklog  {
	@SequenceGenerator(name = "MY_SUQUENCE", sequenceName = "DEFAULT_SUQUENCE")
	@Id
	@GeneratedValue(generator="MY_SUQUENCE")
	private Long id;
	private Date operationdate=new Date();//添加时间
	private String checkid;//plancheckid
	@Column(name="operationer")
	private String operationer;//添加人
	@Column(name="operationerid")
	private String operationerid;//添加人id
	private String year;//年份
	private String deptid;//部门id
	private String deptname;
	private String state;//说明
	private String taskid;
	private String type;//log类型
	private String shuoming;//log说明
	private String shuju;//log数据
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getOperationdate() {
		return operationdate;
	}
	public void setOperationdate(Date operationdate) {
		this.operationdate = operationdate;
	}
	public String getOperationer() {
		return operationer;
	}
	public void setOperationer(String operationer) {
		this.operationer = operationer;
	}
	public String getOperationerid() {
		return operationerid;
	}
	public void setOperationerid(String operationerid) {
		this.operationerid = operationerid;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getDeptid() {
		return deptid;
	}
	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCheckid() {
		return checkid;
	}
	public void setCheckid(String checkid) {
		this.checkid = checkid;
	}
	public String getTaskid() {
		return taskid;
	}
	public void setTaskid(String taskid) {
		this.taskid = taskid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getShuju() {
		return shuju;
	}
	public void setShuju(String shuju) {
		this.shuju = shuju;
	}
	public String getShuoming() {
		return shuoming;
	}
	public void setShuoming(String shuoming) {
		this.shuoming = shuoming;
	}
	
	
	
	
}

