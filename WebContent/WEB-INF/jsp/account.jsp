<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/project/css/ju/account.css" rel="stylesheet" type="text/css"/>
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<script>
	// html이 모두 로드 된 후 실행되는 메소드
    window.onload = function(){
    	
	/* 선택 대상들 */
      let cusbtn = document.getElementById("cusbtn");
      let selbtn = document.getElementById("selbtn");
      let customer = document.getElementById("customer");
      let seller = document.getElementById("seller");
      let who = document.getElementById("who");
      let submit_cus = document.getElementById("submit_cus");
      let submit_sel = document.getElementById("submit_sel");
      
      /* 로드 시 나타나지 않도록 숨겨두기 */
      customer.style.display = 'none';
      seller.style.display = 'none';
      submit_cus.style.display = 'none';
      submit_sel.style.display = 'none';
      
      /* 사용자 종류 선택(해당 버튼 클릭) 시 동작*/
      cusbtn.onclick = function(){
        customer.style.height = '800px';
        customer.style.display = 'block';
        who.style.display = 'none';
      }

      selbtn.onclick = function(){
    	seller.style.height = '800px';
        seller.style.display = 'block';
        who.style.display = 'none';
      }
      
    }
    
	/* 비밀번호 확인을 수행하는 자바스크립트 */
    function checkPw(pw, check, mode){
    	let cus = document.getElementById("submit_cus");
    	let sel = document.getElementById("submit_sel");
    	
    	if(pw.value == check.value){
    		alert('비밀번호 확인!');
    		if(mode=='cus'){
    			cus.style.display='block';
    		}
    		else{
    			sel.style.display='block';
    		}
    	}
    	else{
    		alert('비밀번호가 일치하지 않습니다!');
    	}
    }
    
	/* 로그인 상태 확인하기 */
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
</script>
<title>심이베</title>	
</head>
<body class="wd100 hanhobody">
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
		
<div class="body">
<!-- 페이지 제목 -->
  <div id="content-title">
    <h3>회원가입</h3>
  </div>
  <!-- 사용자 선택 버튼 -->
  	<div id="who">
    	<label for="cusbtn"></label><input type="button" value="구매자" id="cusbtn"/>
	  	<input type="button" value="판매자" id="selbtn"/>
  	</div>
  	<!-- 사용자 회원가입 영역 -->
  	<!-- 소비자 회원가입 -->
  	<section id="customer"  class="userpart">
   	 <div class="box">
   	 <!-- 소비자 회원가입 폼 -->
      	<form method="post" action="cusaccount.pj">
        	<table class="regi_table">
          	<tr>
            	<td class="what">이름</td>
            	<td><input type="text" name="cusname" placeholder="이름" class="value shortInput"/></td>
          	</tr>
          	<tr>
            	<td class="what">아이디</td>
            	<td><input type="text" name="cusid" class="value shortInput" placeholder="아이디"/></td>
          	</tr>
          	<tr>
            	<td class="what">비밀번호</td>
            	<td>
            		<input type="password" id="cuspw" name="cuspw" class="value shortInput" placeholder="비밀번호"/>
            	</td>
         	 </tr>
          	<tr>
            	<td class="what">비밀번호 확인</td>
            	<td>
            		<input type="password" id="cuscheck" class="value shortInput" placeholder="비밀번호 확인"/>
            		<input type="button" id="cus_check" class="check" value="확인하기" onclick="checkPw(cuspw, cuscheck, 'cus')"/>
            	</td>
          	</tr>
          	<tr>
            	<td class="what">전화번호</td>
            	<td><input type="text" name="cusphone" class="value shortInput" placeholder="전화번호"/></td>
          	</tr>
          	<tr>
            	<td class="what">이메일</td>
            	<td><input type="text" name="cusmail" class="value shortInput"  placeholder="이메일"/></td>
          	</tr>
          	<tr>
            	<td class="what">주민등록번호</td>
            	<td><input type="text" name="cusresid"  class="value shortInput" placeholder="주민등록번호"/></td>
          	</tr>
          	<tr>
            	<td class="what">주소</td>
            	<td><input type="text" name="cusaddr" class="value longInput" placeholder="주소"/></td>
          	</tr> 
        	</table>
        	<div  class="subArea">
          		<input id="submit_cus" class="submit_btn" type="submit" value="등록하기">
        	</div>
    	</form>
    </div>  	
  </section>
   <!-- 판매자 회원가입 -->
  <section id="seller" class="userpart">
    <div class="box">
    <!-- 판매자 회원가입 폼 -->
      <form method="post" action="/project/selaccount.pj">
        <table  class="regi_table">
          <tr>
            <td class="what">아이디</td>
            <td><input type="text" class="value shortInput" placeholder="아이디" name="selid"/></td>
          </tr>
          <tr>
            <td class="what">비밀번호</td>
            <td><input type="password" id="selpw" class="value shortInput" placeholder="비밀번호" name="selpw"/></td>
          </tr>
          <tr>
            <td class="what">비밀번호 확인</td>
            <td>
            	<input type="password" id="selcheck" class="value shortInput" placeholder="비밀번호 확인"/>
            	<input type="button" class="check" id="sel_check" value="확인하기" onclick="checkPw(selpw, selcheck, 'sel')"/>
            </td>
          </tr>
          <tr>
            <td class="what">상호명</td>
            <td><input type="text" class="value shortInput" placeholder="상호명" name="selname"/></td>
          </tr>
          <tr>
            <td class="what">사업자등록번호</td>
            <td><input type="text" class="value shortInput"  name="selnum" placeholder="사업자등록번호"/></td>
          </tr>
          <tr>
            <td class="what">주소</td>
            <td><input type="text" class="value longInput"  name="seladdr"  placeholder="주소지"/></td>
          </tr>
          <tr>
            <td class="what">대표전화</td>
            <td><input type="text" class="value shortInput"  name="selphone" placeholder="대표전화번호"/></td>
          </tr>
          <tr>
            <td class="what">담당자명</td>
            <td><input type="text" class="value shortInput"  name="repname" placeholder="담당자명"/></td>
          </tr>
        </table>
        <div class="subArea">
          <input type="submit" id="submit_sel"  class="submit_btn"  value="등록하기">
        </div>
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