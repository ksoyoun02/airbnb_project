package com.spring.airbnb.persistence.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.spring.airbnb.domain.MemberDTO;
import com.spring.airbnb.mapper.MemberMapper;
import com.spring.airbnb.persistence.IMemberDAO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Repository
public class MemberDAOImpl implements IMemberDAO{

	@Autowired
	private SqlSession session;
	
	@Override
	public MemberDTO getMember(MemberDTO mDto) throws Exception {
		return session.selectOne("MemberMapper.getMember", mDto);
	
	}

	@Override
	public int confirmID(String userId) throws Exception {
		MemberDTO mDto = null;
		int result = -1;
		mDto = session.selectOne("MemberMapper.selJoinId", userId);
		if (mDto != null) {
			result = 1;
		}else {
			result = -1;
		}
		return result;
	}

	
	@Override
	public int insertMember(MemberDTO mDto) {
		
		int result = 0;
		result = session.insert("MemberMapper.insertMember", mDto);
		
		return result;
	}
	
	@Override
	public int updateMember(MemberDTO mDto) {
		
		int result = 0;
		result = session.update("MemberMapper.updateMember", mDto);
		
		return result;
	}
	
	
	
	@Override
	public int deleteMember(String id) {
		int result = 0;
		result = session.delete("MemberMapper.deleteMember", id);
		
		return result;
	}

	@Override
	public MemberDTO findIdPhone(MemberDTO mDto) throws Exception {
		
		Map<String, String> fId = new HashMap<>();
		fId.put("name", mDto.getName());
		fId.put("phone", mDto.getPhone());
		
		MemberDTO findIdPhone = session.selectOne("MemberMapper.findIdPhone", fId);
		
		return findIdPhone;
	}
	
	@Override
	public MemberDTO findIdEmail(MemberDTO mDto) throws Exception {
		
		Map<String, String> fId = new HashMap<>();
		fId.put("name", mDto.getName());
		fId.put("email", mDto.getEmail());
		
		MemberDTO findIdEmail = session.selectOne("MemberMapper.findIdEmail", fId);
		
		return findIdEmail;
	}

	@Override
	public MemberDTO findPwd(MemberDTO mDto) throws Exception {
		
		Map<String, String> fPwd = new HashMap<>();
		
		fPwd.put("id", mDto.getId());
		fPwd.put("name", mDto.getName());
		fPwd.put("phone", mDto.getPhone());
		fPwd.put("email", mDto.getEmail());
		
		MemberDTO findPwd = session.selectOne("MemberMapper.findPwd", fPwd);
		
		return findPwd;
	}

	@Override
	public MemberDTO read(String id) throws Exception {
		
		return session.selectOne("MemberMapper.read", id);
	}

	@Override
	public int updatePwd(MemberDTO mDto) {
		
		int result = 0;
		
		result = session.update("MemberMapper.updatePwd", mDto);
		
		return result;
	}


}
