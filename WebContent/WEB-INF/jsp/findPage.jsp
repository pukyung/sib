<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/project/css/ju/findpage.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<script>
    window.onload = function(){
      let customer = document.getElementById("customer");
      let seller = document.getElementById("seller");
      let cusid = document.getElementById("cusid");
      let cuspw = document.getElementById("cuspw");
      let byPhoneC = document.getElementById("byPhoneC");
      let byEmail = document.getElementById("byEmail");
      let byPhoneS = document.getElementById("byPhoneS");
      let byRepname = document.getElementById("byRepname");
      let selid = document.getElementById("selid");
      let selpw = document.getElementById("selpw");

      customer.style.display = 'none';
      seller.style.display='none';
      cusid.style.display='none';
      cuspw.style.display='none';
      byPhoneC.style.display = 'none';
      byEmail.style.display = 'none';
      byPhoneS.style.display='none';
      byRepname.style.display='none';
      selid.style.display='none';
      selpw.style.display='none';
    }
    
    /* 사용자가 선택한 영역을 보여주는 메소드 */
    function show(kind){
    	document.getElementById(kind).style.display = 'block';
    	switch(kind){
    	case 'customer':
    		document.getElementById('seller').style.display = 'none';
    		break;
    	case 'seller':
    		document.getElementById('customer').style.display='none';
    		break;
    	case 'cusid':
    		document.getElementById('cuspw').style.display = 'none';
    		break;
    	case 'cuspw':
    		document.getElementById('cusid').style.display='none';
    		break;
    	case 'byPhoneC':
    		document.getElementById('byEmail').style.display='none';
    		break;
    	case 'byEmail':
    		document.getElementById('byPhoneC').style.display='none';
    		break;
    	case 'selid':
    		document.getElementById('selpw').style.display='none';
    		break;
    	case 'selpw':
    		document.getElementById('selid').style.display='none';
    		break;
    	case 'byPhoneS':
    		document.getElementById('byRepname').style.display='none';
    		break;
    	case 'byRepname':
    		document.getElementById('byPhoneS').style.display='none';
    		break;
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
					<div class="navlogo tc logo">
						<a href="/project/main.pj" class="logo hanhoa">심이베</a>
					</div>
					<div class="navlogo tc tf">
						<a href="/project/main.pj"><img src="/project/css/logo.png"
							class="wd15" /></a>
					</div>
					<div class="jc navlogo tc">
						<li class="navlili hanholi" id="register"><a
							href="/project/register.pj" class="hanhoa">회원가입</a></li>
						<li class="navlili hanholi" id="login"><a
							href="/project/login.pj" class="hanhoa">로그인</a></li>
						<li class="navlili hanholi" id="logout"><a
							href="/project/logout.pj" class="hanhoa">로그아웃</a></li>
						<li class="navlili hanholi" id="cart"><a
							href="/project/cart.pj" class="hanhoa">장바구니</a></li>
						<li class="navlili hanholi" id="mypage"><a
							href="/project/mypage.pj" class="hanhoa">${ userid } 님</a></li>
						<script>loginStatus("${kind}")</script>
					</div>
				</div>
			</ul>
			<ul class="navmenu tc hanhoul">
				<div>
					<li class="navli hanholi"><a href="/main.pj"
						class="nava hanhoa">메인</a></li>
					<li class="navli hanholi"><a href="/product.pj"
						class="nava hanhoa">상품</a></li>
					<li class="navli hanholi"><a href="/notice.pj"
						class="nava hanhoa">공지사항</a></li>
				</div>
			</ul>
		</nav>
	</header>

	<div class="body">
		<!-- 페이지 제목  -->
		<div id="content-title">
			<h3>아이디/비밀번호 찾기🔎</h3>
		</div>
		<!-- 사용자 선택 버튼  -->
		<div id="who">
			<h3>선택해주세요</h3>
			<table>
				<tr>
					<td id="cus-td"><button id="cusbtn" onclick="show('customer')">
							<img src="/project/img/shopping-bag.png" width="200px"
								height="200px" />
						</button></td>
					<td id="sel-td"><button id="selbtn" onclick="show('seller')">
							<img src="/project/img/seller.png" width="200px" height="200px" />
						</button></td>
				</tr>
			</table>
		</div>
		<!-- 사용자 영역  -->
		<!-- 소비자  -->
		<section id="customer">
			<!-- 찾는 대상 선택하기  -->
			<div id="cus-find">
				<button class="id" onclick="show('cusid')">아이디 찾기</button>
				<button class="pw" onclick="show('cuspw')">비밀번호 찾기</button>
			</div>
			<!-- 소비자 아이디 찾는 영역  -->
			<section id="cusid">
				<!-- 아이디 찾는 방법 선택하기  -->
				<div class="what">
					<label for="cusphone">📞전화번호로 찾기</label><input type="radio"
						name="mode" value='cusphone' id="cusphone"
						onclick="show('byPhoneC')" checked /> <label for="email">💬이메일로
						찾기</label><input type="radio" name="mode" value="email" id="email"
						onclick="show('byEmail')" />
				</div>
				<!-- 전화번호롤 찾기 영역 -->
				<section id="byPhoneC">
					<h4>전화번호로 찾기</h4>
					<!-- 전화번호로 찾기 폼  -->
					<form method="post" action="findIdPw.pj">
						<table>
							<tr>
								<td id="name-label">이름</td>
								<td id="name-val"><input type="text" name="cusname"
									id="cusname" placeholder="이름을 입력하세요" /></td>
							</tr>
							<tr>
								<td id="phonec-label">전화번호</td>
								<td id="phonec-val"><input type="text" name="cusphone"
									id="cphone" placeholder="전화번호를 입력하세요(-제외 숫자만)" /></td>
							</tr>
						</table>
						<!-- 찾기 버튼 영역 -->
						<div class="find">
							<input type="submit" class="findbtn" value="찾기" />
						</div>
						<input type="hidden" name="kind" value="idcp" />
					</form>
				</section>
				<!-- 이메일로 찾기 영역 -->
				<section id="byEmail">
					<h4>이메일로 찾기</h4>
					<!-- 이메일로 찾기 폼 -->
					<form method="post" action="findIdPw.pj">
						<table>
							<tr>
								<td>이름</td>
								<td><input type="text" name="cusname" id="cusname"
									placeholder="이름을 입력하세요" /></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><input type="text" name="cusmail" id="cusemail"
									placeholder="이메일을 입력하세요" /></td>
							</tr>
						</table>
						<div class="find">
							<input type="submit" class="findbtn" value="찾기" />
						</div>
						<input type="hidden" name="kind" value="idem" />
					</form>
				</section>
			</section>
			<!-- 소비자 비밀번호 찾기  -->
			<section id="cuspw">
				<h4>비밀번호 찾기</h4>
				<!-- 소비자 비밀번호 찾기 영역 -->
				<form method="post" action="findIdPw.pj">
					<table>
						<tr>
							<td>이름</td>
							<td><input type="text" name="cusname" id="cname"
								placeholder="이름을 입력하세요" /></td>
						</tr>
						<tr>
							<td>아이디</td>
							<td><input type="text" name="cusid" id="cid"
								placeholder="아이디를 입력하세요" /></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><input type="text" name="cusphone" id="phonec"
								placeholder="전화번호를 입력하세요" /></td>
						</tr>
						<tr>
							<td>주민등록번호</td>
							<td><input type="text" name="cusresid" id="resid"
								placeholder="주민등록번호를 입력하세요" /></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td><input type="text" name="cusmail" id="cusmail"
								placeholder="이메일을 입력하세요" /></td>
						</tr>
					</table>
					<div class="find">
						<input type="submit" class="findbtn" value="찾기" />
					</div>
					<input type="hidden" name="kind" value="cpw" />
				</form>
			</section>
		</section>

		<!--판매자 section -->
		<section id="seller">
			<!-- 찾는 대상 선택하기  -->
			<div id="sel-find">
				<button class="id" onclick="show('selid')">아이디 찾기</button>
				<button class="pw" onclick="show('selpw')">비밀번호 찾기</button>
			</div>
			<!-- 판매자 아이디 찾기  -->
			<section id="selid">
				<!-- 아이디 찾는 방법 선택하기  -->
				<div class="what">
					<label for="cusphone">📞전화번호로 찾기</label><input type="radio"
						name="mode" value='selphone' id="selphone"
						onclick="show('byPhoneS')" checked /> <label for="email">👨🏻‍💼담당자명으로
						찾기</label><input type="radio" name="mode" value="repname" id="repname"
						onclick="show('byRepname')" />
				</div>
				<!-- 판매자 전화번호로 찾기  -->
				<section id="byPhoneS">
					<h4>전화번호로 찾기</h4>
					<form method="post" action="findIdPw.pj">
						<table>
							<tr>
								<td>상호명</td>
								<td><input type="text" name="selname" id="selname"
									placeholder="상호명을 입력하세요" /></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input type="text" name="selphone" id="sphone"
									placeholder="전화번호를 입력하세요" /></td>
							</tr>
						</table>
						<div class="find">
							<input type="submit" class="findbtn" value="찾기" />
						</div>
						<input type="hidden" name="kind" value="idsp" />
					</form>
				</section>
				<!-- 판매자 아이디 담당자명으로 찾기  -->
				<section id="byRepname">
					<h4>담당자명으로 찾기</h4>
					<form method="post" action="findIdPw.pj">
						<table>
							<tr>
								<td>상호명</td>
								<td><input type="text" name="selname" id="selname"
									placeholder="상호명을 입력하세요" /></td>
							</tr>
							<tr>
								<td>담당자명</td>
								<td><input type="text" name="repname" id="rep"
									placeholder="이메일을 입력하세요" /></td>
							</tr>
						</table>
						<div class="find">
							<input type="submit" class="findbtn" value="찾기" />
						</div>
						<input type="hidden" name="kind" value="idrp" />
					</form>
				</section>
			</section>
			<!-- 판매자 비밀번호 찾기  -->
			<section id="selpw">
				<h4>비밀번호 찾기</h4>
				<form method="post" action="findIdPw.pj">
					<table>
						<tr>
							<td>상호명</td>
							<td><input type="text" name="selname" id="sname"
								placeholder="상호명을 입력하세요" /></td>
						</tr>
						<tr>
							<td>아이디</td>
							<td><input type="text" name="selid" id="sid"
								placeholder="아이디를 입력하세요" /></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><input type="text" name="selphone" id="phones"
								placeholder="전화번호를 입력하세요" /></td>
						</tr>
						<tr>
							<td>사업자 등록 번호</td>
							<td><input type="text" name="selnum" id="selnum"
								placeholder="사업자 등록번호를 입력하세요" /></td>
						</tr>
						<tr>
							<td>담당자</td>
							<td><input type="text" name="repname" id="repn"
								placeholder="담당자명을 입력하세요" /></td>
						</tr>
					</table>
					<div class="find">
						<input type="submit" class="findbtn" value="찾기" />
					</div>
					<input type="hidden" name="kind" value="spw" />
				</form>
			</section>
		</section>
	</div>
	<!-- footer -->
	<footer class="footer">
		<div class="footerdiv">
			<div class="wd50 fr">
				<span>부산광역시 남구 용소로 45</span><br /> <span>gksdn1216@naver.com</span><br />
			</div>

			<div class="wd50 fr">
				<span>주식회사되고싶은 심이베</span><br /> <span>대표자 주상희, 정한호</span><br /> <span>Copyright&copy;
					주상희, 정한호</span><br />
			</div>
		</div>
	</footer>
</body>
</html>