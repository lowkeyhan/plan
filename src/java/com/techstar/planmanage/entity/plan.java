
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
	
	
 
}

