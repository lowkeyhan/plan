package com.techstar.planmanage.jpa;
	


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Id;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import com.techstar.planmanage.entity.plan;


public interface PlanDao<T, ID extends Serializable> extends JpaRepository<plan, ID> ,JpaSpecificationExecutor<plan>{
	
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
	
	plan findById(Long id);
   //List<Events> findByStarttimeGreaterThanAndStarttimeLessThanAndOperationerid(Date sDate,Date eDate,String userid);
   //List<Events> findByStarttimeGreaterThanAndStarttimeLessThanAndParticipantidLikeAndOperationeridNot(Date sDate,Date eDate,String userid,String adduserid);
	List<plan> findByDeptidAndYear(String deptid, String year);
	List<plan> findByDeptidAndYearAndPid(String deptid, String year,String pid);
	List<plan> findByPid(String pid);
	List<plan> findByPidAndIsdel(String pid,String isdel);
	List<plan> findByPidAndIsdelAndDelxz(String pid,String isdel,String delxz);
	List<plan> findByFuzherenidLikeAndDeptidInAndJinduNotOrderByStimeAsc(String fuzherenid,List<String> deptid,String jindu);
   
	List<plan> findByIdOrPlanid(Long id,String planid);
	List<plan> findByIdOrPid(Long id,String pid);
	//findBy("StarttimeGreaterThanAndStarttimeLessThanAndOperationerid",sDate ,eDate,userid);
	//List<Events> ceventslist=eventsService.findBy("StarttimeGreaterThanAndStarttimeLessThanAndParticipantidLike", sDate, eDate,userid);
}
		


