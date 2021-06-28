package com.spring.airbnb.mail;

public class MailUtil {

	public static void sendMail(String email, String subject, String msg) throws Exception {
		
		
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "ksoyoun95";
		String hostSMTPpwd = "#kthdus0214#";
		
		// 보내는 사람
		String fromEmail = "ksoyoun95@naver.com";
		String fromName = "airbnb";
		
		// email 전송
//		try {
//			HtmlEmail mail = new HtmlEmail();
//			mail.setDebug(true);
//			mail.setCharset(charSet);
//			mail.setSSLOnConnect(true); // SSL 사용 (TLS가 없는 경우 SSL 사용)
//			
//			mail.setHostName(hostSMTP);
//			mail.setSmtpPort(465);
//			
//			mail.setAuthentication(hostSMTPid, hostSMTPpwd);
//			mail.setStartTLSEnabled(true);
//			mail.addTo(email);
//			mail.setFrom(fromEmail, fromName, charSet);
//			mail.setSubject(subject);
//			mail.setHtmlMsg(msg);
//			mail.send();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}
}
