package com.techstar.sys.dingAPI.user;

import java.util.List;

import com.alibaba.fastjson.JSONObject;

public class User {
	public String userid;
	public String name;
	public boolean active;
	public String avatar;
	public List<Long> department;
	public String position;
	public String mobile;
	public String tel;
	public String workPlace;
	public String remark;
	public String email;
	public String jobnumber;
	public JSONObject extattr;
	public String isLeaderInDepts;
	public String isAdmin;
	public User() {
	}
	
	public User(String userid, String name) {
		this.userid = userid;
		this.name = name;
	}
	
	@Override
	public String toString() {
		List<User> users;
		String userString= "User[userid:" + userid + ", name:" + name + ", active:" + active + ", "
				+ "avatar:" + avatar + ", department:" + department +
				", position:" + position + ", mobile:" + mobile + ", email:" + email + 
				", extattr:" + extattr+ ", isLeaderInDepts:" + isLeaderInDepts+ ", isAdmin:" + isAdmin+"]";
		System.out.println(userString);
		return userString;
	}
	
	public String toJSONString() {
		String userString="{\"userid\":\"" + userid + "\",\"name\":\"" + name + "\",\"active\":\"" + active + "\","
				+ "\"avatar\":\"" + avatar + "\",\"department\":\"" + department +
				"\",\"position\":\"" + position + "\",\"mobile\":\"" + mobile + "\",\"email\":\"" + email + 
				"\",\"extattr\":" + extattr+",\"isLeaderInDepts\":\""+isLeaderInDepts+"\",\"isAdmin\":\""+isAdmin+"\"}";
		System.out.println(userString);
		return userString;
		}
}
