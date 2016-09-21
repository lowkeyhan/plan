package com.techstar.planmanage.jpa;
	


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Id;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.techstar.planmanage.entity.plan;
import com.techstar.planmanage.entity.plancheck;


public interface PlancheckDao<T, ID extends Serializable> extends JpaRepository<plancheck, ID> ,JpaSpecificationExecutor<plancheck>{
	
	/**
	 * 根据spring data jpa 规范查询记录
	 * 
	 * @param queryName
	 *            按spring data jpa 规范编写，findByName=>name、findByIdAndName=>idAndName
	 * @param values
	 *            查询参数
	 * @return
	 */
	//List<Events> findBy(final String queryName, final Object... values);
	
	plancheck findById(Long id);
	List<plancheck> findByDeptidAndYear(String deptid, String year) ;
	List<plancheck> findByDeptidInAndState(List<String> deptidlist,String state);
	
	List<plancheck> findByState(String state);
	
	List<plancheck> findByDeptidInAndYearAndState(List<String> deptidlist,String year,String state);
   //List<Events> ceventslist=eventsService.findBy("StarttimeGreaterThanAndStarttimeLessThanAndParticipantidLike", sDate, eDate,userid);
}
		


