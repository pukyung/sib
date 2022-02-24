<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

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
		
		<!-- 상품 정보 입력 -->
		<section>
			<div class="ht85 wd50 mauto">
				<form method="post" class="ht70" action="insertproduct.pj" enctype="multipart/form-data">
					<table class="intbl ht100 tc wd100 mt5 coll">
						<tbody>
							<tr class="productin-tr">
								<td class="productin-r tbold">상품명</td>
								<td>
									<input type="text" name="pname" class="productin-ipt" autocomplete="off" />
								</td>
							</tr>
							
							<tr class="productin-tr">
								<td class="productin-r tbold">원산지</td>
								<td>
									<input type="text" name="porigin" class="productin-ipt" autocomplete="off" />
								</td>
							</tr>
							
							<tr class="productin-tr">
								<td class="productin-r tbold">유기농여부</td>
								<td>
									<select name="organic" class="productin-ipt">
										<option value=0>유기농</option>
										<option value=1>일반</option>
									</select>
								</td>
							</tr>
							
							<tr class="productin-tr tbold">
								<td class="productin-r">출하날짜</td>
								<td>
									<input type="date" name="shipment" class="productin-ipt" autocomplete="off" />
								</td>
							</tr>
							
							<tr class="productin-tr tbold">
								<td class="productin-r">종류</td>
								<td>
									<select name="type" class="productin-ipt">
										<option value=0>기타</option>
										<option value=1>당근</option>
										<option value=2>배추</optoin>
										<option value=3>오이</option>
										<option value=4>고추</option>
										<option value=5>감자</option>
									</select>
								</td>
							</tr>
							
							<tr class="productin-tr tbold">
								<td class="productin-r" class="productin-ipt">단위</td>
								<td>
									<select name="unit" class="productin-ipt">
										<option value="1kg">1kg</option>
										<option value="5kg">5kg</option>
										<option value="10kg">10kg</option>
									</select>
								</td>
							</tr>
							
							<tr  class="productin-tr tbold">
								<td class="productin-r">단위당가격</td>
								<td>
									<input type="text" name="price" class="productin-ipt" autocomplete="off" />
								</td>
							</tr>
							
							<tr class="productin-tr tbold">
								<td class="productin-r">수량</td>
								<td>
									<input type="text" name="count" class="productin-ipt" autocomplete="off" />
								</td>
							</tr>
							
							<tr class="tbold">
								<td class="productin-r">사진</td>
								<td>
									<input type="file" name="iimage" class="" multiple />
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="ht100 mt5 tc">
						<input type="submit" class="productin-btn bcl"/>
						<input type="button" class="productin-btn bgcr" value="삭제" onClick="location.href='/main.pj'" />
					</div>
				</form>
			</div>
		</section>
		
		<!-- Footer -->
		<footer class="footer mainfooter">
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
