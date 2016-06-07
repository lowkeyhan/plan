package com.techstar.sys.Util;

import org.apache.commons.lang.StringUtils;

@SuppressWarnings("all")
public class StringUtil extends StringUtils{
	
	
	/**
	 * 对象转换成字符串
	 * @param obj
	 * @return
	 */
	public static String asString(Object obj){
		String defaultValue = "";
		if(obj == null ) return defaultValue;
		String str = trim(obj.toString());
		if(isBlank(str) || isEmpty(str)) return defaultValue;
		return obj.toString();
	}
	
	
	/**
	 * 对象转换成字符串
	 * @param obj
	 * @param defaultValue
	 * @return
	 */
	public static String asString(Object obj,String defaultValue){
		if(obj == null ) return defaultValue;
		String str = trim(obj.toString());
		if(isBlank(str) || isEmpty(str)) return defaultValue;
		return obj.toString();
	}
	
	/**
	 * 判断对象是否为空
	 * @param obj
	 * @return
	 */
	public static boolean isBlank(Object obj){
		return asString(obj, null)==null?true:false;
	}
	
	/**
	 * 判断对象是否不为空
	 * @param obj
	 * @return
	 */
	public static boolean isNotBlank(Object obj){
		return asString(obj, null)==null?false:true;
	}
	
	/**
	 * @param fileName
	 * @return Excel2003:返回0 ；Excel2007:返回1 ； 其它返回-1
	 */
	public static int verifyExcelVersion(String fileName) {
		if(StringUtil.isNotBlank(fileName)){
			String fileType = fileName.substring(fileName.lastIndexOf("."),fileName.length());
			if(StringUtil.isNotBlank(fileType) && ".xls".equalsIgnoreCase(fileType)){
				return 0;//Excel2003
			}
			if(StringUtil.isNotBlank(fileType) && ".xlsx".equalsIgnoreCase(fileType)){
				return 1;//Excel2007
			}
		}
		
		return -1;//其它文件类型
	}
}