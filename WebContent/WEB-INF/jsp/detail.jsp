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
				} else{
					login.style.display="none";
					logout.style.display="inline-block";
					mypage.style.display="inline-block";
					register.style.display="none";
				}
			}
			
			window.onload = function() {
				let qnaclick = document.getElementById("qnaclick");
				let qnaans = document.getElementById("qnaans");
				qnaans.style.display = "none";
				
				qnaclick.onclick = function(){
					qnaans.style.display = "block";
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

		<!-- 상품 상세 정보 -->
		<section class="">
			<div class="detail">
			
				<div class="wd60">
					<img src="/project/getimage.jsp?file=${ img.get(0).image }" />
				</div>
				
				<div class="wd40 mt3">
					<q:if test="${ info.count < 11 }" >
						<span class="cr">[ 마감임박 ]</span>
					</q:if>
					
					<q:if test="${ info.organic eq '0' }" >
						<span class="cl">[ 유기농 ]</span>
					</q:if>
					
					<h1 class="bdb">${ info.pname }</h1><br/>
					
					<div class="bdb p3 tr pr3">
						<span>${ info.price } 원 / ${ info.unit }</span><br/>
					</div>
					
					<div class="bdb p3 tr pr3">
						<span>원산지 : ${ info.porigin }</span><br/>
					</div>
					
					<div class="bdb p3 tr pr3">
						<span>출하날짜 : ${ info.date }</span><br/>
					</div>
					
					<form>
						<input type="hidden" name="ppid" value="${ info.pid }" />
						<input type="hidden" name="pname" value="${ info.pname }" />
						<input type="hidden" name="price" value="${ info.price }" />
						<input type="hidden" name="forcount" value=1 />
						
						<div class="bdb p3 detailsel">
							<select name="option" class="fr wd10">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
							</select>
							<span class="fr wd10">수량</span>
						</div>
						<br/>
						
						<input type="submit" class="wd40 detailbtn" formaction="insertcart.pj" formmethod="post" value="장바구니"/>
						<input type="submit" class="wd40 detailbtn bcl" formaction="ordercheck.pj" formmethod="post" value="주문" />
					</form>
				</div>
			</div>
		</section>
		
		<!-- 상품 정보 이미지 / 리뷰 / QnA -->
		<section class="detailsub detailsec2">
			<br/><br/><br/>
			<div class="wd100">
				<div>
					<q:forEach items="${ img }" var="t">
						<img class="" src="/project/getimage.jsp?file=${ t.image }" />
						<br/>
					</q:forEach>
				</div>
			</div>
				
			<!-- #Review -->
			<div id="rv" class="mt10">
				<div class="content-title tl">
					<h3 class="reviewh3">📃 작성한 리뷰</h3>
				</div>
				<div>
					<table class="wd90 mauto">
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
									<td class="inside-td">${t.content}</td>
									<td class="inside-td">${t.answer}</td>
									<td class="inside-td">${t.pname}</td>
									<td>${t.score}</td>
								</tr>
							</q:forEach>
						</tbody> 
					</table>
				</div>
			</div>
			
			<!-- #QnA -->
			<div id="qnalist" class="mt10 pb10">
				<div class="content-title tl">
					<h3 class="reviewh3">👐🏻QnA</h3>
				</div>
				
				<table class="wd90 mauto">
					<thead>
						<tr>
							<td class="inside-th wd15">구매자</td>
							<td class="inside-th">제목</td>
							<td class="inside-th wd20">등록일</td>
						</tr>
					</thead>
					
					<q:forEach items="${questions}" var="t">
						<tr id="qnaclick">
							<td class="inside-td">${t.cusid}</td>
							<td class="inside-td">${t.title}</td>
							<td class="">${t.date}</td>
						</tr>
						
						<tr id="qnaans">
							<td colspan="6">
							<div id="writeAns">
								<textarea class="answer"  name="answer" rows="5" cols="33">${ t.answer }</textarea>
							</div>
							</td>
						</tr>
					</q:forEach>
				</table>
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
