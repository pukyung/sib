package pj;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.eclipse.jdt.internal.compiler.codegen.StackMapFrameCodeStream;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import pj.SpringVO;

public class SpringDAO_Im implements SpringDAO {

	private JdbcTemplate jdbcTemplate = null;
	public JdbcTemplate getJdbcTemplate() { return jdbcTemplate; }
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) { this.jdbcTemplate = jdbcTemplate; }

	
	// productAll ----------------------------------------------------------
	// 상품 id에 해당하는 image_T의 image를 갖고 오기 위해 jdbcTemplate.query 두번 실행
	@Override
	public List<SpringVO> productAll(SpringVO vo) throws Exception {

		PreparedStatementSetter pss = null;
		
		String sql = null;
		List<SpringVO> ls = null;
		
		pss = new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement stmt) throws SQLException {

				stmt.setInt( 1, Integer.parseInt( vo.getOption() ) );
			}
		};
		
		// image_T에서 image 가져오기
		RowMapper<SpringVO> rm2 = new RowMapper<SpringVO>() {
			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {
				
				SpringVO vo = new SpringVO();
				vo.setImage( rs.getString( "image" ) );
				return vo;
			}
		};

		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {
			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {
				
				SpringVO vo = new SpringVO();
				vo.setPid( rs.getInt( "pid" ) );
				vo.setPname( rs.getString( "pname" ) );
				vo.setPorigin( rs.getString( "porigin" ) );
				vo.setSelid( rs.getString( "selid" ) );
				vo.setPrice( rs.getInt( "price" ) );
				vo.setOrganic( rs.getInt( "organic" ) );
				vo.setShipment( rs.getString( "shipment" ) );
				vo.setType( rs.getInt( "type" ) );
				vo.setUnit( rs.getString( "unit" ) );
				vo.setCount( rs.getInt( "count" ) );
				
				List<SpringVO> test = jdbcTemplate.query( "select * from image_T where pid=?", rm2, vo.getPid() );
				
				vo.setImage( test.get(0).getImage() );
				return vo;
			}
		};
		
		if( vo.getSearch() == null || vo.getSearch().equals("reset") || vo.getSearch().equals( "" ) ) {
			if( vo.getOption() == null || vo.getOption().equals( "all" ) ) {

				sql = "select * from products_T";
				ls = jdbcTemplate.query( sql, rm );
				
			} else {
				sql = "select * from products_T where type=?";
				ls = jdbcTemplate.query( sql, pss, rm );
			}		
		} else {
			ls = jdbcTemplate.query( "select * from products_T where pname like ?", rm, "%"+Util.change(vo.getSearch())+"%" );
		}
				return ls;
	}
	
	// productrank
	@Override
	public List<SpringVO> productrank() throws Exception {
		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				vo.setImage( rs.getString( "image" ) );
				return vo;
			}
		};
		
		RowMapper<SpringVO> rm2 = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				
				if( rs.getInt( "count" ) > 0 ) {

					vo.setPid( rs.getInt( "pid" ) );
					vo.setPname( rs.getString( "pname" ) );
					vo.setPorigin( rs.getString( "porigin" ) );
					vo.setSelid( rs.getString( "selid" ) );
					vo.setPrice( rs.getInt( "price" ) );
					vo.setOrganic( rs.getInt( "organic" ) );
					vo.setShipment( rs.getString( "shipment" ) );
					vo.setType( rs.getInt( "type" ) );
					vo.setUnit( rs.getString( "unit" ) );
					vo.setCount( rs.getInt( "count" ) );
					List<SpringVO> test = jdbcTemplate.query( "select * from image_T where pid=?", rm, rs.getInt( "pid" ) );	
					vo.setImage( test.get(0).getImage() );
				}
				
				return vo;
			}
		};
		
		RowMapper<SpringVO> rm3 = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = jdbcTemplate.queryForObject( "select * from products_T where pid=?", rm2, rs.getInt( "pid" ) );
								
				return vo;
			}
		};
		
		List<SpringVO> ls = jdbcTemplate.query( "select pid from orderall_T group by pid order by count(*) desc", rm3 );
		
		return ls;
	}
	
	// insertproduct ----------------------------------------------------------
	@Override
	public void insertproduct( SpringVO vo, String id, List<MultipartFile> iimage ) throws Exception {
				
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				vo.setPid( rs.getInt( "pid" ) );
				return vo;
			}
		};
		
		jdbcTemplate.update( "insert into products_T values( default, ?, ?, ?, ?, ?, ?, ?, ?, ? )", Util.change(vo.getPname()), Util.change(vo.getPorigin()), id, vo.getPrice(), vo.getOrganic(), vo.getShipment(), vo.getType(), vo.getUnit(), vo.getCount() );
		
		SpringVO vo2 = jdbcTemplate.queryForObject( "select max(pid) as pid from products_T", rm );
		
		for( MultipartFile t : iimage ) {
			
			String src = Util.upload() + t.getOriginalFilename();
			
			// 파일 업로드
			InputStream in = t.getInputStream();
			OutputStream out = new FileOutputStream( src );
			
			int len = 0;
			byte[] buf = new byte[1024*8];
			while( ( len = in.read( buf ) ) != -1 ) {
				out.write( buf, 0, len );
			}
			out.close();
			in.close();
			
			jdbcTemplate.update( "insert into image_T values( default, ?, ? )", vo2.getPid(), src );
		}
	}
	
	// detail ----------------------------------------------------------
	@Override
	public SpringVO detail( SpringVO vo ) throws Exception {
		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {
				
				SpringVO vo = new SpringVO();
				
				vo.setPid( rs.getInt( "pid" ) );
				vo.setOrganic( rs.getInt( "organic" ) );
				
				SimpleDateFormat fDay = new SimpleDateFormat("yyyy-MM-dd");
				vo.setDate(fDay.format(rs.getDate("shipment")));
				vo.setPname( rs.getString( "pname" ) );
				vo.setPrice( rs.getInt( "price" ) );
				vo.setUnit( rs.getString( "unit" ) );
				vo.setCount( rs.getInt( "count" ) );
				vo.setPorigin( rs.getString( "porigin" ) );
				
				return vo;
			}
		};
		SpringVO ls = jdbcTemplate.queryForObject( "select * from products_T where pid=?", rm, vo.getPid() );
		
		return ls;
	}
		
	
	// review ----------------------------------------------------------
	@Override
	public List<SpringVO> review( SpringVO vo ) throws Exception {
		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				
				vo.setCusid( rs.getString( "cusid" ) );
				vo.setContent( rs.getString( "content" ) );
				vo.setAnswer( rs.getString( "answer" ) );
				vo.setScore( rs.getDouble( "score" ) );
				//vo.setImage( rs.getString( "image" ) );
				
				return vo;
			}
		};
		
		List<SpringVO> ls = jdbcTemplate.query( "select * from review_T where pid=?", rm, vo.getPid() );

		return ls;
	}
	
	// QnA ----------------------------------------------------------
	@Override
	public List<SpringVO> qna( SpringVO vo ) throws Exception {
		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				
				vo.setQno( rs.getInt( "qno" ) );
				vo.setCusid( rs.getString( "cusid" ) );
				SimpleDateFormat fDay = new SimpleDateFormat("yyyy-MM-dd");
				vo.setTitle( rs.getString( "title" ) );
				vo.setContent( rs.getString( "content" ) );
				vo.setAnswer( rs.getString( "answer" ) );
				vo.setDate(fDay.format(rs.getDate("date")));
				
				return vo;
			}
		};

		List<SpringVO> ls = jdbcTemplate.query( "select * from qna_T where pid=? order by qno desc", rm, vo.getPid() );
		
		return ls;
	}
	
	
	//image ----------------------------------------------------------
	@Override
	public List<SpringVO> image( SpringVO vo ) throws Exception {
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {
				
				SpringVO vo = new SpringVO();
				
				vo.setImage( rs.getString( "image" ) );
				
				return vo;
			}
		};
		List<SpringVO> ls = jdbcTemplate.query( "select * from image_T where pid=?", rm, vo.getPid() );
		
		return ls;
	}
	
	// cart ----------------------------------------------------------
	@Override
	public List<SpringVO> cart( SpringVO vo, String id ) throws Exception {

		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {
			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {
				
				SpringVO vo = new SpringVO();
				vo.setPname( rs.getString( "pname" ) );
				return vo;
			}
		};
		
		RowMapper<SpringVO> rm2 = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				vo.setCnum( rs.getInt( "cnum" ));
				vo.setCount( rs.getInt( "count" ) );
				vo.setTotal( rs.getInt( "total" ) );
				
				SpringVO test = jdbcTemplate.queryForObject( "select pname from products_T where pid=" + rs.getInt( "pid" ) , rm );
				vo.setPname( test.getPname() );
				
				return vo;
			}
		};
		
		List<SpringVO> ls = jdbcTemplate.query( "select * from cart_T where cusid=?", rm2, id );
		
		return ls;
	}
	
	// insertcart ----------------------------------------------------------
	// cart_T에 값 넣기
	@Override
	public String insertcart(SpringVO vo, String id) throws Exception {
		
		PreparedStatementSetter pss = null;
		
		int a = vo.getPrice() * Integer.parseInt( vo.getOption() );
		
		String sql = "insert into cart_T values( default, ?, ?, ?, ? )";
		
		pss = new PreparedStatementSetter() {

			@Override
			public void setValues(PreparedStatement stmt) throws SQLException {

				stmt.setString( 1, id );
				stmt.setInt( 2, Integer.parseInt( vo.getPpid() ) );
				stmt.setInt( 3, Integer.parseInt( vo.getOption() ) );
				stmt.setInt( 4, a );
			}
		};
		
		int check = jdbcTemplate.update( sql, pss );
		
		return "redirect:/cart.pj";
	}
	
	// deletecart ----------------------------------------------------------
	@Override
	public void deletecart( SpringVO vo, String id ) throws Exception {
		
		int check = jdbcTemplate.update( "delete from cart_T where cnum=?", vo.getCnum() );
		
	}
	
	
	// ordercheck ----------------------------------------------------------
	// 상세주문페이지로 값 넘기기
	@Override
	public List<SpringVO> ordercheck(SpringVO vo, String id, @RequestParam List<String> cartcount) throws Exception {
		
		List<SpringVO> ls = new ArrayList<SpringVO>();
		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO> () {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				
				vo.setPname( rs.getString( "pname" ) );
				vo.setPrice( rs.getInt( "price" ) );
				vo.setUnit( rs.getString( "unit" ) );
				
				return vo;
			}
		};
		
		RowMapper<SpringVO> rm2 = new RowMapper<SpringVO> () {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				
				SpringVO vo2 = jdbcTemplate.queryForObject( "select * from products_T where pid=?", rm, rs.getInt( "pid" ) );


				vo.setPid( rs.getInt( "pid" ) );
				vo.setPname( vo2.getPname());
				vo.setPrice( vo2.getPrice() );
				vo.setCount( rs.getInt( "count" ) );
				vo.setTotal( rs.getInt( "total" ) );
				vo.setOption( "cart" );
				
				return vo;
			}
		};

		// detail 에서 넘어옴
		if( vo.getForcount() == 1 ) {
			
			SpringVO vo2 = new SpringVO();
			vo2.setPid( Integer.parseInt( vo.getPpid() ) );
			vo2.setPname( Util.change(vo.getPname()));
			vo2.setPrice( vo.getPrice() );
			vo2.setCount( Integer.parseInt( vo.getOption() ) );
			vo2.setTotal( vo.getPrice() * Integer.parseInt( vo.getOption() ) );
			vo2.setCnum( 0 );
			vo2.setOption( "detail" );
			
			ls.add( vo2 );
			
		// cart 에서 넘어옴
		} else if( vo.getForcount() == 2 ) {
			
			for( String t : cartcount ) {
				
				SpringVO vo2 = jdbcTemplate.queryForObject( "select * from cart_T where cusid=? and cnum=?", rm2, id, Integer.parseInt( t ) );
				vo2.setCnum( Integer.parseInt( t ) );
				ls.add( vo2 );
			}
		// event에서 넘어옴
		} else if( vo.getForcount() == 3 ) {
			
			SpringVO vo2 = new SpringVO();

			vo2.setEvnum( vo.getEvnum() );
			vo2.setPid( vo.getPid() );
			vo2.setPname( Util.change( vo.getPname() ) );
			vo2.setPrice( vo.getEprice() - 100 );
			vo2.setCount( 1 );
			vo2.setTotal( vo.getEprice() - 100 );
			vo2.setCnum( 0 );
			vo2.setOption( "event" );
			
			ls.add( vo2 );
		}
		
		return ls;
	}
	
	// insertorder ----------------------------------------------------------
	// order_T에 값 넣기
	@Override
	public void insertorder(SpringVO vo, String id, String now ) throws Exception {
		
		jdbcTemplate.update( "insert into order_T values( default, ?, ?, ?, ?, ?, ?, ? )", id, vo.getPid(), vo.getPcount(), now, vo.getTotal(), Util.change(vo.getAddr()), vo.getPhone() );

	}
	
	// ordered ----------------------------------------------------------
	//order_T 값 중 가장 최근에 넣은 값하나를 불러옴
	@Override
	public List<SpringVO> ordered( Integer forcount, String id ) throws Exception {
		
		// pname 가져오는 query
		RowMapper<SpringVO> rm2 = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				vo.setPname( rs.getString( "pname" ) );
				return vo;
			}
		};
	
		// 가장 최근 order내역 가져오는 query
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				List<SpringVO> vo2 = jdbcTemplate.query( "select pname from products_T where pid=?", rm2, rs.getInt( "pid" ) );
				
				vo.setCount( rs.getInt( "count" ) );
				vo.setOdate( rs.getDate( "odate" ) );
				vo.setTotal( rs.getInt( "total" ) );
				vo.setAddr( rs.getString( "addr" ) );
				vo.setPhone( rs.getInt( "phone" ) );
				vo.setPname( vo2.get(0).getPname() );
				vo.setForcount( forcount );
				
				return vo;
			}
		};
		
		List<SpringVO> ls = jdbcTemplate.query( "select * from order_T where cusid=? order by odnum desc", rm, id );	

		return ls;
	}
	
	
	public void test( List<SpringVO> vo ) throws Exception {
		
		System.out.println( "1 : " + vo.get(0).getForcount() );
		System.out.println( "2 : " + vo.get(1).getForcount() );
	}
	
	@Override
	public void insertqna( SpringVO vo, String id ) throws Exception {
		
		jdbcTemplate.update( "insert into qna_T values( default, ?, ?, ?, ? , null, now() )", id, vo.getPid(), Util.change(vo.getTitle()), Util.change(vo.getContent()) );
		
	}

	
	// event_T 목록 가져오기 ----------------------------------------------------------
	@Override
	public List<SpringVO> eventlist() throws Exception {

		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				
				vo.setPname( rs.getString( "pname" ) );
								
				return vo;
			}
		};
		
		RowMapper<SpringVO> rm2 = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {
				
				SpringVO vo = new SpringVO();
				
				SpringVO vo2 = jdbcTemplate.queryForObject( "select * from products_T where pid=?", rm, rs.getInt( "pid" ) );
				
				vo.setPname( vo2.getPname() );
				vo.setEvnum( rs.getInt( "evnum" ) );
				vo.setPid( rs.getInt( "pid" ) );
				vo.setEprice( rs.getInt( "eprice") );
				vo.setDdate( rs.getDate( "date" ) );
				
				return vo;
			}
		};
		
		SimpleDateFormat format1 = new SimpleDateFormat( "yyyy-MM-dd" );
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );
		cal.add( Calendar.MONTH, -1 );
		String now = format1.format(cal.getTime());
		
		List<SpringVO> ls = jdbcTemplate.query( "select * from event_T where date > ?", rm2, now );
		
		return ls;
	}
	
	
	// eventdetail ----------------------------------------------------------
	@Override
	public SpringVO eventdetail( SpringVO vo ) throws Exception {
		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				
				vo.setPname( rs.getString( "pname" ) );
				vo.setPorigin( rs.getString( "porigin" ) );
				vo.setOrganic( rs.getInt( "organic" ) ); 
				SimpleDateFormat fDay = new SimpleDateFormat("yyyy-MM-dd");
				vo.setShipment( fDay.format( rs.getDate("shipment") ) );
				vo.setUnit( rs.getString( "unit" ) );
				
				return vo;
			}
		};
		
		SpringVO vo2  = jdbcTemplate.queryForObject( "select * from products_T where pid=?", rm, vo.getPid() );
		
		vo2.setDate( vo.getDate() );
		vo2.setEvnum( vo.getEvnum() );
		vo2.setPid( vo.getPid() );
		
		return vo2;
	}
	
	
	// event 소비자 참여내역 ----------------------------------------------------------
	public List<SpringVO> eventpart( SpringVO vo ) throws Exception {
		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				
				vo.setCusid( rs.getString( "cusid" ) );
				vo.setEiprice( rs.getInt( "eiprice" ) );
				SimpleDateFormat fDay = new SimpleDateFormat("dd HH:mm");
				vo.setDate( fDay.format( rs.getDate( "date" ) ) );
				
				return vo;
			}
		};
		
		List<SpringVO> ls = jdbcTemplate.query( "select * from eventin_T where evnum=? order by evinum limit 5", rm, vo.getEvnum() );
		
		return ls;
	}
	
	// insert Event ----------------------------------------------------------
	@Override
	public void insertevent( SpringVO vo, String id ) throws Exception {
		
		jdbcTemplate.update( "insert into eventin_T values( default, ?, ?, ?, now() )", vo.getEvnum(), id, vo.getEiprice() );
	}
	
	
	// Event check ----------------------------------------------------------
	public List<SpringVO> eventcheck( SpringVO vo, String id ) throws Exception {
		
		RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {
			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				vo.setEiprice( rs.getInt( "eiprice" ) );
				return vo;
			}
		};
		
		RowMapper<SpringVO> rm2 = new RowMapper<SpringVO>() {
			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();
				vo.setPname( rs.getString( "pname" ) );
				return vo;
			}
		};

		RowMapper<SpringVO> rm3 = new RowMapper<SpringVO>() {

			@Override
			public SpringVO mapRow(ResultSet rs, int arg1) throws SQLException {

				SpringVO vo = new SpringVO();

				SpringVO vo2 = jdbcTemplate.queryForObject( "select * from eventin_T where cusid=? and evnum=?", rm, id, rs.getInt( "evnum" ) );
				SpringVO vo3 = jdbcTemplate.queryForObject( "select * from products_T where pid=?", rm2, rs.getInt( "pid" ) );
				
				vo.setEvnum( rs.getInt( "evnum" ) );
				vo.setPid( rs.getInt( "pid" ) );
				vo.setEprice( rs.getInt( "eprice" ) );
				vo.setEiprice( vo2.getEiprice() );
				vo.setPname( vo3.getPname() );
				
				return vo;
			}
		};
		
		List<SpringVO> ls = jdbcTemplate.query( "select * from event_T where cusid=? and echeck is null", rm3, id );
		
		return ls;
	}
	
	public void eventupdate( SpringVO vo ) throws Exception {
		
		jdbcTemplate.update( "update event_T set echeck=1 where evnum=?", vo.getEvnum() );
	}
	
	// #########################################################################################
	// #########################################################################################
	// #########################################################################################
	
	

	// 사용자 등록 메소드  2022-02-03
		@Override
		public int register(SpringVO vo, String mode) throws Exception {
			PreparedStatementSetter pss = null;
			String sql = null;
			
			if(mode.equals("customer")) {
				System.out.println( "here1" );
				pss = new PreparedStatementSetter() {
					@Override
					public void setValues(PreparedStatement stmt) throws SQLException {
						stmt.setString(1,vo.getCusid());
						stmt.setString(2, vo.getCuspw());
						stmt.setString(3, Util.change(vo.getCusname()));
						stmt.setString(4, Util.change(vo.getCusaddr()));
						stmt.setInt(5,vo.getCusphone());
						stmt.setString(6,vo.getCusmail());
						stmt.setInt(7,vo.getCusresid());
						
					}
				};
				

				System.out.println( "id : " + vo.getCusid() );
				System.out.println( "pw : " + vo.getCuspw() );
				System.out.println( "name : " + Util.change(vo.getCusname() ) );
				System.out.println( "addr : " + Util.change(vo.getCusaddr() ) );
				System.out.println( "phone : " + vo.getCusphone() );
				System.out.println( "email : " + vo.getCusmail() );
				System.out.println( "sid : " + vo.getCusresid() );
				
				sql = "insert into customer_T values (?,?,?,?,?,?,?)";
				
			}else if(mode.equals("seller")) {
				System.out.println( "here2" );
				pss = new PreparedStatementSetter() {
					@Override
					public void setValues(PreparedStatement stmt) throws SQLException {
						// TODO Auto-generated method stub
						stmt.setString(1,vo.getSelid());
						stmt.setString(2, vo.getSelpw());
						stmt.setString(3, Util.change(vo.getSelname()));
						stmt.setInt(4, vo.getSelnum());
						stmt.setInt(5, vo.getSelphone());
						stmt.setString(6, Util.change(vo.getSeladdr()));
						stmt.setString(7, Util.change(vo.getRepname()));
					}
				};
				sql = "insert into check_T values (?,?,?,?,?,?,?,0)";
			}
			
			int uc = jdbcTemplate.update(sql, pss);
			return uc;
		}
		
		// 로그인을 수행하는 메소드 2022-02-03
		// 회원가입 시 sha256 방식으로 비밀번호 암호화/로그인 시 복호화하는 방식 고려하는 중
		// 그렇게 되면, 비밀번호 필드의 길이 64길이로 변경필요 
		// 관리자 로그인 처리 추가 2022-02-04
		@Override
		public boolean login(SpringVO vo, String mode) throws Exception {
			 String sql = null;
			 String pw = null;
			 boolean res = false;
			 if(mode.equals("cus")) {
				 try {
					 sql = "select cuspw from customer_T where cusid = ?";
					 pw = jdbcTemplate.queryForObject(sql,new Object[] {vo.getCusid()}, String.class);
					 if((pw!=null) && (pw.equals(vo.getCuspw()))) {
						 res = true;
					 }
				 }catch(Exception e) {
					 
				 }
			 }
			 else if(mode.equals("sel")) {
				 try {
					 sql = "select selpw from seller_T where selid=?";
					 pw = jdbcTemplate.queryForObject(sql,new Object[] {vo.getSelid()}, String.class);
					 if((pw!=null) && (pw.equals(vo.getSelpw()))) {
						 res = true;
					 }
				 }
				 catch(Exception e) {
					 
				 } 
			 }
			 return res;
		}
		
		// 회원 정보와 현재 주문 상황을 가져오는 페이지  2022-02-04
		// 판매자 회원정보 조회 추가 2022-02-05
		@Override
		public SpringVO findMypage(String userid, String mode) throws Exception {
			String sql = null;
			RowMapper<SpringVO> rm = null;
			
			if(mode.equals("cus")) {
				//회원 정보
				sql = "select * from customer_T where cusid=?";
				 rm = new RowMapper<SpringVO>() {
						@Override
						public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
							SpringVO vo = new SpringVO();
							vo.setCusname(rs.getString("cusname"));
							vo.setCusid(userid);
							vo.setCuspw(rs.getString("cuspw"));
							vo.setCusphone(rs.getInt("cusphone"));
							vo.setCusmail(rs.getString("cusemail"));
							vo.setCusaddr(rs.getString("cusaddr"));
							return vo;
						}
					};
			}
			else if(mode.equals("sel")) {
				sql = "select * from seller_T where selid=?";
				rm = new RowMapper<SpringVO>(){
					@Override
					public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
						SpringVO vo = new SpringVO();
						vo.setSelid(userid);
						vo.setSelpw(rs.getString("selpw"));
						vo.setSelname(rs.getString("selname"));
						vo.setSeladdr(rs.getString("seladdr"));
						vo.setSelphone(rs.getInt("selphone"));
						vo.setRepname(rs.getString("repname"));
						
						return vo;
					}
				};
			}
		
			SpringVO vo = jdbcTemplate.queryForObject(sql, new Object[]{userid}, rm);
			return vo;
		}
		
		// 주문 정보 가져오기  2022-02-04
		// Date 형식으로 하기로 하였으나, 잘 사용되지 않고 deprecated된 메소드가 많음...
		// 따로 시간을 사용할 것이 아니면 사용하지 않는 편
		// 따라서 다시 String형으로 전환
		public List<SpringVO> findMyOrder(String id) throws Exception{
			
			String sql = "select * from order_T where cusid=?";
			List<SpringVO> shipments = null;
			RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {
				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
						SpringVO vo = new SpringVO();
						vo.setOdnum(rs.getInt("odnum"));
						vo.setPid(rs.getInt("pid"));
						vo.setCount(rs.getInt("count"));
						SimpleDateFormat fDay = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
						vo.setDate(fDay.format(rs.getDate("odate")));
						vo.setTotal(rs.getInt("total"));
						vo.setAddr(rs.getString("addr"));
						
						return vo;
				}
			};
			
			if(rm!=null) {
				shipments = jdbcTemplate.query(sql, new Object[] {id}, rm);
			}
		
			return shipments;
		}
		
		//판매자 판매이력 불러오기 2022-02-06
		//품절(count=0)인 경우를 제외한 상품만 불러와 판매자 페이지에서 보여주기 2022-02-08
		public List<SpringVO> findMySell(String userid) throws Exception{
			String sql = "select * from products_T where count>0 and selid=?";
			
			RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {

				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
					SpringVO vo = new SpringVO();
					vo.setPid(rs.getInt("pid"));
					vo.setPname(rs.getString("pname"));
					vo.setPrice(rs.getInt("price"));
					SimpleDateFormat fDay = new SimpleDateFormat("yyyy-MM-dd");
					vo.setShipment(fDay.format(rs.getDate("shipment")));
					vo.setUnit(rs.getString("unit"));
					vo.setPcount(rs.getInt("count"));
					return vo;
				}
			};
			
			List<SpringVO> sellList = jdbcTemplate.query(sql, new Object[] {userid}, rm);
			
			return sellList;
		}
		
		// 모든 공지 사항을 불러오는 메소드 2022-02-04
		@Override
		public List<SpringVO> findNotice() throws Exception {
			RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {
				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
					SpringVO vo = new SpringVO();
					vo.setPnum(rs.getInt("pnum"));
					if(rs.getString("title")!=null) {
						vo.setTitle(rs.getString("title"));
					}
					else {
						vo.setTitle("제목없음");
					}
					vo.setContent(rs.getString("content"));
					SimpleDateFormat fDay = new SimpleDateFormat("yyyy-MM-dd");
					vo.setDate(fDay.format(rs.getDate("date")));
					vo.setImportant(rs.getInt("important"));
					return vo;
				}
			};
			List<SpringVO> notices = jdbcTemplate.query("select * from post_T", rm);
			return notices;
		}
		
		// 공지사항의 세부사항을 가져오는 메소드 2022-02-04
		@Override
		public SpringVO findNDetail(int pnum) throws Exception {
			
			String sql = "select * from post_T where pnum=?";
			RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {
				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
					SpringVO vo = new SpringVO();
					vo.setPnum(pnum);
					vo.setTitle(rs.getString("title"));
					vo.setContent(rs.getString("content"));
					vo.setDate(rs.getString("date"));
					vo.setImportant(rs.getInt("important"));
					return vo;
				}
			};
			
			SpringVO vo = jdbcTemplate.queryForObject(sql, new Object[] {pnum}, rm);
			return vo;
		}
		//관리자만 공지사항 작성 가능 2022-02-04
		// 관리자 테이블 별도로 생성(아이디, 비밀번호, 관리자명)
		// 로그인 부분 수정 필요...?
		@Override
		public int addNotice(SpringVO vo) throws Exception {
			// TODO Auto-generated method stub
			PreparedStatementSetter pss = new PreparedStatementSetter() {
				@Override
				public void setValues(PreparedStatement stmt) throws SQLException {
					stmt.setString(1, Util.change(vo.getTitle()));
					stmt.setString(2, Util.change(vo.getContent()));
					stmt.setInt(3, Integer.parseInt(vo.getOption2()));
					
					System.out.println( "title : " + vo.getTitle() );
					System.out.println( "content : " + vo.getTitle() );
					

					System.out.println( "cctitle : " + Util.change(vo.getTitle() ) );
					System.out.println( "cccontent : " + Util.change(vo.getContent()));
				}
			};
			
			String sql = "insert into post_T values(default,?,?,now(),?)";
			int uc = jdbcTemplate.update( sql, pss );
			return 1;
		}
		
		// 마이페이지 수정 2022-02-04
		@Override
		public int modify(SpringVO vo, String mode) throws Exception {
			String sql = null;
			PreparedStatementSetter pss = null;
			
			if(mode.equals("cus")) {
				sql ="update customer_T set cuspw=?,cusaddr=?,cusphone=?,cusemail=? where cusid=?";
				pss = new PreparedStatementSetter() {
					@Override
					public void setValues(PreparedStatement stmt) throws SQLException {
						stmt.setString(1, vo.getCuspw());
						stmt.setString(2, Util.change(vo.getCusaddr()));
						stmt.setInt(3, vo.getCusphone());
						stmt.setString(4, vo.getCusmail());
						stmt.setString(5, vo.getCusid());
					}	
				};
			}
			else if(mode.equals("sel")) {
				sql ="update seller_T set selpw=?,seladdr=?,selphone=?,repname=? where selid=?";
				pss = new PreparedStatementSetter() {
					@Override
					public void setValues(PreparedStatement stmt) throws SQLException {
						stmt.setString(1, vo.getSelpw());
						stmt.setString(2, Util.change(vo.getSeladdr()));
						stmt.setInt(3, vo.getSelphone());
						stmt.setString(4, Util.change(vo.getRepname()));
						stmt.setString(5, vo.getSelid());
					}	
				};
			}
			
			int uc = jdbcTemplate.update(sql, pss);
			return uc;
		}
		
		//관리자 비밀번호 변경 2022-02-07
		public int chpw(String pw) throws Exception{
			
			PreparedStatementSetter pss = new PreparedStatementSetter() {
				@Override
				public void setValues(PreparedStatement stmt) throws SQLException {
					// TODO Auto-generated method stub
					stmt.setString(1, pw);
				}	
			};
			
			String sql = "update customer_T set cuspw=? where cusid='admin'";
			int uc = jdbcTemplate.update(sql,pss);
			return uc;
		}
		
		//승인 대기 목록
		// 승인대기 목록을 불러오는 메소드 2022-02-07
		@Override
		public List<SpringVO> findWaiting() throws Exception {
			
			String sql = "select * from check_T where valid!=1";
			RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {
				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
					SpringVO vo = new SpringVO();
					vo.setSelid(rs.getString("selid"));
					vo.setSelpw(rs.getString("selpw"));
					vo.setSelname(rs.getString("selname"));
					vo.setSelnum(rs.getInt("selnum"));
					vo.setSelphone(rs.getInt("selphone"));
					vo.setSeladdr(rs.getString("seladdr"));
					vo.setRepname(rs.getString("repname"));
					vo.setValid(rs.getInt("valid"));
					return vo;
				}
			};
			
			List<SpringVO> wList = jdbcTemplate.query(sql,rm);
			return wList;
		}
		
		// 판매자 승인 2022-02-07
		public int valid(char res, String selid) throws Exception{
			
			int uc = 0;
			if(res=='o') {
				String sql = "insert into \r\n" + 
						"seller_T\r\n" + 
						"select\r\n" + 
						"selid, selpw, selname, selnum, selphone, seladdr, repname\r\n" + 
						"from check_T\r\n" + 
						"where\r\n" + 
						"selid=?";
				
				uc = jdbcTemplate.update(sql, new Object[]{selid});
				
				String sql2 = "delete from check_T where selid=?";
				uc += jdbcTemplate.update(sql2, new Object[] {selid});
			}
			else if(res=='x') {
				uc = jdbcTemplate.update("update check_T set valid=1 where selid=?", new Object[] {selid});
			}
			return uc;
		}
		
		// QnA 목록을 불러오는 메소드 2022-02-08
		// 답변을 하기 전에는 Answer이 NULL일 수 밖에 없어 qna_T 테이블의 answer 필드를 not null에서 null로 변경
		// alter table qna_T modify column answer varchar(500);
		@Override
		public List<SpringVO> findQnA(String id) throws Exception {
			
			String sql = "select pid from products_T where selid=?";
			
			//String sql = "select * from qna_T where answer is null and pid = (select pid from products_T where selid=?)";
			
			List<SpringVO> ls = new ArrayList<SpringVO>();
			
			RowMapper<SpringVO> rowMapper = new RowMapper<SpringVO>() {
				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
					SpringVO vo = new SpringVO();
					vo.setQno(rs.getInt("qno"));
					vo.setCusid(rs.getString("cusid"));
					vo.setPid(rs.getInt("pid"));
					vo.setTitle(Util.change(rs.getString("title")));
					vo.setContent(Util.change(rs.getString("content")));
					SimpleDateFormat fDay = new SimpleDateFormat("yyyy-MM-dd");
					vo.setDate(fDay.format(rs.getDate("date")));
					
					ls.add(vo);
					
					return vo;
				}
				
			};
			
			RowMapper<SpringVO> rowMapper2 = new RowMapper<SpringVO>() {

				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {

					jdbcTemplate.query( "select * from qna_T where answer is null and pid=?", rowMapper, rs.getInt("pid") );
					
					return null;
				}
			};
			
			jdbcTemplate.query(sql,rowMapper2, id);
			
			return ls;
		}
		
		// 답변등록하기 2022-02-08
		@Override
		public int answer(SpringVO vo) throws Exception{
			String sql = "update qna_T set answer=? where qno=?";
			PreparedStatementSetter pss = new PreparedStatementSetter() {
				@Override
				public void setValues(PreparedStatement stmt) throws SQLException {
					stmt.setString(1, vo.getAnswer());
					stmt.setInt(2, vo.getQno());
				}
			};
			
			int uc = jdbcTemplate.update(sql, pss);
			
			return uc;
		}
		
		// 주문확정 메소드 2022-02-08
		// order_T date명 -> odate로 변경 2022-02-08
		@Override
		public int confirmOrder(int odnum) throws Exception {
			
			String sql = "select odnum, cusid, pid, count, total, odate from order_T where odnum = ?";
			RowMapper<SpringVO> rm = new RowMapper<SpringVO>() {
				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
					
					SpringVO vo = new SpringVO();
					vo.setOdnum(rs.getInt("odnum"));
					vo.setCusid(rs.getString("cusid"));
					vo.setPid(rs.getInt("pid"));
					vo.setCount(rs.getInt("count"));
					vo.setTotal(rs.getInt("total"));
					vo.setOdate(rs.getDate("odate"));
					return vo;
				}	
			};
			
			SpringVO temp = jdbcTemplate.queryForObject(sql, new Object[]{odnum}, rm);
			
			String sql2 = "insert into orderall_T values (default,?,?,?,?,?,?)";
			PreparedStatementSetter pss = new PreparedStatementSetter() {
				@Override
				public void setValues(PreparedStatement stmt) throws SQLException {
					stmt.setInt(1, temp.getOdnum());
					stmt.setString(2, temp.getCusid());
					stmt.setInt(3, temp.getPid());
					stmt.setInt(4, temp.getCount());
					stmt.setInt(5, temp.getTotal());
					stmt.setDate(6, temp.getOdate());
				}	
			};
			
			int uc = jdbcTemplate.update(sql2, pss);
			
			String sql3 = "delete from order_T where odnum=?";
			uc += jdbcTemplate.update(sql3, new Object[] {odnum});
			
			return uc;
		}
		
		// 총 주문 내역 불러오기 2022-02-08
		public List<SpringVO> findOrderAll(String cusid) throws Exception{
			
			String sql = "select * from orderall_T where cusid=?";
			
			RowMapper<SpringVO> rowMapper = new RowMapper<SpringVO>() {
				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
					SpringVO vo = new SpringVO();
					vo.setOdanum(rs.getInt("odanum"));
					vo.setOdnum(rs.getInt("odnum"));
					vo.setCusid(rs.getString("cusid"));
					vo.setPid(rs.getInt("pid"));
					try {
						vo.setPname(changeToProducts(rs.getInt("pid")));
					} catch (Exception e) {
						
					}
					vo.setCount(rs.getInt("count"));
					vo.setTotal(rs.getInt("total"));
					SimpleDateFormat fDay = new SimpleDateFormat("yyyy-MM-dd");
					vo.setDate(fDay.format(rs.getDate("date")));
					return vo;
				}
			};
			
			List<SpringVO> orderAll = jdbcTemplate.query(sql, new Object[] {cusid}, rowMapper);
			
			return orderAll;
		}
		
		// pid를 상품명으로 바꾸기 2022-02-08
		private String changeToProducts(int pid) throws Exception{
			
			String sql = "select pname from products_T where pid=?";
			String pname = jdbcTemplate.queryForObject(sql, new Object[] {pid}, String.class);
			
			return pname;
		}
		
		// 아이디/비밀번호 찾기 수행 - 수정완료 - 2022-02-09
		@Override
		public String requestFind(String kind, SpringVO vo) throws Exception {
			String sql = null;
			String res = null;
			switch(kind) {
			case "idcp":
				sql = "select cusid from customer_T where cusname=? and cusphone=?";
				try {
					res = jdbcTemplate.queryForObject(sql, new Object[]{vo.getCusname(), vo.getCusphone()}, String.class);
				}catch(Exception e) {
					res = null;
				}
				break;
				
			case "idsp":
				sql = "select selid from seller_T where selname=? and selphone=?";
				try {
					res = jdbcTemplate.queryForObject(sql, new Object[]{vo.getSelname(), vo.getSelphone()}, String.class);
				}
				catch(Exception e) {
					res = null;
				}
				break;
				
			case "idem":
				sql = "select cusid from customer_T where cusname=? and cusemail=?";
				try {
					res = jdbcTemplate.queryForObject(sql, new Object[]{vo.getCusname(),vo.getCusmail()}, String.class);
				}
				catch(Exception e) {
					res = null;
				}
				break;
				
			case "idrp":
				sql = "select selid from customer_T where selname=? and repname=?";
				try {
					res = jdbcTemplate.queryForObject(sql, new Object[]{vo.getSelname(),vo.getRepname()}, String.class);
				}
				catch(Exception e) {
					res = null;
				}
				break;
				
			case "cpw":
				sql = "select cuspw from customer_T where cusid=? and cusname=? and cusphone=? and cusresid=? and cusemail=?";
				try {
					res = jdbcTemplate.queryForObject(sql, new Object[]{vo.getCusid(),vo.getCusname(),vo.getCusphone(),vo.getCusresid(),vo.getCusmail()}, String.class);
				}
				catch(Exception e) {res=null;}
				break;
				
			case "spw":
				sql = "select selpw from seller_T where selid=? and selname=? and selphone=? and selnum=? and repname=?";
				try {
				res = jdbcTemplate.queryForObject(sql, new Object[]{vo.getSelid(),vo.getSelname(),vo.getSelphone(),vo.getSelnum(),vo.getRepname()}, String.class);
				}
				catch(Exception e) {res=null;}
				break;
			}
			
			return res;
		}
		
		//품절 적용 2022-02-08
		@Override
		public int requestSoldout(int pid) throws Exception{
			
			String sql = "update products_T set count=0 where pid=?";
			
			int uc = jdbcTemplate.update(sql, new Object[] {pid});
			
			return uc;
		}
		
		//리뷰 남기기 2022-02-09
		@Override
		public int uploadRev(SpringVO vo, String id) throws Exception {
			
			String sql = "insert into review_T values(default,?,?,?,?,null,?,null)";
			PreparedStatementSetter pss = new PreparedStatementSetter() {
				@Override
				public void setValues(PreparedStatement stmt) throws SQLException {
					stmt.setString(1,id);
					stmt.setInt(2,vo.getPid());
					stmt.setInt(3, vo.getOdnum());
					stmt.setString(4, Util.change(vo.getContent()));
					stmt.setDouble(5, vo.getScore());
				}
			};
			
			int uc = jdbcTemplate.update(sql, pss);
			return uc;
		}
		
		//리뷰를 가져오는 메소드 2022-02-09
		// 수정 2022-02-21
		public List<SpringVO> reviews(String kind, String id) throws Exception{
			String sql = null;
			
			if(kind.equals("cus")) {
				sql = "select * from review_T where cusid=?";
				
			}
			else if(kind.equals("sel")) {
				sql = "select * from review_T where answer is null and pid in (select pid from products_T where selid=?)";
			}
			
			RowMapper<SpringVO> rowMapper = new RowMapper<SpringVO>() {
				@Override
				public SpringVO mapRow(ResultSet rs, int idx) throws SQLException {
					SpringVO vo = new SpringVO();
					vo.setContent(rs.getString("content"));
					vo.setScore(rs.getDouble("score"));
					vo.setCusid(rs.getString("cusid"));
					vo.setAnswer(rs.getString("answer"));
					vo.setOdnum(rs.getInt("odnum"));
					vo.setPid(rs.getInt("pid"));
					vo.setRnum(rs.getInt("rnum"));
					try {
						vo.setPname(changeToProducts(rs.getInt("pid")));
					} catch (Exception e) {
						
					}
					
					return vo;
				}	
			};
			
			return jdbcTemplate.query(sql, new Object[] {id}, rowMapper);
		}
		
		//리뷰 답변을 작성하는 메소드 2022-02-09
		public int ansRev(SpringVO vo) throws Exception{
			String sql = "update review_T set answer=? where rnum=?";
			
			int uc = jdbcTemplate.update(sql, new Object[]{vo.getAnswer(), vo.getRnum()});
			
			return uc;
		}
	
}
