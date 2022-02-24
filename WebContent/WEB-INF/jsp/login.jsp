<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/project/css/ju/login.css" rel="stylesheet" type="text/css"/>
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<script>
    window.onload = function(){
      let cusbtn = document.getElementById('cus-btn');
      let selbtn = document.getElementById('sel-btn');
      let head = document.getElementById('head');
      let cuslog = document.getElementById('cuslog');
      let sellog = document.getElementById('sellog');
      let cusform = document.getElementById( 'cusform' );
      let selform = document.getElementById( 'selform' );
      
      /* 동작 */
      cusbtn.onclick = function(){
        head.style.display='none';
        cuslog.style.display='block';
      }

      selbtn.onclick = function(){
        head.style.display='none';
        sellog.style.display='block';
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
		
<div style="height:900px;">
  <!-- 페이지 제목 -->	
  <div id="title">
    <h2>로그인</h2>
  </div>
  <!-- 소비자/판매자 선택하기 영역 -->  
  <div id="head">
    <input type="radio" name="mode" value="customer" id="cus-btn" checked/>
    <input type="radio" name="mode" value="seller" id="sel-btn"/>
    <label for="cus-btn"><span id="cus-img-edge"></span></label>
    <label for="sel-btn"><span id="sel-img-edge"></span></label>
  </div>
  <!-- 소비자 로그인 영역 -->
  <section id="cuslog">
  	<!-- 수직 가운데 정렬을 위한 div -->
    <div class="helper"></div>
    <!-- 소비자 로그인 폼 -->
    <div id="cusform">
      <form method="post" action="/project/plogin.pj">
        <input type="text" name="cusid" id="cusid" placeholder="아이디"/><br/>
        <input type="password" name="cuspw" id="cuspw" placeholder="비밀번호"/><br/>
        <nav><a href="findMyIdPw.pj">아이디/비밀번호 찾기</a></nav><br/>
        <input type="submit" id="cus-sub" value="구매자 로그인"/>
        <input type="hidden" name="kind" value="cus"/>
      </form>
    </div>
  </section>
  <!-- 판매자 로그인 영역  -->
  <section id="sellog">
  	<!-- 수직 가운데 정렬 -->
    <div class="helper"></div>
    <!-- 판매자 로그인 폼 -->
    <div id="selform">
      <form method="post" action="plogin.pj">
        <input type="text" name="selid" id="selid" placeholder="아이디"/><br/>
        <input type="password" name="selpw" id="selpw" placeholder="비밀번호"/><br/>
        <nav><a href="findMyIdPw.pj">아이디/비밀번호 찾기</a></nav><br/>
        <input type="submit" id="sel-sub" value="판매자 로그인"/>
        <input type="hidden" name="kind" value="sel"/>
      </form>
    </div>
  </section>  
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