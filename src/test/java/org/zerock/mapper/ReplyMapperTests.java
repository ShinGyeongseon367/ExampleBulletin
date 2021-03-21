
package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class ReplyMapperTests {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	private Long[] bnoArr = {3145745L, 3145744L, 3145744L, 3145742L, 3145741L};
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	/*@Test
	public void testCreate() {
		IntStream.rangeClosed(1,  10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
					
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트 : " + i);
			vo.setReplyer("replyer : " + i);
			
			mapper.insert(vo);
		});
	}*/
	
//	@Test
//	public void testRead() {
//		Long targetRno = 5L;
//		
//		ReplyVO vo = mapper.read(targetRno);
//		
//		log.info(vo);
//	}
	
//	@Test
//	public void testDelete() {
//		int targetRno = 1;
//		mapper.delete(targetRno);
//		log.info("delete Number : "+targetRno);
//	}
//	
//	@Test
//	public void testUpdate() {
//		ReplyVO vo = new ReplyVO();
//		vo.setReply("수정한 댓글");
//		vo.setRno(2L);
//		
//		mapper.update(vo);
//		
//		log.info("update content : " + vo);
//	}
	
//	@Test
//	public void testList() {
//		Criteria cri = new Criteria();
//		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
//		log.info("testList replies -----> ");
//		
//		replies.forEach(reply -> log.info(reply));
//	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2, 10);
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 3145745L);
		
		replies.forEach(reply -> log.info(reply));
	}
}
