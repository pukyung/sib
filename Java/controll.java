package pj;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import pj.SpringVO;

@Controller
public class controll {
	
	private JdbcTemplate jdbcTemplate = null;
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) { this.jdbcTemplate = jdbcTemplate; }
	public JdbcTemplate getJdbcTemplate() { return jdbcTemplate; }
	
	private SpringDAO_Im springDao = null;
	
	public SpringDAO_Im getSpringDao() { return springDao; }
	public void setSpringDao(SpringDAO_Im springDao) { this.springDao = springDao; }
	
	
	//메인 페이지 이동
	@RequestMapping("/main.pj")
	public ModelAndView main( HttpSession session) throws Exception{
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("main");
		mnv.addObject( "rank", springDao.productrank() );
		
		return mnv;
	}
	
	// 상품 전체 페이지
	@RequestMapping( "/product.pj" )
	public ModelAndView product( @ModelAttribute SpringVO vo ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.setViewName( "product" );
		// 상품 가져오기
		mnv.addObject( "list", springDao.productAll( vo ) );
		
		return mnv;
	}
	
	// 상품 상세 페이지
	@RequestMapping( "/detail.pj" )
	public ModelAndView detail( @ModelAttribute SpringVO vo ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.setViewName( "detail" );
		// 상품 정보 가져오기
		mnv.addObject( "info", springDao.detail( vo ) );
		// 상품 이미지 가져오기
		mnv.addObject( "img", springDao.image( vo ) );
		// 리뷰 가져오기
		mnv.addObject( "review", springDao.review( vo ) );
		// QnA 가져오기
		mnv.addObject( "qna", springDao.qna( vo ) );

		
		return mnv;
	}
	
	// 상품 추가 페이지
	@RequestMapping( "/productin.pj" )
	public ModelAndView productin( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName( "productin" );
		
		return mnv;
	}
	
	// 상품 추가
	@RequestMapping( "/insertproduct.pj" )
	public String insertproduct( @ModelAttribute SpringVO vo, HttpSession session, @RequestParam(required=false) List<MultipartFile> iimage ) throws Exception {


		springDao.insertproduct( vo, (String)session.getAttribute("userid"), iimage );
		
		return "redirect:product.pj";
	}
	
	// 장바구니 페이지
	@RequestMapping( "/cart.pj" )
	public ModelAndView cart( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName( "cart" );
		mnv.addObject( "cart", springDao.cart( vo, (String)session.getAttribute( "userid" ) ) );
		return mnv;
	}
	
	// 장바구니 추가 기능
	@RequestMapping( "/insertcart.pj" )
	public String insertcart( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		return springDao.insertcart( vo, (String)session.getAttribute( "userid" ) );
	}
	
	@RequestMapping( "/deletecart.pj" )
	public String deletecart( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		springDao.deletecart( vo, (String)session.getAttribute( "userid" ) );
		
		return "redirect:/cart.pj";
	}
	
	// 주문 페이지
	@RequestMapping( "/ordercheck.pj" )
	public ModelAndView ordercheck( @ModelAttribute SpringVO vo, HttpSession session, @RequestParam(required=false) List<String> cartcount ) throws Exception {

		ModelAndView mnv = new ModelAndView();
		mnv.setViewName( "order" );
		mnv.addObject( "order", springDao.ordercheck( vo, (String)session.getAttribute("userid"), cartcount ) );
		return mnv;
	}
	
	// order_T 에 값 넣기
	@RequestMapping( "/insertorder.pj" )
	public String insertorder( @ModelAttribute SpringVO vo, HttpSession session, @RequestParam(required=false) List<String> ppid,
			@RequestParam(required=false) List<String> ppname, @RequestParam(required=false) List<String> ppcount,
			@RequestParam(required=false) List<String> ptotal, @RequestParam(required=false) List<String> ccnum ) throws Exception {

		SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
		Date time = new Date();
		
		String now = format.format( time );

		for( int i=0;i<ppid.size(); i++ ) {
			
			vo.setPid( Integer.parseInt( ppid.get(i) ) );
			vo.setPname( ppid.get(i) );
			vo.setPcount( Integer.parseInt( ppcount.get(i) ) );
			vo.setTotal( Integer.parseInt( ptotal.get(i) ) );
			vo.setCnum( Integer.parseInt( ccnum.get(i) ) );
			
			springDao.insertorder( vo, (String)session.getAttribute( "userid" ), now );
			
			if( vo.getOption().indexOf( "cart" ) != -1 ) {
				springDao.deletecart( vo, (String)session.getAttribute( "userid" ) );
			
			} else if( vo.getOption().indexOf( "event" ) != -1 ) {
				System.out.println( "evnum : " + vo.getEvnum() );
				springDao.eventupdate( vo );				
			} 
		}
		return "redirect:ordered.pj?forcount="+ppid.size();
	}
	
	// 가장 최근 주문내역 페이지
	@RequestMapping( "/ordered.pj" )
	public ModelAndView ordered( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {		
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName( "ordered" );
		mnv.addObject( "ordered", springDao.ordered( vo.getForcount(), (String)session.getAttribute( "userid" ) ) );
		
		return mnv;
	}
	
	// QnA 추가
	@RequestMapping( "/inserqna.pj" )
	public String insertqna( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		springDao.insertqna( vo, (String)session.getAttribute("userid") );
		
		return "redirect:/detail.pj?pid=" + vo.getPid();
	}
	
	// Event 리스트 내역 페이지
	@RequestMapping( "/event.pj" )
	public ModelAndView event( @ModelAttribute SpringVO vo ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.addObject( "eventlist", springDao.eventlist() );
		
		mnv.setViewName( "event" );
		
		return mnv;
	}
	
	// Event 상세 페이지
	@RequestMapping( "/eventdetail.pj" )
	public ModelAndView evnetdetail( @ModelAttribute SpringVO vo ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		// Event 상세 내용
		mnv.addObject( "eventdetail", springDao.eventdetail( vo ) );
		
		// 소비자 Event 참여 내역
		mnv.addObject( "eventpart", springDao.eventpart( vo ) );
		
		mnv.setViewName( "eventdetail" );
		
		return mnv;
	}
	
	// insertEvent
	@RequestMapping( "/insertevent.pj" )
	public String insertevent( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		springDao.insertevent( vo , (String)session.getAttribute("userid") );
		
		return "redirect:/eventdetail.pj?pid=" + vo.getPid() + "&evnum=" + vo.getEvnum();
	}
	
	// Eventcheck
	@RequestMapping( "/eventcheck.pj" )
	public ModelAndView eventcheck( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.addObject( "eventcheck", springDao.eventcheck( vo, (String)session.getAttribute( "userid") ) );
		mnv.setViewName( "eventcheck" );
		
		return mnv;
	}
	
	// ############################################################################
	// ############################################################################
	// ############################################################################
	
	

	// 사용자 등록하는 메소드  2022-02-03
		@RequestMapping("/register.pj")
		public ModelAndView register(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			if(session.getAttribute("userid") != null) {
				mnv.setViewName("main");
			}
			else {
				mnv.setViewName("account");
			}
			return mnv;
		}
		
		//판매자 등록 요청 후 이동 유도
		@RequestMapping("/notification.pj")
		public ModelAndView notification(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			if(session.getAttribute("userid")==null) {
				mnv.setViewName("notification");
			}
			else {
				mnv.setViewName("main");
			}
			return mnv;
		}
		
		//로그인 화면 이동  2022-02-03  소비자 로그인 확인 시, jshe1207 & aa134로 확인
		// 수정 : 로그인 된 상태일 때, 로그인 화면 접근 불가 2022-02-04
		@RequestMapping("/login.pj")
		public ModelAndView login(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			// 로그인 정보가 존재할 때, main페이지로 이동
			if(session.getAttribute("userid")!=null) {
				mnv.setViewName("main");
			}
			else {
				mnv.setViewName("login");
			}
			
			return mnv;
		}
		
		// id/비밀번호 찾기 전 사용자/구매자 선택 페이지 2022-02-08
		@RequestMapping("/findMyIdPw.pj")
		public ModelAndView selectKind(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			if(session.getAttribute("userid")==null) {
				mnv.setViewName("findPage");
			}
			else {
				mnv.setViewName("main");
			}
			return mnv;
		}
		
		//id/비밀번호 찾기 페이지 2022-02-08 
		// 수정완료 2022-02-09
			@RequestMapping("/find.pj")
			public ModelAndView findMyKey(@RequestParam("mode") String mode, HttpSession session) throws Exception{
				ModelAndView mnv = new ModelAndView();
				if(session.getAttribute("userid")==null) {
					mnv.addObject("mode", mode);
					mnv.setViewName("findPage");
				}
				else {
					mnv.setViewName("main");
				}
				return mnv;
			}
		
		// 아이디 비밀번호 찾기 결과 2022-02-09
		@RequestMapping("findResult.pj")
		public ModelAndView findResult(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			String IdPw = (String)session.getAttribute("IdPw");
			if(IdPw!=null) {
				mnv.addObject("IdPw", IdPw);
			}
			String res = (String)session.getAttribute("result");
			if(res!=null) {
				mnv.addObject("result", res);
			}
			mnv.setViewName("result");
			
			return mnv;
		}
		
		//마이페이지로 이동 2022-02-04
		// 수정 완료- mypage.pj에 접속하면 사용자의 모드에 따라 마이페이지에 옮겨가도록 2022-02-08
		@RequestMapping("/mypage.pj")
		public ModelAndView mypage(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			// 로그인 시에만 마이페이지 접근 가능
			if(session.getAttribute("userid")!=null) {
				String userid = (String)session.getAttribute("userid");
				String kind = (String)session.getAttribute("kind");
				List<SpringVO> reviews = springDao.reviews(kind, userid);
				
				if(kind.equals("cus")) {
					SpringVO vo = springDao.findMypage(userid,"cus");
					List<SpringVO> ship = springDao.findMyOrder(userid);
					List<SpringVO> orderall = springDao.findOrderAll(userid);
					
					mnv.addObject("mypage", vo);
					mnv.addObject("orderall",orderall);
					mnv.addObject("reviews", reviews);
					
					if(ship!=null) {
						mnv.addObject("ship", ship);
					}
					mnv.setViewName("mypage");
				}
				else if(kind.equals("sel")) {
					SpringVO vo = springDao.findMypage(userid,"sel");
					List<SpringVO> sellList = springDao.findMySell(userid);
					List<SpringVO> questions = springDao.findQnA(userid);
					
					mnv.addObject("selpage", vo);
					mnv.addObject("questions",questions);
					mnv.addObject("reviews", reviews);
					
					if(sellList!=null) {
						mnv.addObject("sellList", sellList);
					}
					mnv.setViewName("mypage_seller");
				}
				
			}
			else {
				mnv.setViewName("login");
			}
			
			return mnv;
		}
		
		// 수정 - 메소드를 하나로 합침(cus + sel) 2022-02-08
		@RequestMapping("/modifyInfo.pj")
		public ModelAndView moInfo(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			String userid = (String)session.getAttribute("userid");
			// 로그인 시에만 마이페이지 접근 가능
			if(userid!=null) {
				String kind = (String)session.getAttribute("kind");
				SpringVO vo = null;
				if(kind.equals("cus")) {
					vo = springDao.findMypage(userid,"cus");
					mnv.setViewName("modInfo");
				}
				else if(kind.equals("sel")) {
					vo = springDao.findMypage(userid,"sel");
					mnv.setViewName("modSelInfo");
				}
				mnv.addObject("mypage", vo);
			}
			else {
				mnv.setViewName("login");
			}
			return mnv;
		}
		
		//주문내역 페이지 이동 2022-02-10
		@RequestMapping("/moreorder.pj")
		public ModelAndView showMore(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			String id = (String)session.getAttribute("userid");
			if(session.getAttribute("userid")!=null && ((String)session.getAttribute("kind")).equals("cus")) {
				mnv.addObject("moreorder",springDao.findOrderAll(id));
				mnv.setViewName("moreorder");
			}
			else {
				mnv.setViewName("mypage");
			}
			return mnv;
		}
		
		//관리자 페이지 이동 2022-02-07
		@RequestMapping("/adminpage.pj")
		public ModelAndView admin(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			if(!session.getAttribute("kind").equals("adm")) {
				mnv.setViewName("main");
			}
			else {
				mnv.setViewName("adminpage");
				mnv.addObject("wList", springDao.findWaiting());
			}
			return mnv;
		}
		
		//공지사항 2022-02-04
		@RequestMapping("/notice.pj")
		public ModelAndView notice(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			mnv.setViewName("notice");
			mnv.addObject("notice", springDao.findNotice());
			String userid = (String)session.getAttribute("userid");
			System.out.println(userid);
			if(userid!=null) {
				mnv.addObject("userid",userid);
			}
			else {
				mnv.addObject("userid","none");
			}
			return mnv;
		}
		
		//공지사항 세부 사항 2022-02-04
		@RequestMapping("/nDetail.pj")
		public ModelAndView nDetail(@RequestParam("pnum")int pnum) throws Exception{
			ModelAndView mnv = new ModelAndView();
			mnv.setViewName("nDetail");
			mnv.addObject("details",springDao.findNDetail(pnum));
			return mnv;
		}
		
		// 공지를 작성할 수 있는 뷰 2022-02-04
		@RequestMapping("/writeNotice.pj")
		public ModelAndView write(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			String kind = (String)session.getAttribute("kind");
			if(kind.equals("adm")) {
				mnv.setViewName("writeNotice");
			}
			else {
				mnv.setViewName("notice");
			}
			return mnv;
		}
	
		/* 공동구매 생성 2022-02-23*/
		@RequestMapping("/group.pj")
		public ModelAndView group(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			mnv.setViewName("group");
			mnv.addObject("userid", (String)session.getAttribute("userid"));
			return mnv;
		}
		
		@RequestMapping("/groupList.pj")
		public ModelAndView groutlist(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			mnv.setViewName("groupList");
			return mnv;
		}
	
		
		
		//======================================= 기능 수행 redirect =======================================
		//사용자 등록
		// 소비자  2022-02-03
		@RequestMapping("/cusaccount.pj")
		public String cusaccount(final @ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(session.getAttribute("userid")==null) {
				springDao.register(vo, "customer");
				return "redirect:login.pj";
			}
			
			return "redirect:main.pj";
		}
		
		// 주문확정 수행 2022-02-08
		@RequestMapping("/confirmOrder.pj")
		public String confirmOrder(@RequestParam("odnum") Integer odnum, HttpSession session) throws Exception{
			if(session.getAttribute("userid")!=null && odnum!=null) {
				springDao.confirmOrder(odnum);
				return "redirect:mypage.pj";
			}
			
			return "redirect:main.pj";
		}
		
		//판매자  2022-02-03
		// 판매자가 등록하면, 안내 페이지가 뜨도록 변경 2022-02-07
		@RequestMapping("/selaccount.pj")
		public String selaccount(final @ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(session.getAttribute("userid")==null) {
				springDao.register(vo, "seller");
				return "redirect:notification.pj";
			}
			return "redirect:main.pj";
		}
		
		//판매자 승인 2022-02-07
		@RequestMapping("/res.pj")
		public String res(@RequestParam("res") char res, @RequestParam("selid") String selid, HttpSession session) throws Exception{
			if(((String)session.getAttribute("userid")).equals("admin")) {
				springDao.valid(res, selid);
				return "redirect:adminpage.pj";
			}
			else if(res==0) {
				return "redirect:mypage.pj";
			}
			return "redirect:mypage.pj";
		}
		
		// 품절 선택 2022-02-09(-> count를 0으로 update)
		@RequestMapping("/soldout.pj")
		public String soldout(@RequestParam("pid") Integer pid, HttpSession session) throws Exception{
			
			System.out.println( "pid : " + pid );
			System.out.println( (String)session.getAttribute("kind"));
			
			if(session.getAttribute("userid")!=null && ((String)session.getAttribute("kind")).equals("sel")) {
				
				System.out.println( "sold1" );
				springDao.requestSoldout(pid);
				return "redirect:mypage.pj";
			}
			else if(pid==null) {
				System.out.println( "sold2" );
				return "redirect:mypage.pj";
			}
			System.out.println( "sold3" );
			return "redirect:mypage.pj";
		}
		
		//로그인 기능 수행
		// 사용자 로그인  2022-02-03
		// 로그인 한번에 할 수 있도록 수정 cusLogin -> Login 2022-02-07
		@RequestMapping("/plogin.pj")
		public String Login(@ModelAttribute SpringVO vo, @RequestParam("kind") String kind, HttpSession session) throws Exception{
			session.setAttribute("kind", kind);
			boolean res = false;
			String userid = null;
			System.out.println(vo.getSelid());
			if(kind.equals("cus")) {
				res = springDao.login(vo, "cus");
				userid = vo.getCusid();
			}else if(kind.equals("sel")) {
				res = springDao.login(vo, "sel");
				userid = vo.getSelid();
			}
		
			if(res) {
				if(userid.equals("admin")) {
					session.setAttribute("kind", "adm");
					session.setAttribute("userid", userid);
					return "redirect:adminpage.pj";
				}
				else {
					session.setAttribute("userid", userid);
					return "redirect:main.pj";
				}	
			}
			else {
				return "redirect:login.pj?e_code=fail_to_login";
			}
		}
		
		//아이디 비밀번호 찾기 - 수정완료 -
		@RequestMapping("/findIdPw.pj") 
		public String requestFind(@ModelAttribute SpringVO vo, @RequestParam("kind") String kind, HttpSession session) throws Exception{
			if(session.getAttribute("userid")!=null) {
				return "redirect:main.pj";
			}
				
			if(vo == null) {
				return "redirect:find.pj";
			}
			
			if(vo.getCusname()!=null) {vo.setCusname(Util.change(vo.getCusname()));}
			if(vo.getRepname()!=null) {vo.setRepname(Util.change(vo.getRepname()));}
			if(vo.getSelname()!=null) {vo.setSelname(Util.change(vo.getSelname()));}
				
			String res = springDao.requestFind(kind, vo);
			if(res!=null) {
				session.setAttribute("result", res);
			}
			else {
				session.setAttribute("result", "none");
			}
			session.setAttribute("IdPw", kind);
			
			return "redirect:findResult.pj";
		}

		//전체 로그 아웃 2022-02-04
		@RequestMapping("/logout.pj")
		public String logout(HttpSession session) throws Exception{
			if(session.getAttribute("userid")==null) {
				return "redirect:main.pj";
			}
			session.removeAttribute("userid");
			session.removeAttribute("kind");
			return "redirect:main.pj";
		}
		
		//공지 등록 2022-02-04
		@RequestMapping("/postN.pj")
		public String postN(@ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(!((String)session.getAttribute("userid")).equals("admin")) {

				return "redirect:notice.pj";
			}
			else if(vo==null) {
				return "redirect:mypage.pj";
			}
			springDao.addNotice(vo);
			return "redirect:notice.pj";
		}
		
		//마이페이지 수정(구매자) 2022-02-04
		@RequestMapping("/modifyCus.pj")
		public String modifyCus(@ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(!((String)session.getAttribute("kind")).equals("sel")) {
				return "redirect:main.pj";
			}
			else if(vo==null) {
				return "redirect:main.pj";
			}
			springDao.modify(vo, "cus");
			return "redirect:mypage.pj";
		}
		
		// 리뷰를 작성하는 메소드
		@RequestMapping("/writeRev.pj")
		public String writeRev(@ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(session.getAttribute("userid")==null) {
				return "redirect:main.pj";
			}
			
			if(vo==null) {
				return "redirect:mypage.pj";
			}
			String id = (String)session.getAttribute("userid");
			springDao.uploadRev(vo,id);

			return "redirect:mypage.pj";
		}
		
		// 리뷰 답변을 작성하는 메소드
		@RequestMapping("/ansRev.pj")
		public String ansRev(@ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(((String)session.getAttribute("kind")).equals("sel")) {
				return "redirect:main.pj";
			}
			
			if(vo==null) {
				return "redirect:mypage.pj";
			}
			springDao.ansRev(vo);
			return "redirect:mypage.pj";
		}
		
		//마이페이지 수정(판매자) 2022-02-06
		@RequestMapping("/modifySel.pj")
		public String modifySel(@ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(!((String)session.getAttribute("kind")).equals("sel")) {
				return "redirect:main.pj";
			}
			
			if(vo==null) {
				return "redirect:mypage.pj";
			}
			springDao.modify(vo, "sel");
			return "redirect:mypage.pj";
		}
		
		//QnA 답변 등록하기 2022-02-08
		@RequestMapping("/answer.pj")
		public String answer(@ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(!((String)session.getAttribute("kind")).equals("seller")) {
				return "redirect:main.pj";
			}
			
			if(vo==null) {
				return "redirect:mypage.pj";
			}
			springDao.answer(vo);
			
			return "redirect:mypage.pj";
		}
		
		//관리자 비밀번호 변경 2022-02-06
		@RequestMapping("/chpw.pj")
		public String chPassWord(@RequestParam("apw") String pw, HttpSession session) throws Exception{
			if(session.getAttribute("userid")==null && ((String)session.getAttribute("kind")).equals("adm")) {
				return "redirect:main.pj";
			}
			
			if(pw==null) {
				return "redirect:adminpage.pj";
			}
			springDao.chpw(pw);
			
			return "redirect:adminpage.pj";
		}
	
}
