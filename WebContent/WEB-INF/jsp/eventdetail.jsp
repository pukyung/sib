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

		<div>
			<span>이름 : ${ eventdetail.pname }</span> <br/>
			<span>원산지 : ${ eventdetail.porigin }</span> <br/>
			<span>출하날짜 : ${ eventdetail.shipment }</span> <br/>
			<span>단위 : ${ eventdetail.unit }</span> <br/>
			<span>이벤트 기간 : ${ eventdetail.date }</span> <br/>
			<div>
				<form method="post" action="insertevent.pj">
					<div>
						<input type="text" name="eiprice" />
						<input type="hidden" name="evnum" value="${ eventdetail.evnum }" />
						<input type="hidden" name="pid" value="${ eventdetail.pid }" />
						<input type="submit" value="참여하기" />
					</div>
				</form>
			</div>
		</div>

		<div>
			<table border="1">
				<thead>
					<tr>
						<td>참여ID</td>
						<td>입력 가격</td>
						<td>날짜</td>
					</tr>
				</thead>
				
				<tbody>
					<q:forEach items="${ eventpart }" var="t" >
						<tr>
							<td>${ t.cusid }</td>
							<td>${ t.eiprice }</td>
							<td>${ t.date }</td>
						</tr>
					</q:forEach>
				</tbody>
			</table>
		</div>

	</body>
</html>


<!-- 

<input type="hidden" name="porigin" value="${ t.origin }" />
<input type="hidden" name="organic" value="${ t.organic }" />
<input type="hidden" name="shipment" value="${ t.shipment }" />
<input type="hidden" name="unit" value="${ t.unit }" />
<input type="hidden" name="eprice" value="${ t.eprice }" />
<input type="hidden" name="ddate" value="${ t.ddate }" />
 -->