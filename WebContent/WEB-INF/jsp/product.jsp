<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
		<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	
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
	
		<!-- Navi -->
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
      
      	<!-- 상품 목록 -->
		<section class="pt3 productsec1 bgc">
			<!-- 상품 검색 -->
			<div class="productsec1">
				<div class="wd100 tc">
				<!-- 상품 Text 검색 -->
					<form method="post" action="/project/product.pj" class="tc productform">
						<input type="hidden" name="option" value=all />
						
						<div id="mainsearch" class="mt5 mainsifm">
							<input id="mainsipt" name="search" type="text" class="mainsipt" autocomplete="off" />
							<input type="submit" class="mainsipb iconfont" value="search"/>
						</div>
					</form>
				</div>
				
				<!-- 상품 Select 검색 -->
				<form method="post" action="/project/product.pj" class="tr wd100 productsel">
					<input type="hidden" name="search" value="reset"/>
					
					<select name="option" class="productse">
						<option value=all>선택</option>
						<option value=1>당근</option>
						<option value=2>배추</option>
						<option value=3>오이</option>
						<option value=4>고추</option>
						<option value=5>감자</option>
						<option value=0>기타</option>
					</select>
					
					<input type="submit" value="done_outline" class="iconfont product-btn"/>
				</form>
			</div>
			
			<div class="productsec1 ht1200px">
				<q:forEach items="${list}" var="t" varStatus="count">
						<q:if test="${ t.count > 0 && t.count < 11 }">
							<a href="/project/detail.pj?pid=${ t.pid }" class="producta">
								<div class="product">
									<img class="wd100" src="/getimage.jsp?file=${ t.image }" />
									
									<div>
										<q:choose>
											<q:when test="${ t.organic eq '0' }">
												<div class="tc">
													<span class="cr">[ 마감임박 ]</span>
													<span class="cl">[ 유기농 ]</span>
													<span><br/>${ t.pname }</span>
												</div>
											</q:when>
											
											<q:when test="${ t.organic ne '0' }">
												<div class="tc">
													<span class="cr">[ 마감임박 ]</span>
													<span><br/>${ t.pname }</span>
												</div>
											</q:when>
										</q:choose>
										
										<br/>
										
										<div class="pr3 fr">
											<span>${ t.price } 원 / ${ t.unit }</span><br/>
										</div>
									</div>
								</div>
							</a>
						</q:if>
						
						<q:if test="${ t.count > 10 }">
							<a href="/project/detail.pj?pid=${ t.pid }" class="producta">
								<div class="product">
									<img class="wd100" src="/project/getimage.jsp?file=${ t.image }" />
									
									<div>
										<q:choose>
											<q:when test="${ t.organic eq '0' }">
												<div class="tc">
													<span class="cl">[ 유기농 ]</span>
													<span><br/>${ t.pname }</span>
												</div>
											</q:when>
											
											<q:when test="${ t.organic ne '0' }">
												<div class="tc">
													<span><br/>${ t.pname }</span>
												</div>
											</q:when>
										</q:choose>
										
										<br/>
										
										<div class="pr3 fr">
											<span>${ t.price } 원 / ${ t.unit }</span><br/>
										</div>
									</div>
								</div>
							</a>
						</q:if>
				</q:forEach>
			</div>
		</section>
		
		<!-- Footer -->
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
