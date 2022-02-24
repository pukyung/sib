<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
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
     
   		 <!-- 주문 상세 입력 -->
	     <section class="section pt3">
			<div>
				<div class="tblinfo">
					<h3>🧾정보입력</h3>
				</div>
				
				<table class="wd100 tc tbl ordertbl" id="tbl">
					<thead>
						<tr class="thtr">
							<td class="tdbl">상품명</td>
							<td class="tdbl">가격</td>
							<td class="tdbl">수량</td>
							<td>금액</td>
						</tr>
					</thead>
					
					<tbody>
						<q:forEach items="${ order }" var="t">
							<tr class="tbtr">
								<td class="tdbl">${ t.pname }</td>
								<td class="tdbl">${ t.price }</td>
								<td class="tdbl">${ t.count }</td>
								<td>${ t.total }</td>
							</tr>
						</q:forEach>
					</tbody>
				</table>
				
				<div class="wd80mg">
					<form method="post" action="/project/insertorder.pj">
						<q:forEach items="${ order }" var="t">
							<input type="hidden" name="ccnum" value="${ t.cnum }" />
							<input type="hidden" name="evnum" value="${ t.evnum }" />
							<input type="hidden" name="option" value="${ t.option }" />
							<input type="hidden" name="ppid" value="${ t.pid }"/>
							<input type="hidden" name="ppname" value="${ t.pname }" />
							<input type="hidden" name="ppcount" value="${ t.count }"/>
							<input type="hidden" name="ptotal" value="${ t.total }" />
						</q:forEach>
						
						<input type="hidden" name="cusid" value="${ userid }" />
						
						<div class="orderip">
							<div class="orderipp">
								<div class="p2 m3">
										<span class="fl tr tbold p2 wd30">주소 </span>
										<input class="fr p1 wd50 mr5" type="text" name="addr" autocomplete="off" /> <br/>
								</div>
								
								<div class="p2 m3">
										<span class="fl tr tbold p2 wd30">전화번호 </span>
										<input class="fr p1 wd50 mr5" type="text" autocomplete="off"  name="phone" /> <br/>
								</div>
								
								<div class="p3 m3 mt5">
									<input type="submit" class="delbtn wd40 bgcl" value="주문"/>
									<input type="button" onClick="location.href='/project/cart.pj'" class="delbtn wd40 bgcr" value="취소"/>
								</div>
							</div>
						</div>
					</form>
				</div>
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
