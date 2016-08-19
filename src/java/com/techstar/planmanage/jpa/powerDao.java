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
import com.techstar.planmanage.entity.power;


public interface powerDao<T, ID extends Serializable> extends JpaRepository<power, ID> ,JpaSpecificationExecutor<power>{
	
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
	
	power findById(Long id);
	public List<power> findByAdminidAndType(String Adminid,String type) ;
	public List<power> findByType(String type) ;
   //List<Events> ceventslist=eventsService.findBy("StarttimeGreaterThanAndStarttimeLessThanAndParticipantidLike", sDate, eDate,userid);
}
		


