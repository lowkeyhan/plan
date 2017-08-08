
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
@Table(name = "sp_plan")
public class plan  {
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
	private String isdel;//是否删除
	private String delsm;//删除
	private String delxz;//删除性质
	private Integer zcbg=0;//正常变更
	private Integer fzcbg=0;//非正常变更
	
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
	public String getIsdel() {
		return isdel;
	}
	public void setIsdel(String isdel) {
		this.isdel = isdel;
	}
	public String getDelsm() {
		return delsm;
	}
	public void setDelsm(String delsm) {
		this.delsm = delsm;
	}
	public Integer getZcbg() {
		return zcbg;
	}
	public void setZcbg(Integer zcbg) {
		this.zcbg = zcbg;
	}
	public Integer getFzcbg() {
		return fzcbg;
	}
	public void setFzcbg(Integer fzcbg) {
		this.fzcbg = fzcbg;
	}
	public String getDelxz() {
		return delxz;
	}
	public void setDelxz(String delxz) {
		this.delxz = delxz;
	}
	
	
	
 
}

