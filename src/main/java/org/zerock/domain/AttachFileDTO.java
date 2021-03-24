package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AttachFileDTO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private String imageUri;
	private String fileExtends;
	private boolean image;
}

/* form 으로 데이터를 실어서 줄 때  단순하게 위에 있는 필드 명으로 넣어주는 것이 아니라 
 * BoardVO에 list로 선언되어 있는 이름 변수명.필드 명 ex attatchList[0].fileName 이런식으로 넣어줘야한다. 
 * 간단한 것이지만 , DTO, DAO로 전달을 하고 싶다면 파라미터로 !! 또 메서드에 선언되어 있는 타입으로 form의 데이터를 실어서 넣어줘야 하는 것이다. 
 *  2021-03-25 기록 
 */