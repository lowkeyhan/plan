
package com.techstar.calendermanage.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * 待办事项
 * @author hxb
 *
 */
@Entity
@Table(name = "sp_events")
public class Events  {
	@SequenceGenerator(name = "MY_SUQUENCE", sequenceName = "DEFAULT_SUQUENCE")
	@Id
	@GeneratedValue(generator="MY_SUQUENCE")
	private Long id;
	@Column(name="title")
	private String title;//标题
	@Column(name="starttime")
	private Date starttime;//开始时间
	@Column(name="endtime")
	private Date endtime;//介绍时间
	@Column(name="remindertime")
	private Date remindertime;//提醒时间
	@Column(name="remark")
	private String remark;//备注
	@Column(name="operationdate")
	private Date operationdate=new Date();//添加时间
	@Column(name="operationer")
	private String operationer;//添加人
	@Column(name="operationerid")
	private String operationerid;//添加人id
	@Column(name="participantid")
	private String participantid;//参与人id
	@Column(name="participantname")
	private String participantname;//参与人姓名
	@Column(name="backcolor")
	private String backcolor;
	@Column(name="selecttime")
	private String selecttime;//持续时间
	@Column(name="isfinish")
	private String isfinish;//持续时间
	
	public String getIsfinish() {
		return isfinish;
	}
	public void setIsfinish(String isfinish) {
		this.isfinish = isfinish;
	}
	public String getSelecttime() {
		return selecttime;
	}
	public void setSelecttime(String selecttime) {
		this.selecttime = selecttime;
	}
	public String getBackcolor() {
		return backcolor;
	}
	public void setBackcolor(String backcolor) {
		this.backcolor = backcolor;
	}
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getStarttime() {
		return starttime;
	}
	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public Date getRemindertime() {
		return remindertime;
	}
	public void setRemindertime(Date remindertime) {
		this.remindertime = remindertime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getParticipantid() {
		return participantid;
	}
	public void setParticipantid(String participantid) {
		this.participantid = participantid;
	}
	public String getParticipantname() {
		return participantname;
	}
	public void setParticipantname(String participantname) {
		this.participantname = participantname;
	}
	    
	
 
}

