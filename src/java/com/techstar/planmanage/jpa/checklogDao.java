package com.techstar.planmanage.jpa;
	


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Id;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.techstar.planmanage.entity.checklog;
import com.techstar.planmanage.entity.plan;
import com.techstar.planmanage.entity.plancheck;


public interface checklogDao<T, ID extends Serializable> extends JpaRepository<checklog, ID> ,JpaSpecificationExecutor<checklog>{
	
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
	
	checklog findById(Long id);
	public List<checklog> findByCheckid(String checkid) ;
	public List<checklog> findByTaskid(String taskid) ;
	public List<checklog> findByTaskidAndTypeOrderByIdDesc(String taskid,String type) ;
	List<checklog> findByCheckidAndTypeOrderByIdDesc(String taskid,String type) ;
	List<checklog> findByCheckidAndTypeInOrderByIdDesc(String taskid,List<String> typelist);
   //List<Events> ceventslist=eventsService.findBy("StarttimeGreaterThanAndStarttimeLessThanAndParticipantidLike", sDate, eDate,userid);
}
		


