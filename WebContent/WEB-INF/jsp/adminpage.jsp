<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- css -->
<link href="/project/css/ju/adminpage.css" rel="stylesheet" type="text/css"/>
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<!-- js -->
<script>
window.onload = function(){
    let chpw = document.getElementById("chpw");
    let valid = document.getElementById("valid");
    let btn_area = document.getElementById("btn-area");
    let chform = document.getElementById("chform");
    let waiting = document.getElementById("waiting");

    chform.style.display = 'none';
    waiting.style.display = 'none';

    chpw.onclick = function(){
      chform.style.display='block';
    }

    valid.onclick = function(){
      waiting.style.display='';
      chform.style.display='none';
      btn_area.style.display='none';
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
<!-- 페이지 -->
<div class="body">
  <!-- 페이지 제목  -->
  <div id="content-title">
    <h3>관리자 페이지</h3>
  </div>
  <!-- 버튼 영역  -->
  <div id="btn-area">
    <div id="btns">
      <input type="button" value="비밀번호 변경" id="chpw"/>
      <input type="button" value="판매자 승인" id="valid" onclick="toggle()"/>
      <input type="button" value="공자사항 등록" id="notice" onclick="location.href='notice.pj'"/>
    </div>
    <!-- 관리자 비밀번호 변경 영역 -->
    <form method="post" id="chform" action="/project/chpw.pj">
      <input type="password" name="apw" id="password" placeholder="비밀번호"/>
      <input type="button" style="opacity: 0;" id="temp" value="비밀번호 확인"/><br/>
      <input type="password" id="valid-pw" placeholder="비밀번호 확인"/>
      <input type="button" id="vbtn" value="비밀번호 확인"/><br/>
      <input type="submit" value="변경완료" id="compch"/>
    </form>
  </div>
  <!-- 승인 대기 목록  -->
  <div id="waiting">
    <h4>승인대기 목록</h4>
    <div id="listall">
      <table id="list">
        <colgroup>
          <col width="10%"/>
          <col width="10%"/>
          <col width="10%"/>
          <col width="20%"/>
          <col/>
          <col width="10%"/>
          <col width="10%"/>
        </colgroup>
        <thead>
          <tr>
            <td class="rightb">판매자id</td>
            <td class="rightb">상호명</td>
            <td class="rightb">등록번호</td>
            <td class="rightb">전화번호</td>
            <td class="rightb">주소</td>
            <td class="rightb">담당자명</td>
            <td>승인</td>
          </tr>
        </thead>
        <tbody>
          <q:forEach items="${wList}" var="t">
            <tr>
              <td class="rightb">${t.selid}</td>
              <td class="rightb">${t.selname}</td>
              <td class="rightb">${t.selnum}</td>
              <td class="rightb">${t.selphone}</td>
              <td class="rightb">${t.seladdr}</td>
              <td class="rightb">${t.repname}</td>
              <td>
                <form method="post" action="/project/res.pj">
                  <input type="submit" class="admin_btn" name="res" value="o"/>
                  <input type="submit" class="admin_btn"  name="res" value="x"/>
                  <input type="hidden" name="selid" value="${t.selid}"/>
                </form>
              </td>
            </tr>
          </q:forEach>
        </tbody>
      </table>
    </div>
  </div>
  </div>
  <!-- 푸터 -->
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