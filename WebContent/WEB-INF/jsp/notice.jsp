<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/project/css/ju/notice.css" rel="stylesheet" type="text/css"/>
<link href="/project/css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="/project/css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">	
<script type="text/javascript">
	function show(id){
		let write = document.getElementById("write");
		let link = document.getElementsByClassName("delete-link");
		
		if(id != 'admin'){
			write.style.display='none';
			for(let i=0;i<link.length;i++){
				link[i].style.display = 'none';
			}
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
<title>?????????</title>
</head>

<body class=" hanhobody" onload="show('${userid}')">
	<header>
		<nav class="nav nava">
			<ul class="navmain hanhoul">
				<div class="df">
				<div class="navlogo tc logo"><a href="/project/main.pj" class="logo hanhoa">?????????</a></div>
				<div class="navlogo tc tf"><a href="/project/main.pj" ><img src="/project/css/logo.png" class="wd15"/></a></div>
					<div class="jc navlogo tc">
						<li class="navlili hanholi" id="register"><a href="/project/register.pj" class="hanhoa">????????????</a></li>
						<li class="navlili hanholi" id="login"><a href="/project/login.pj" class="hanhoa">?????????</a></li>
						<li class="navlili hanholi" id="logout"><a href="/project/logout.pj" class="hanhoa">????????????</a></li>
						<li class="navlili hanholi" id="cart"><a href="/project/cart.pj" class="hanhoa">????????????</a></li>
						<li class="navlili hanholi" id="mypage"><a href="/project/mypage.pj" class="hanhoa">${ userid } ???</a></li>
						<script>loginStatus("${kind}")</script>
					</div>
				</div>
			</ul>
			<ul class="navmenu tc hanhoul" >
				<div>
					<li class="navli hanholi"><a href="/project/main.pj" class="nava hanhoa">??????</a></li>
					<li class="navli hanholi"><a href="/project/product.pj" class="nava hanhoa">??????</a></li>
					<li class="navli hanholi"><a href="/project/notice.pj" class="nava hanhoa">????????????</a></li>
				</div>
			</ul>
		</nav>
	</header>

<!-- ???????????? ???????????? -->
<div class="body">
	<div class="dv">
    	<div id="title"><h1>??????????</h1></div>
    	<div id="body">
      		<div id="header">
        		<input type="button" class="btn" value="????????????" id="write" onclick="location.href='writeNotice.pj'"/>
      		</div>
      		<table id="notice">
        		<!-- ????????? ?????? -->
        		<q:forEach items="${notice}" var="k">
          			<q:if test="${k.important eq 1}">
            			<tr class="important">
              				<td class="import-td">
               					 <div class="import-title"><a class="title impotant" href="/project/nDetail.pj?pnum=${k.pnum}">???????????? ${k.title}</a></div>
                				 <div class="import-info">?????????${k.date} ????????? ?????????</div>
              				</td>
            			</tr>
          			</q:if>
        		</q:forEach>
        		<!-- ?????? ???????????? -->
        		<q:forEach items="${notice}" var="t">
          			<tr class="normal">
            			<td class="normal-td">
              				<div class="normal-title">
              					<a class="title impotant" href="/project/nDetail.pj?pnum=${t.pnum}">
              						${t.pnum}.&nbsp;${t.title}
              					</a>
              					<a href="deleteN.pj?pnum=${t.pnum}" class="delete-link">
              						[X]
              					</a>
              				</div>
              				<div class="normal-info">?????????${t.date} ????????? ?????????</div>
            			</td>			
          			</tr>
        		</q:forEach>
      		</table>		
    	</div>
	</div>
</div>

<!-- footer -->
<footer class="footer">
	<div class="footerdiv">
		<div class="wd50 fr">
			<span>??????????????? ?????? ????????? 45</span><br/>
			<span>gksdn1216@naver.com</span><br/>
			</div>
			
		<div class="wd50 fr">
			<span>???????????????????????? ?????????</span><br/>
			<span>????????? ?????????, ?????????</span><br/>
			<span>Copyright&copy; ?????????, ?????????</span><br/>
		</div>
	</div>
</footer> 
</body>
</html>