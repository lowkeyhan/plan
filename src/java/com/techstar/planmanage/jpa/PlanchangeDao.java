package com.techstar.planmanage.jpa;
	


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Id;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.techstar.planmanage.entity.plan;
import com.techstar.planmanage.entity.planchange;


public interface PlanchangeDao<T, ID extends Serializable> extends JpaRepository<planchange, ID> ,JpaSpecificationExecutor<planchange>{
	
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
	
	planchange findById(Long id);

	List<planchange> findByTaskidOrderByOperationdateDesc(String Taskid);
   //List<Events> findByStarttimeGreaterThanAndStarttimeLessThanAndOperationerid(Date sDate,Date eDate,String userid);
   //List<Events> findByStarttimeGreaterThanAndStarttimeLessThanAndParticipantidLikeAndOperationeridNot(Date sDate,Date eDate,String userid,String adduserid);
	List<planchange> findByDeptidAndYear(String deptid, String year);
	List<planchange> findByDeptidAndYearAndPid(String deptid, String year,String pid);
	List<planchange> findByPid(String pid);
	List<planchange> findByFuzherenidLikeAndDeptidInAndJinduNotOrderByStimeAsc(String fuzherenid,List<String> deptid,String jindu);
   //findBy("StarttimeGreaterThanAndStarttimeLessThanAndOperationerid",sDate ,eDate,userid);
	//List<Events> ceventslist=eventsService.findBy("StarttimeGreaterThanAndStarttimeLessThanAndParticipantidLike", sDate, eDate,userid);
}
		


