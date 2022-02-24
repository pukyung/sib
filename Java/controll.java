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
	
	
	//���� ������ �̵�
	@RequestMapping("/main.pj")
	public ModelAndView main( HttpSession session) throws Exception{
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("main");
		mnv.addObject( "rank", springDao.productrank() );
		
		return mnv;
	}
	
	// ��ǰ ��ü ������
	@RequestMapping( "/product.pj" )
	public ModelAndView product( @ModelAttribute SpringVO vo ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.setViewName( "product" );
		// ��ǰ ��������
		mnv.addObject( "list", springDao.productAll( vo ) );
		
		return mnv;
	}
	
	// ��ǰ �� ������
	@RequestMapping( "/detail.pj" )
	public ModelAndView detail( @ModelAttribute SpringVO vo ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.setViewName( "detail" );
		// ��ǰ ���� ��������
		mnv.addObject( "info", springDao.detail( vo ) );
		// ��ǰ �̹��� ��������
		mnv.addObject( "img", springDao.image( vo ) );
		// ���� ��������
		mnv.addObject( "review", springDao.review( vo ) );
		// QnA ��������
		mnv.addObject( "qna", springDao.qna( vo ) );

		
		return mnv;
	}
	
	// ��ǰ �߰� ������
	@RequestMapping( "/productin.pj" )
	public ModelAndView productin( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName( "productin" );
		
		return mnv;
	}
	
	// ��ǰ �߰�
	@RequestMapping( "/insertproduct.pj" )
	public String insertproduct( @ModelAttribute SpringVO vo, HttpSession session, @RequestParam(required=false) List<MultipartFile> iimage ) throws Exception {


		springDao.insertproduct( vo, (String)session.getAttribute("userid"), iimage );
		
		return "redirect:product.pj";
	}
	
	// ��ٱ��� ������
	@RequestMapping( "/cart.pj" )
	public ModelAndView cart( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName( "cart" );
		mnv.addObject( "cart", springDao.cart( vo, (String)session.getAttribute( "userid" ) ) );
		return mnv;
	}
	
	// ��ٱ��� �߰� ���
	@RequestMapping( "/insertcart.pj" )
	public String insertcart( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		return springDao.insertcart( vo, (String)session.getAttribute( "userid" ) );
	}
	
	@RequestMapping( "/deletecart.pj" )
	public String deletecart( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		springDao.deletecart( vo, (String)session.getAttribute( "userid" ) );
		
		return "redirect:/cart.pj";
	}
	
	// �ֹ� ������
	@RequestMapping( "/ordercheck.pj" )
	public ModelAndView ordercheck( @ModelAttribute SpringVO vo, HttpSession session, @RequestParam(required=false) List<String> cartcount ) throws Exception {

		ModelAndView mnv = new ModelAndView();
		mnv.setViewName( "order" );
		mnv.addObject( "order", springDao.ordercheck( vo, (String)session.getAttribute("userid"), cartcount ) );
		return mnv;
	}
	
	// order_T �� �� �ֱ�
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
	
	// ���� �ֱ� �ֹ����� ������
	@RequestMapping( "/ordered.pj" )
	public ModelAndView ordered( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {		
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName( "ordered" );
		mnv.addObject( "ordered", springDao.ordered( vo.getForcount(), (String)session.getAttribute( "userid" ) ) );
		
		return mnv;
	}
	
	// QnA �߰�
	@RequestMapping( "/inserqna.pj" )
	public String insertqna( @ModelAttribute SpringVO vo, HttpSession session ) throws Exception {
		
		springDao.insertqna( vo, (String)session.getAttribute("userid") );
		
		return "redirect:/detail.pj?pid=" + vo.getPid();
	}
	
	// Event ����Ʈ ���� ������
	@RequestMapping( "/event.pj" )
	public ModelAndView event( @ModelAttribute SpringVO vo ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		mnv.addObject( "eventlist", springDao.eventlist() );
		
		mnv.setViewName( "event" );
		
		return mnv;
	}
	
	// Event �� ������
	@RequestMapping( "/eventdetail.pj" )
	public ModelAndView evnetdetail( @ModelAttribute SpringVO vo ) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		// Event �� ����
		mnv.addObject( "eventdetail", springDao.eventdetail( vo ) );
		
		// �Һ��� Event ���� ����
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
	
	

	// ����� ����ϴ� �޼ҵ�  2022-02-03
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
		
		//�Ǹ��� ��� ��û �� �̵� ����
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
		
		//�α��� ȭ�� �̵�  2022-02-03  �Һ��� �α��� Ȯ�� ��, jshe1207 & aa134�� Ȯ��
		// ���� : �α��� �� ������ ��, �α��� ȭ�� ���� �Ұ� 2022-02-04
		@RequestMapping("/login.pj")
		public ModelAndView login(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			// �α��� ������ ������ ��, main�������� �̵�
			if(session.getAttribute("userid")!=null) {
				mnv.setViewName("main");
			}
			else {
				mnv.setViewName("login");
			}
			
			return mnv;
		}
		
		// id/��й�ȣ ã�� �� �����/������ ���� ������ 2022-02-08
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
		
		//id/��й�ȣ ã�� ������ 2022-02-08 
		// �����Ϸ� 2022-02-09
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
		
		// ���̵� ��й�ȣ ã�� ��� 2022-02-09
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
		
		//������������ �̵� 2022-02-04
		// ���� �Ϸ�- mypage.pj�� �����ϸ� ������� ��忡 ���� ������������ �Űܰ����� 2022-02-08
		@RequestMapping("/mypage.pj")
		public ModelAndView mypage(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			// �α��� �ÿ��� ���������� ���� ����
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
		
		// ���� - �޼ҵ带 �ϳ��� ��ħ(cus + sel) 2022-02-08
		@RequestMapping("/modifyInfo.pj")
		public ModelAndView moInfo(HttpSession session) throws Exception{
			ModelAndView mnv = new ModelAndView();
			String userid = (String)session.getAttribute("userid");
			// �α��� �ÿ��� ���������� ���� ����
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
		
		//�ֹ����� ������ �̵� 2022-02-10
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
		
		//������ ������ �̵� 2022-02-07
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
		
		//�������� 2022-02-04
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
		
		//�������� ���� ���� 2022-02-04
		@RequestMapping("/nDetail.pj")
		public ModelAndView nDetail(@RequestParam("pnum")int pnum) throws Exception{
			ModelAndView mnv = new ModelAndView();
			mnv.setViewName("nDetail");
			mnv.addObject("details",springDao.findNDetail(pnum));
			return mnv;
		}
		
		// ������ �ۼ��� �� �ִ� �� 2022-02-04
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
	
		/* �������� ���� 2022-02-23*/
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
	
		
		
		//======================================= ��� ���� redirect =======================================
		//����� ���
		// �Һ���  2022-02-03
		@RequestMapping("/cusaccount.pj")
		public String cusaccount(final @ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(session.getAttribute("userid")==null) {
				springDao.register(vo, "customer");
				return "redirect:login.pj";
			}
			
			return "redirect:main.pj";
		}
		
		// �ֹ�Ȯ�� ���� 2022-02-08
		@RequestMapping("/confirmOrder.pj")
		public String confirmOrder(@RequestParam("odnum") Integer odnum, HttpSession session) throws Exception{
			if(session.getAttribute("userid")!=null && odnum!=null) {
				springDao.confirmOrder(odnum);
				return "redirect:mypage.pj";
			}
			
			return "redirect:main.pj";
		}
		
		//�Ǹ���  2022-02-03
		// �Ǹ��ڰ� ����ϸ�, �ȳ� �������� �ߵ��� ���� 2022-02-07
		@RequestMapping("/selaccount.pj")
		public String selaccount(final @ModelAttribute SpringVO vo, HttpSession session) throws Exception{
			if(session.getAttribute("userid")==null) {
				springDao.register(vo, "seller");
				return "redirect:notification.pj";
			}
			return "redirect:main.pj";
		}
		
		//�Ǹ��� ���� 2022-02-07
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
		
		// ǰ�� ���� 2022-02-09(-> count�� 0���� update)
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
		
		//�α��� ��� ����
		// ����� �α���  2022-02-03
		// �α��� �ѹ��� �� �� �ֵ��� ���� cusLogin -> Login 2022-02-07
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
		
		//���̵� ��й�ȣ ã�� - �����Ϸ� -
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

		//��ü �α� �ƿ� 2022-02-04
		@RequestMapping("/logout.pj")
		public String logout(HttpSession session) throws Exception{
			if(session.getAttribute("userid")==null) {
				return "redirect:main.pj";
			}
			session.removeAttribute("userid");
			session.removeAttribute("kind");
			return "redirect:main.pj";
		}
		
		//���� ��� 2022-02-04
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
		
		//���������� ����(������) 2022-02-04
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
		
		// ���並 �ۼ��ϴ� �޼ҵ�
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
		
		// ���� �亯�� �ۼ��ϴ� �޼ҵ�
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
		
		//���������� ����(�Ǹ���) 2022-02-06
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
		
		//QnA �亯 ����ϱ� 2022-02-08
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
		
		//������ ��й�ȣ ���� 2022-02-06
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
