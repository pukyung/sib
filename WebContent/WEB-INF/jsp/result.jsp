<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/project/css/ju/result.css" rel="stylesheet" type="text/css"/>
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<script>	
	function show(id, res){
		let what = document.getElementById('what');
		let fail = document.getElementById('fail');
		
		if(id.indexOf('id')!=-1){
			what.innerText = '아이디';
		}
		else if(id.indexOf('pw')!=-1){
			what.innerText='비밀번호';
		}
		
		if(res!=null){
			fail.style.display = 'none';
		}
		else{
			fail.style.display = 'block';
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
	
<div class="dv">
  <!-- 결과가 있을 때 -->
  <div id="result">
		<h5>
			찾으시는 <span id="what"></span>는 다음과 같습니다.
		</h5>
		<p id="res">${result}</p>
		<input type="button" id="login" value="로그인하기" onclick="location.href='/project/login.pj'">
		<input id="again" type="button" value="찾기" onclick="location.href='/project/findMyIdPw.pj'">
	</div>
	<!-- 결과가 없을 때 -->
	<div id="fail">
		<h5>찾으시는<span id="f"></span>가 존재하지 않습니다.</h5>
		<input id="find" type="button" value="찾기" onclick="location.href='/project/findMyIdPw.pj'">
	</div>
</div>
	
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