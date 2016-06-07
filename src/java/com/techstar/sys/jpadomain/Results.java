package com.techstar.sys.jpadomain;

public class Results {

	private boolean success = true;
	private int statusCode;
	private String message;
	private Object userdata;

	public Results() {
	}

	public Results(boolean success) {
		this.success = success;
	}

	public Results(boolean success, String message) {
		this(success);
		this.message = message;
	}

	public Results(boolean success, String message, int statusCode) {
		this(success, message);
		this.statusCode = statusCode;
	}

	public Results(String message, Object userdata) {
		this.message = message;
		this.userdata = userdata;
	}

	public Results(String message, int statusCode, Object userdata) {
		this(message, userdata);
		this.statusCode = statusCode;
	}

	public Results(Object userdata) {
		this.userdata = userdata;
	}

	public Results(boolean success, Object userdata) {
		this(success);
		this.userdata = userdata;
	}

	public Results(boolean success, String message, Object userdata) {
		this(success, message);
		this.userdata = userdata;
	}

	public Results(boolean success, String message, int statusCode, Object userdata) {
		this(success, message, statusCode);
		this.userdata = userdata;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getUserdata() {
		return userdata;
	}

	public void setUserdata(Object userdata) {
		this.userdata = userdata;
	}

}
