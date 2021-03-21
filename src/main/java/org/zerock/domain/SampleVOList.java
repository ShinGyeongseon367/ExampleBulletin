package org.zerock.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
// 모든 매개변수가 있는 생성자를 만들기 위해서 선언
@AllArgsConstructor
// 비어있는 생성자를 생성하기 위해서 선언

public class SampleVOList {

	private List<SampleVO> list;
	
	public SampleVOList() {
		list = new ArrayList<>();
	}
	
}
