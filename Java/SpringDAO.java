package pj;

import java.util.*;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

public interface SpringDAO {

	public List<SpringVO> productAll( SpringVO vo ) throws Exception;
	public SpringVO detail( SpringVO vo ) throws Exception;
	public List<SpringVO> review( SpringVO vo ) throws Exception;
	public List<SpringVO> qna( SpringVO vo ) throws Exception;
	public List<SpringVO> image( SpringVO vo ) throws Exception;
	public List<SpringVO> cart( SpringVO vo, String id ) throws Exception;
	public String insertcart( SpringVO vo, String id ) throws Exception;
	public void deletecart( SpringVO vo, String id ) throws Exception;
	public List<SpringVO> ordercheck( SpringVO vo, String id, @RequestParam List<String> forcount ) throws Exception;
	public void insertorder( SpringVO vo, String id, String now  ) throws Exception;
	public List<SpringVO> ordered( Integer forcount, String id ) throws Exception;
	public void insertproduct( SpringVO vo, String id, List<MultipartFile> iimage ) throws Exception;
	public List<SpringVO> productrank() throws Exception;
	public void insertqna( SpringVO vo, String id ) throws Exception;
	
	// 22.02.23
	public List<SpringVO> eventlist() throws Exception;
	public SpringVO eventdetail( SpringVO vo ) throws Exception;
	public void insertevent( SpringVO vo, String id ) throws Exception;
	
	public void test( List<SpringVO> vo ) throws Exception;

	// 2022-02-03
	public int register(SpringVO vo, String mode) throws Exception;
	public boolean login(SpringVO vo, String mode) throws Exception;
	
	//2022-02-04
	// 2022-02-06 findMypage ¼öÁ¤
	public SpringVO findMypage(String userid, String mode) throws Exception;
	public List<SpringVO> findNotice() throws Exception;
	public int addNotice(SpringVO vo) throws Exception;
	public SpringVO findNDetail(int pnum) throws Exception;
	public int modify(SpringVO vo, String mode) throws Exception;
	
	//2022-02-07
	public List<SpringVO> findWaiting() throws Exception;
	
	//2022-02-08
	public List<SpringVO> findQnA(String id) throws Exception;
	public int answer(SpringVO vo) throws Exception;
	public int confirmOrder(int odnum) throws Exception;
	public String requestFind(String kind, SpringVO vo) throws Exception;
	
	//2022-02-09
	public int requestSoldout(int pid) throws Exception;
	public int uploadRev(SpringVO vo, String id) throws Exception;
}
