package com.techstar.sys.dingAPI.message;


import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import com.techstar.sys.config.Global;
import com.techstar.sys.dingAPI.auth.AuthHelper;
import com.techstar.sys.dingAPI.utils.HttpHelper;
import com.alibaba.fastjson.JSONObject;
import com.techstar.sys.dingAPI.Env;
import com.techstar.sys.dingAPI.OApiException;
import com.techstar.sys.dingAPI.OApiResultException;

public class MessageHelper {

	public static class Receipt {
		String invaliduser;
		String invalidparty;
	}
	
	
	public static Receipt send(String accessToken, LightAppMessageDelivery delivery) 
			throws OApiException {
		String url = Env.OAPI_HOST + "/message/send?" +
				"access_token=" + accessToken;
		
		JSONObject response = HttpHelper.httpPost(url, delivery.toJsonObject());
		if (response.containsKey("invaliduser") || response.containsKey("invalidparty")) {
			Receipt receipt = new Receipt();
			receipt.invaliduser = response.getString("invaliduser");
			receipt.invalidparty = response.getString("invalidparty");
			return receipt;
		}
		else {
			throw new OApiResultException("invaliduser or invalidparty");
		}
	}
	
	
	public static String send(String accessToken, ConversationMessageDelivery delivery) 
		throws OApiException {
		String url = Env.OAPI_HOST + "/message/send_to_conversation?" +
				"access_token=" + accessToken;
		
		JSONObject response = HttpHelper.httpPost(url, delivery.toJsonObject());
		if (response.containsKey("receiver")) {
			return response.getString("receiver");
		}
		else {
			throw new OApiResultException("receiver");
		}
	}
	/**
	 * @param pcurl 电脑版地址 格式 /news/方法
	 * @param murl  手机版地址
	 * @param headtext 头部标题
	 * @param bodytitle 信息标题
	 * @param author    发信人
	 * @param bodycontect 信息内容
	 * @param tousers  接收人 格式 id|id|id
	 * @param request 为了获取全部网络地址
	 * @return
	 * @throws OApiException
	 * @throws UnsupportedEncodingException
	 */
	public static String  sendmessage(String pcurl,String murl,String headtext,
			String bodytitle,String author,String bodycontect,String tousers,
			HttpServletRequest request) throws OApiException, UnsupportedEncodingException {
		OAMessage oaMessage=new OAMessage();
		String urlString = request.getScheme() +"://" + request.getServerName()+ ":" +request.getServerPort()+request.getContextPath();
		//urlString+="/news/looknews?id=15";
		oaMessage.pc_message_url=urlString+pcurl;
		oaMessage.message_url=urlString+murl;
		OAMessage.Head head=new OAMessage.Head();
		head.bgcolor="FF30A8A5";
		head.text=headtext;
		oaMessage.head=head;
		OAMessage.Body body=new OAMessage.Body();
		body.title=bodytitle;
		body.author=author;
		body.content=bodycontect;
		oaMessage.body=body;
		LightAppMessageDelivery liappmes=new LightAppMessageDelivery(tousers,"", Global.getConfig("dingding.appid"));
		liappmes.withMessage(oaMessage);
		String accessToken = AuthHelper.getAccessToken();
		MessageHelper.send(accessToken, liappmes);
		
		return  "发送成功";
	}
}
