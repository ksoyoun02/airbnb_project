package com.spring.airbnb.persistence;

import com.spring.airbnb.domain.MemberDTO;

public interface IMemberDAO {
	
	public MemberDTO getMember(MemberDTO mDto) throws Exception;
	public int confirmID(String userId) throws Exception;
	public int insertMember(MemberDTO mDto);
	public int updateMember(MemberDTO mDto);
	public int deleteMember(String id);
	public MemberDTO findIdPhone(MemberDTO mDto) throws Exception;
	public MemberDTO findIdEmail(MemberDTO mDto) throws Exception;
	public MemberDTO findPwd(MemberDTO mDto) throws Exception;

	public int updatePwd(MemberDTO mDto);
	public MemberDTO read(String userId) throws Exception;
}
