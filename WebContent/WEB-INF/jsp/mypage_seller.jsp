<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/project/css/ju/mypageseller.css" rel="stylesheet" type="text/css"/>
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<script>
    window.onload = function(){
      let leave = document.getElementsByClassName('leave');
      for(let i=0;i<leave.length;i++){
    	  leave[i].style.display = 'none';
      }
    }
    
    function toggle(rnum){
    	let target = document.getElementById(rnum);
    	let btn = document.getElementById(rnum+'btn');
    	
    	if(btn.value=="답변남기기"){
    		target.style.display = '';
    		btn.value="취소";
    	}
    	else{
    		target.style.display = 'none';
    		btn.value="답변남기기";
    	}
    	
    }
    
    function toggle2(qno){
    	let target = document.getElementById(qno);
    	let btn = document.getElementById(qno+'btn');
    	
    	if(btn.value=="답변하기"){
    		target.style.display = '';
    		btn.value="취소";
    	}
    	else{
    		target.style.display = 'none';
    		btn.value="답변남기기";
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
</script>
<title>심이베</title>
</head>
<body>
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
<!--  2022-02-05 판매자 마이페이지 -->		
<div class="body">	
  <!-- 페이지 명 -->
  <div id="head" class="">
	<h3>${userid}님의MyPage</h3>
  </div>
  <!-- 판매자 마이 페이지 -->
  <div id="body">
    <div  id="userInfo">
      <!-- 판매자 정보 -->
      <div class="content-title">
        <h3>👩🏻‍🔧사용자 정보
        <input type="button" value="수정하기" id="modify" onclick="location.href='/project/modifyInfo.pj'"/>
        <input type="button" value="상품등록" id="modify" onclick="location.href='/project/productin.pj'"/>
        </h3>
      </div>
      <!-- 판매자 정보 테이블 -->
      <table>
        <tr>
          <td class="label">사용자 이름</td>
          <td class="info">${selpage.selname}</td>
        <tr>
        <tr>
          <td class="label">id</td>
          <td class="info">${selpage.selid}</td>
        <tr>
        <tr>
          <td class="label">담당자 명</td>
          <td class="info">${selpage.repname}</td>
        </tr>
        <tr>
          <td class="label">전화번호</td>
          <td class="info">${selpage.selphone}</td>
        </tr>
        <tr>
          <td class="label">주소</td>
          <td class="info">${selpage.seladdr}</td>
        </tr>	
      </table>
    </div>
    <!-- 판매 이력 -->
    <div id="selllist">
      <div class="content-title">
        <h3>🧾판매 중이에요</h3>
      </div>
      <div class="ovy">
      	<table>
        <thead>
          <tr class="th">
            <td class="inside-th">상품 번호</td>
            <td class="inside-th">상품명</td>
            <td class="inside-th">가격/단위</td>
            <td class="inside-th">출하 일자</td>
            <td class="inside-th">재고</td>
            <td>재고품절</td>			
          </tr>
        </thead>
        <tbody>
          <q:forEach items="${sellList}" var="t">
            <tr id="${t.pid}"  class="topb">
              <td class="inside-td">${t.pid}</td>
              <td class="inside-td">${t.pname}</td>
              <td class="inside-td">${t.price}/<span id="unit">${t.unit}</span></td>
              <td class="inside-td">${t.shipment}</td>
              <td class="inside-td">${t.pcount}</td>
              <td><a href="/project/soldout.pj?pid=${t.pid}"><input type="button" class="soldout" value="품절"/></a></td>				
            </tr>
          </q:forEach>
        </tbody> 
      </table>
      </div>
    </div>
    <!-- 상품 리뷰 -->
    <div id="revlist">
      <div class="content-title">
        <h3>🌠답변을 기다리는 리뷰가 있어요</h3>
      </div>
      <div class="ovy">
      <table>
        <thead>
          <tr class="th">
            <td class="inside-th">리뷰번호</td>
            <td class="inside-th">내용</td>
            <td class="inside-th">평점</td>
            <td class="inside-th">상품 번호</td>
            <td class="inside-th">상품명</td>
            <td class="inside-th">구매자 아이디</td>
            <td>답변남기기</td>
          </tr>
        </thead>
        <tbody>
          <q:forEach items="${reviews}" var="t">
            <tr class="topb">
              <td class="inside-td">${t.rnum}</td>
              <td class="inside-td">${t.content}</td>
              <td class="inside-td">${t.score}</td>
              <td class="inside-td">${t.pid}</td>
              <td class="inside-td">${t.pname}</td>
              <td class="inside-td">${t.cusid}</td>
              <td><input type="button" id="${t.rnum}btn" class="btns" value="답변남기기" onclick="toggle('${t.rnum}')"/></td>
            </tr>
            <tr class="leave" id="${t.rnum}">
              <td class="writeRev"  colspan="6">
                <div class="dir">
                  <h4>답변 남기기</h4>
                </div>
                <div class="ansbox">
                  <form method="get" action="ansRev.pj">
                    <div class="answer-area">
                      <label for="content">답변</label><br/>
                      <textarea placeholder="내용을 입력하세요" class="answer" name="answer" rows="5" cols="33"></textarea>
                    </div>
                    <input type="submit" class="btn" value="등록하기"/>
                    <input type="hidden" name="rnum" value="${t.rnum}">
                  </form>
                </div>
              </td>
            </tr>
          </q:forEach>
        </tbody>
      </table>
      </div>
    </div>
    <!-- 상품 질문 -->
    <div id="qnalist">
      <div class="content-title">
        <h3>👐🏻QnA</h3>
      </div>
      <div class="ovy">
      	<table>
        <thead>
          <tr>	
            <td class="inside-th">질문번호</td>
            <td class="inside-th">구매자id</td>
            <td class="inside-th">상품번호</td>
            <td class="inside-th">제목</td>
            <td class="inside-th">내용</td>
            <td class="inside-th">등록일</td>
            <td>답변등록</td>
          </tr>
        </thead>
        <q:forEach items="${questions}" var="t">
          <tr>
            <td class="inside-td">${t.qno}</td>
            <td class="inside-td">${t.cusid}</td>
            <td class="inside-td">${t.pid}</td>
            <td class="inside-td">${t.title}</td>
            <td class="inside-td">${t.content}</td>
            <td class="inside-td">${t.date}</td>
            <td><input type="button" id="${t.qno}btn" class="btns" value="답변하기" onclick="toggle2('${t.qno}')"/></td><!--toggle(${t.qno})-->	
          </tr>
          <tr id='${t.qno}'>
            <td colspan="6">
              <div class="writeAns">
                <div class="dir">
                  <h4>답변 남기기</h4>
                </div>
                <form method="post" action="answer.pj">
                  <textarea class="answer"  name="answer" rows="5" cols="33"></textarea>
                  <input type="hidden" id="qno" name="qno" value=0/>
                  <input type="submit" id="ansbtn" value="등록하기"/>
                </form>
              </div>
            </td>
          </tr>
        </q:forEach>
      </table>
      </div>
    </div>
  </div>
  <div>
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
  </div>
  </body>
</html>