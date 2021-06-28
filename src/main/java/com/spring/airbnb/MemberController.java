package com.spring.airbnb;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.airbnb.domain.MemberDTO;
import com.spring.airbnb.persistence.IMemberDAO;
import com.spring.airbnb.persistence.IReserveDAO;
import com.spring.airbnb.review.persistence.IReviewDAO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private IMemberDAO member;
	
	@Autowired
	private IReserveDAO reserve;
	
	@Autowired
	private IReviewDAO review;
	
	@RequestMapping("/login")
	public String login() {
		log.info("login");
		
		return "/member/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberDTO mDto, HttpSession session, Model model ) throws Exception {
		log.info("login id/pw post.....");
		
		String returnURL = "";
		MemberDTO memInfo = member.getMember(mDto);
		
		log.info("사용자가 입력한 로그인 정보 : " + mDto.getId() + "//" + mDto.getPwd());
		log.info("memInfo -->" + memInfo);
	
		if(memInfo == null) {
			return "redirect:/member/login";
			
		}
		model.addAttribute("memInfo",memInfo);
	
		return returnURL;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception{
		
		
		session.invalidate();
		return "redirect:/main";
	}
	
	@RequestMapping("/join")
	public String join() throws Exception{
	
		
		log.info("join page");
		
		return "/member/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(MemberDTO mDto,HttpServletRequest request, HttpServletResponse response) throws Exception{
		log.info("join post...");
		
		mDto.setAddress(request.getParameter("roadAddress") + " " + request.getParameter("jibunAddress") + " " + request.getParameter("detailAddress") +request.getParameter("extraAddress"));
		mDto.setEmail(request.getParameter("email1") + "@" + request.getParameter("email2"));

		int result = 0;
		result = member.insertMember(mDto);
		
		
		if(result == 1) {
			log.info("회원가입 성공");
		}
		
		return "/member/login";
	}
	
	@RequestMapping("/id_check")
	public String id_check(String userId, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String id = request.getParameter("id");
		int message = member.confirmID(id);
		
		JSONObject jObj = new JSONObject();
		
		jObj.put("message", message);
		jObj.put("id", userId);
		
		response.setContentType("application/x-json; charset=UTF-8"); 
		response.getWriter().print(jObj);
		return null;
	}
	
	@RequestMapping("/mypage")
	public String mypage() {
		log.info("mypage");
		
		return "/member/mypage";
	}
	
	@PostMapping("/memberModify")
	public String memberModify(MemberDTO mDto, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		mDto.setAddress(request.getParameter("roadAddress") + " " + request.getParameter("jibunAddress") + " " + request.getParameter("detailAddress") +request.getParameter("extraAddress"));
		
		int result = member.updateMember(mDto);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		HttpSession session = request.getSession(false);
		
		if (result > 0) {
			pw.print("<script>" + " alert('회원수정 성공. 다시 로그인 해주세요');" + " location.href='" + "/airbnb/main';" + "</script>");
			session.invalidate();
		}else {
			pw.print("<script>" + " alert('회원수정 실패.');" + " history.go(-1);" + "</script>");
		}
		return null;
	}

	@PostMapping("/deleteMember")
	public String deleteMember(String id, HttpServletRequest request, HttpServletResponse response) {
		member.deleteMember(id);
		
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate(); 
		}
		
		return "/member/deleteMember";
	}
	
	@RequestMapping("/findId")
	public String findId() {
		log.info("findId ..........");
		return "/member/findId";
	}
	
	@PostMapping("/findIdPhone")
	public String findIdPhone(MemberDTO mDto, Model model) throws Exception {
		
		MemberDTO findIdPhone = member.findIdPhone(mDto);

		if(findIdPhone != null) {
			model.addAttribute("findId", findIdPhone);
			
			log.info("findIdPhone =====> " + findIdPhone);
		}else {
			
			model.addAttribute("msg", "일치하는 회원정보가 없습니다");
			model.addAttribute("url", "/airbnb/member/findId");
			log.info("일치하는 회원정보 없음");
			return "member/find_Result_null";
		}
		
		return "/member/findId_Result";
	}
	
	
	@PostMapping("/findIdEmail")
	public String findIdEmail(MemberDTO mDto, Model model) throws Exception {
		
		MemberDTO findIdEmail = member.findIdEmail(mDto);
		
		if(findIdEmail != null) {
			model.addAttribute("findId", findIdEmail);
			
			log.info("findIdEmail =====> " + findIdEmail);
		}else {
			
			model.addAttribute("msg", "일치하는 회원정보가 없습니다");
			model.addAttribute("url", "/airbnb/member/findId");
			log.info("일치하는 회원정보 없음");
			return "member/find_Result_null";
		}

		
		return "/member/findId_Result";
	}
	
	@RequestMapping("/findPwd")
	public String findPwd() {
		log.info("findPwd ..........");
		return "/member/findPwd";
	}
	
	@PostMapping("/findPwd")
	public String findPwd(MemberDTO mDto, Model model) throws Exception {
		
		MemberDTO findPwd = member.findPwd(mDto);
		
		if(findPwd != null) {
			model.addAttribute("findPwd", findPwd);
			
			log.info("findPwd =====> " + findPwd);
		}else {
			
			model.addAttribute("msg", "일치하는 회원정보가 없습니다");
			model.addAttribute("url", "/airbnb/member/findPwd");
			
			log.info("일치하는 회원정보가 없음");
			return "member/find_Result_null";
		}
		log.info("findPwd =====> " + findPwd);
		
		return "/member/findPwd_Result";
	}
	
	@RequestMapping("/myReserve")
	public String myReserve(@RequestParam("userId") String userId, Model model) {
		
		model.addAttribute("userReserveList", reserve.listUserReserve(userId));
		
		return "/member/myReserve";
	}
	
	@RequestMapping("/myReview")
	public String myReview(@RequestParam("userId") String userId, Model model) {
		
		model.addAttribute("userReviewList", review.selUserReview(userId));
		
		return "/member/myReview";
	}
	
	@GetMapping("/deleteReserve")
	public String deleteReview(@RequestParam("r_no") int r_no, HttpServletResponse response) throws Exception {
		
		log.info("온다");
		int result = reserve.deleteReserve(r_no);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		if (result > 0) {
			pw.print("<script>" + " alert('삭제완료');" + " location.href='" + "/airbnb/member/mypage';" + "</script>");
		}else {
			pw.print("<script>" + " alert('다시 한번 시도해 주세요');" + " history.go(-1);" + "</script>");
		}
		
		
		return null;
	}
	
	@RequestMapping("/pwdUpdate")
	public String pwdUpdate() {
		log.info("pwdUpdate");
		
		return "/member/pwdUpdate";
	}
	
	@PostMapping("/pwdUpdate")
	public String pwdUpdate(@RequestParam("old_pwd") String old_pwd, @RequestParam("new_pwd") String new_pwd, HttpServletRequest request, HttpServletResponse response, @RequestParam("id") String id) throws Exception {
		log.info("pwdUpdate get...");
		log.info("사용자가 입력한 비밀번호 updare 정보" + old_pwd+" // "+new_pwd);
		
		HttpSession session = request.getSession();
		
		MemberDTO mDto = member.read(id);
		log.info("mDto" + mDto);
		
		String pwd = mDto.getPwd();
		log.info(pwd);
		int updateResult = 0;
		if(pwd.equals(old_pwd)) {
			mDto.setPwd(new_pwd);
			log.info(mDto.getPwd());
			log.info(mDto);
			updateResult = member.updatePwd(mDto);
		}
		
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		if (updateResult > 0) {
			pw.print("<script>" + " alert('비밀번호 변경 성공. 다시 로그인 해주세요');" + " location.href='" + "/airbnb/main';" + "</script>");
			session.invalidate();
		}else {
			pw.print("<script>" + " alert('비밀번호 변경 실패. 다시 시도해주세요');" + " history.go(-1);" + "</script>");
		}
		
		return null;
	}
}	

