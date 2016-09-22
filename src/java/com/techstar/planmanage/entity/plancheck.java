
package com.techstar.planmanage.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * 保修内容
 * @author hxb
 *
 */
@Entity
@Table(name = "sp_plancheck")
public class plancheck  {
	@SequenceGenerator(name = "MY_SUQUENCE", sequenceName = "DEFAULT_SUQUENCE")
	@Id
	@GeneratedValue(generator="MY_SUQUENCE")
	private Long id;
	private Date operationdate=new Date();//添加时间
	@Column(name="operationer")
	private String operationer;//添加人
	@Column(name="operationerid")
	private String operationerid;//添加人id
	private String year;//年份
	private String deptid;//部门id
	private String deptname;
	private String state;//1：未提交，2：已提交主管未审核，3：主管审核总监未审核，4：审核通过)
	private String type;
	private String taskid;
	private String changeid;//
	private String pid;//
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
	/**
	 * 1：未提交，2：已提交主管未审核，3：主管审核总监未审核，4：审核通过)
	 * @return
	 */
	public String getState() {
		return state;
	}
	/**
	 * 1：未提交，2：已提交主管未审核，3：主管审核总监未审核，4：审核通过)
	 * @param state
	 */
	public void setState(String state) {
		this.state = state;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTaskid() {
		return taskid;
	}
	public void setTaskid(String taskid) {
		this.taskid = taskid;
	}
	public String getChangeid() {
		return changeid;
	}
	public void setChangeid(String changeid) {
		this.changeid = changeid;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	
	
	
	
}

