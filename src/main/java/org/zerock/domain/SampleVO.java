package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
// 모든 매개변수가 있는 생성자를 만들기 위해서 선언
@AllArgsConstructor
// 비어있는 생성자를 생성하기 위해서 선언
@NoArgsConstructor
public class SampleVO {

	private Integer mno;
	private String firstName;
	private String lastName;
}
