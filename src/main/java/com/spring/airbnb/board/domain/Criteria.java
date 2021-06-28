package com.spring.airbnb.board.domain;



import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;

	// pageNum, amount 값이 default일때 1, 10이 기본값으로 넘어감
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[]{} : type.split("");
		// type이 null 이면? 참:거짓
		
	}
	
	//UriComponentsBuilder -> 여러개의 파라미터들을 연결해서 url의 형태로 만들어주는 기능
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keywore", this.getKeyword());
		
		return builder.toUriString();
	}
}

