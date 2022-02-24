<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/project/css/ju/modmp.css" rel="stylesheet" type="text/css"/>
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<script>
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
				<div class="navlogo tc logo">
					<a href="/project/main.pj" class="logo hanhoa">심이베</a>
				</div>
				<div class="navlogo tc tf">
					<a href="/project/main.pj">
					<img src="/project/css/logo.png" class="wd15" /></a>
				</div>
				<div class="jc navlogo tc">
					<li class="navlili hanholi" id="register">
						<a href="/project/register.pj" class="hanhoa">회원가입</a>
					</li>
					<li class="navlili hanholi" id="login">
						<a href="/project/login.pj" class="hanhoa">로그인</a>
					</li>
					<li class="navlili hanholi" id="logout">
						<a href="/project/logout.pj" class="hanhoa">로그아웃</a>
					</li>
					<li class="navlili hanholi" id="cart">
						<a href="/project/cart.pj" class="hanhoa">장바구니</a>
					</li>
					<li class="navlili hanholi" id="mypage">
						<a href="/project/mypage.pj" class="hanhoa">${ userid } 님</a>
					</li>
				<script>loginStatus("${kind}")</script>
				</div>
			</div>
		</ul>
		<ul class="navmenu tc hanhoul">
			<div>
				<li class="navli hanholi">
					<a href="/project/main.pj" class="nava hanhoa">메인</a>
				</li>
				<li class="navli hanholi">
					<a href="/project/product.pj" class="nava hanhoa">상품</a>
				</li>
				<li class="navli hanholi">
					<a href="/project/notice.pj" class="nava hanhoa">공지사항</a>
				</li>
			</div>
		</ul>
	</nav>
</header>
	
<!--  2022-02-04 기본 틀 잡기 (정보 수정) -->
<!--  2022-02-05 아이디가 안 넘어가는 현상 수정 -->
<!--  2022-02-09 수정 방식 변경하기 -->
<div class="body">
	<!-- 페이지 제목  -->
	<div id="content-title">
    	<h3>📝수정하기</h3>
  	</div>
  	<!-- 소비자 정보 수정 폼 -->
	<form method="post" action="/project/modifyCus.pj">
		<table>
			<tr>
				<td>사용자 이름</td>
				<td>${mypage.cusname}</td>
			<tr>
			<tr>
				<td>id</td>
				<td>${mypage.cusid}
					<input type="hidden" name="cusid" value="${mypage.cusid}"/>
				</td>
			<tr>
			<tr>
				<td>pw</td>
				<td>
					<input type="text" name="cuspw" value="${mypage.cuspw}" placeholder="${mypage.cuspw}"/>
				</td>
			<tr>
			<tr>
				<td>이메일</td>
				<td>
					<input type="text" name="cusmail" value="${mypage.cusmail}" placeholder="${mypage.cusmail}"/>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					<input type="text" name="cusphone" value="${mypage.cusphone}" placeholder="${mypage.cusphone}"/>
				</td>
			</tr>
			<tr>
				<td>배송지</td>
				<td>
					<input type="text" name="cusaddr" value="${mypage.cusaddr}" placeholder="${mypage.cusaddr}"/>
				</td>
			</tr>
		</table>
		<!-- 변경 결과 버튼 -->
    	<div id="btn-area">
      		<input type="submit" value="변경완료" id="complete" /> 
      		<input type="button" value="변경 취소" id="cancel" onclick="location.href='mypage.pj'" />
    	</div>
	</form>
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