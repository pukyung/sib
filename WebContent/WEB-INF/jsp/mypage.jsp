<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/ju/mypage.css" rel="stylesheet" type="text/css"/>
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<script>
function drawStar(num){
	  let target = document.getElementById(num+"drag");
	  let len = target.value * 20;
	  document.getElementById(num+"rate").style.width = len+'%';
	  document.getElementById(num+"lab").innerText = '평점 : '+len / 20;
}

function show(id){
    let target = document.getElementById(id);
    let btn = document.getElementById(id+'btn');
    if(btn.value=='리뷰 남기기'){
      target.style.display = '';
      btn.value = '취소';
    }
    else if(btn.value=='취소'){
      target.style.display = 'none';
      btn.value = '리뷰 남기기';
    }
  }
     
  window.onload = function() {
		let revs = document.getElementsByClassName("reviews");
	      for(let i=0;i<revs.length;i++){
	        revs[i].style.display = 'none';
	      }
	      
	}
	
	function loginStatus(kind){
		let login = document.getElementById("login");
		let logout = document.getElementById("logout");
		let mypage = document.getElementById("mypage");
		let cart = document.getElementById("cart");
		let register = document.getElementById("register");
		
		if(kind==''){
			login.style.display = "inline-block";
			logout.style.display = "none";
			mypage.style.display = "none";
			cart.style.display="none";
			register.style.display="inline-block";
		} else if( kind == "cus" ) {
			login.style.display="none";
			logout.style.display="inline-block";
			mypage.style.display="inline-block";
			cart.style.display="inline-block";
			register.style.display="none"
		} else if( kind == "sel" ) {
			login.style.display="none";
			logout.style.display="inline-block";
			mypage.style.display="inline-block";
			cart.style.display="none";
			register.style.display="none";
		} else if( kind == "adm" ) {
			login.style.display="none";
			logout.style.display="inline-block";
			mypage.style.display="inline-block";
			cart.style.display="none";
			register.style.display="none"
		} else{
			login.style.display="none";
			logout.style.display="inline-block";
			mypage.style.display="inline-block";
			register.style.display="none";
		}
	}
	
	function hide(odnum){
		document.getElementById(odnum+'btn').style.display = 'none';
	}

</script>
<title>심이베</title>
</head>
<body class=" hanhobody">
		<header>
			<nav class="nav nava">
				<ul class="navmain hanhoul">
					<div class="df">
						<div class="navlogo tc logo"><a href="/project/main.pj" class="logo hanhoa">심이베</a></div>
						<div class="navlogo tc tf"><a href="/project/main.pj" ><img src="/project/css/logo.png" class="wd15"/></a></div>
						<div class="jc navlogo tc">
							<li class="navlili hanholi" id="register"><a href="/project/register.pj" class="hanhoa">회원가입</a></li>
							<li class="navlili hanholi" id="login"><a href="/project/login.pj" class="hanhoa">로그인</a></li>
							<li class="navlili hanholi" id="logout"><a href="/project/logout.pj" class="hanhoa">로그아웃</a></li>
							<li class="navlili hanholi" id="cart"><a href="/project/cart.pj" class="hanhoa">장바구니</a></li>
							<li class="navlili hanholi" id="mypage"><a href="/project/mypage.pj" class="hanhoa">${ userid } 님</a></li>
							<script>loginStatus("${kind}")</script>
						</div>
					</div>
				</ul>
				<ul class="navmenu tc hanhoul" >
					<div>
					<li class="navli hanholi"><a href="/project/main.pj" class="nava hanhoa">메인</a></li>
					<li class="navli hanholi"><a href="/project/product.pj" class="nava hanhoa">상품</a></li>
					<li class="navli hanholi"><a href="/project/notice.pj" class="nava hanhoa">공지사항</a></li>
					</div>
				</ul>
			</nav>
		</header>
		
	<div class="body" style="margin-bottom:10%;">

<!--  2022-02-04 기본 틀 잡기 (사용자 정보 불러오기, 주문 정보 가져오기 포함) -->
<!-- 페이지 명 -->
<div id="head">
	<h3>${userid}님의MyPage</h3>
</div>
<!-- 소비자 마이 페이지  -->
<div id="body">
    <div id="userInfo">
      <div class="content-title">
        <h3>🙎🏻‍♂️사용자 정보 <input type="button" value="수정하기" id="modify" onclick="location.href='modifyInfo.pj'" /></h3>
      </div>
     <div>
     <!-- 소비자 정보 테이블 -->
     <table>
         <tr>
           <td class="label">이름</td>
           <td class="info">${mypage.cusname}</td>
         <tr>
         <tr>
           <td class="label">id</td>
           <td class="info">${mypage.cusid}</td>
         <tr>
         <tr>
           <td class="label">전화번호</td>
           <td class="info">${mypage.cusphone}</td>
         </tr>
          <tr>
            <td class="label">email</td>
            <td class="info">${mypage.cusmail}</td>
          </tr>
          <tr>
            <td class="label">주소</td>
            <td class="info">${mypage.cusaddr}</td>
          </tr>
       </table>
     </div>
    </div>
    <!-- 배송목록 -->
    <div id="od">
      <!-- 목록 제목 -->
      <div class="content-title">
        <h3>🚛배송목록</h3>
      </div>
      <div class="ovy">
	     <table id="order">
	        <thead>
	          <tr class="th">
	            <td class="inside-th">주문 번호</td>
	            <td class="inside-th">상품</td>
	            <td class="inside-th">수량</td>
	            <td class="inside-th">주문일자</td>
	            <td class="inside-th">총 금액</td>
	            <td class="inside-th">배송지</td>
	            <td>주문확정</td>
	          </tr>
	       </thead>
	       <tbody>
	         <q:forEach items="${ship}" var="t">
	            <tr>
	              <td width="10%" class="inside-td">${t.odnum}</td>
	              <td class="inside-td">${t.pid}</td>
	              <td class="inside-td">${t.count}</td>
	              <td class="inside-td">${t.date}</td>
	              <td class="inside-td">${t.total}</td>
	              <td class="inside-td">${t.addr}</td>
	              <td class="">
	              <form method="post" action="confirmOrder.pj">
	                 <input type="hidden" name="odnum" value="${t.odnum}" /> 
	                 <input type="submit" id="confirm-order" value="주문확정" />
	              </form>
	             </td>
	            </tr>
	          </q:forEach>
	        </tbody>
	      </table>
      </div>
    </div>
  
    <!-- 주문이력   -->
    <div id="" class="ooa">
      <div class="content-title">
        <h3>📦 주문 내역</h3>
      </div>  
     <div class="ovy">
	   <table id="orderall">
	      <colgroup>
	        <col width="10%"/>
	        <col width="30%"/>
	        <col width="15%"/>
	        <col width="25%"/>
	      </colgroup>
	      <thead>
	         <tr class="th"  style="text-align: center;">
	           <td class="inside-td thtd">no</td>
	           <td class="inside-td thtd">상품명</td>
	           <td class="inside-td thtd">구매수량</td>
	           <td class="inside-td thtd">총 금액</td>
	           <td class="thtd">리뷰</td>
	         </tr>
	      </thead>
	      <q:forEach var="t" items="${orderall}">
	        <tr>
	          <td class="inside-td inMid tbtd">${t.odanum}</td>
	          <td class="inside-td inMid tbtd">${t.pname}</td>
	          <td class="inside-td inMid tbtd">${t.count}</td>
	          <td class="inside-td inMid tbtd">${t.total}</td>
			  <td class="inMid tbtd">
	            <input type="button" id="${t.odanum}btn" value="리뷰 남기기"
	            	style=" border: none;border-radius: 40px 40px;background-color: #05c46b;color: white;width: 100px;height: 40px;"
	              onclick="show('${t.odanum}')" />
	           </td>	
	         </tr>
	         <tr id="${t.odanum}" class="reviews">
	            <td class="writeRev" colspan="5">
	              <div class="dir">
	                <h4>리뷰 작성하기</h4>
	              </div>
	              <div class="review-box">
	                <form method="post" action="/project/writeRev.pj">
	                  <!-- 평점 부분은 후에 별점으로 대체할 예정 -->
	                  <!-- 스크롤 뷰도 고려중.. -->
	                  <div class="review-area">
	                    <label for="content" id="${t.odanum}lab">리뷰</label><br/>
	                    	<span class="star">
  								★★★★★
 								<span class="rate" id="${t.odanum}rate">★★★★★</span>
  								<input type="range" class="drag" id="${t.odanum}drag" name="score" oninput="drawStar('${t.odanum}')" value="1" step="0.5" min="0" max="5">
							</span><br/>
	                    <textarea name="content" class="content" placeholder="내용을 입력하세요"></textarea><br/>
	                  </div>
	                  <div class="submit-area">
	                    <input type="submit" class="submit" value="등록하기" />
	                  </div>
	                  <input type="hidden" name="odnum" value="${t.odanum}"/>
	                  <input type="hidden" name="pid" value="${t.pid}" />
	                </form>            
	              </div>
	            </td>
	          </tr>
	        </q:forEach>
      	</table>
      </div>
    </div>
    <!-- 리뷰 목록  -->
    <div id="rv">
      <div class="content-title">
        <h3>📃 작성한 리뷰</h3>
      </div>
      <div class="ovy">
        <table>
          <thead>
            <tr class="th">
              <td class="inside-td">내용</td>
              <td class="inside-td">답변</td>
              <td class="inside-td">상품명</td>
              <td>평점</td>
            </tr>
          </thead>
          <tbody>
            <q:forEach items="${reviews}" var="t">
              <tr>
                <td class="inside-td tbtd">${t.content}</td>
                <td class="inside-td tbtd">${t.answer}</td>
                <td class="inside-td tbtd">${t.pname}</td>
                <td class="tbtd">${t.score}</td>
              </tr>
              <script>hide('${t.odnum}')</script>
            </q:forEach>
          </tbody> 
        </table>     
      </div>
    </div>
  </div>  
</div>

<!-- footer -->  
<footer class="footer">
	<div class="footerdiv">
	  <div class="wd50 fr">
		 <span>부산광역시 남구 용소로 45</span><br/>
		 <span>gksdn1216@naver.com</span><br/>
	  </div>
			
	  <div class="wd50 fr">
		<span>주식회사되고싶은 심이베</span><br/>
		<span>대표자 주상희, 정한호</span><br/>
		<span>Copyright&copy; 주상희, 정한호</span><br/>
	  </div>
	</div>
</footer>  
</body>
</html>