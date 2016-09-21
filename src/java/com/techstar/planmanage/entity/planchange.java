
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
@Table(name = "sp_planchange")
public class planchange  {
	@SequenceGenerator(name = "MY_SUQUENCE", sequenceName = "DEFAULT_SUQUENCE")
	@Id
	@GeneratedValue(generator="MY_SUQUENCE")
	private Long id;
	@Column(name="title")
	private String title;//内容
	private Date operationdate=new Date();//添加时间
	@Column(name="operationer")
	private String operationer;//添加人
	@Column(name="operationerid")
	private String operationerid;//添加人id
	private String year;//年份
	private String deptid;//部门id
	private String level;//级别
	private String type;//类型
	private String target;//目标
	private String weight;//权重
	private String ssessmentindex;//考核指标
	
	
	//任务信息
	private String pid;
	private String planid;
	private String stime;
	private String endtime;
	private String fuzherenname;
	private String fuzherenid;
	private String ziyuanpeizhi;
	private String jindu;
	
	private String 	changesm;
	private String 	taskid;
	private String 	state; //是否通过
	private String 	isnormal;//是否正常变更
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getIsnormal() {
		return isnormal;
	}
	public void setIsnormal(String isnormal) {
		this.isnormal = isnormal;
	}

	public String getFuzherenname() {
		return fuzherenname;
	}
	public void setFuzherenname(String fuzherenname) {
		this.fuzherenname = fuzherenname;
	}
	public String getFuzherenid() {
		return fuzherenid;
	}
	public void setFuzherenid(String fuzherenid) {
		this.fuzherenid = fuzherenid;
	}
	public String getZiyuanpeizhi() {
		return ziyuanpeizhi;
	}
	public void setZiyuanpeizhi(String ziyuanpeizhi) {
		this.ziyuanpeizhi = ziyuanpeizhi;
	}
	public String getJindu() {
		return jindu;
	}
	public void setJindu(String jindu) {
		this.jindu = jindu;
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
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getSsessmentindex() {
		return ssessmentindex;
	}
	public void setSsessmentindex(String ssessmentindex) {
		this.ssessmentindex = ssessmentindex;
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
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getStime() {
		return stime;
	}
	public void setStime(String stime) {
		this.stime = stime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getPlanid() {
		return planid;
	}
	public void setPlanid(String planid) {
		this.planid = planid;
	}
	public String getChangesm() {
		return changesm;
	}
	public void setChangesm(String changesm) {
		this.changesm = changesm;
	}
	public String getTaskid() {
		return taskid;
	}
	public void setTaskid(String taskid) {
		this.taskid = taskid;
	}
	
	
 
}

