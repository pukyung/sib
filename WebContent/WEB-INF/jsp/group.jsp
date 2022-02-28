<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/ju/group.css" rel="stylesheet" type="text/css"/>
<link href="css/jeong/nav.css" rel="stylesheet" type="text/css" />
<link href="css/jeong/hanho.css" rel="stylesheet" type="text/css" />
<script>
    function show(who){
      if(who =='regi'){
        document.getElementById("who").style.display = 'none';
        document.getElementById("my_modal").style.display = 'block';
        document.getElementById("참여자").style.display = 'none';
      }
      else if(who == 'pati'){
        document.getElementById("who").style.display = 'none';
        document.getElementById("my_modal").style.display = 'none';
        document.getElementById("modal").style.display = 'block';
        document.getElementById("참여자").style.display = 'block';
      }
    }

    window.onload = function(){
      /* stage */
      let first = document.getElementById("next_1");
      let sec = document.getElementById("next_2");
     /* info */
      let city = document.getElementById("city");
      let state = document.getElementById("state");
      let price = document.getElementById("price");
      let hid = document.getElementById("hid");
      let due = document.getElementById("due");
      let count = document.getElementById("count");
      let address = document.getElementById("address");
      let pname = document.getElementById("pname");

     first.onclick = function(){
        city.value = document.getElementById("ci").value;
        state.value = document.getElementById("s").value;
        document.getElementById('stage1').style.display = 'none';
        document.getElementById('stage2').style.display = 'block';
      }

      sec.onclick = function(){
        price.value=document.getElementById("p").value;
        due.value = document.getElementById("d").value;
        address.value = document.getElementById("a").value;
        pname.value = document.getElementById("n").value;
        count.value = document.getElementById("c").value;

        document.getElementById('stage2').style.display = 'none';
        document.getElementById('stage3').style.display='block';
      }
    }

    function bye(){
      let sta = document.getElementById('my_modal');
      sta.style.display = 'none';
      document.getElementById('my_modal').style.display='none';
      document.getElementById('modal').style.display='none';
      document.getElementById('who').style.display='block';
    }
  </script>
<title>심이베</title>
</head>
<body>
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
  <div id="head">
    <h3>🛒공동구매🛒</h3>
  </div>
  <div id="body">
    <div id="who">
      <table id="sel">
        <tr>
          <td style="border-right:2px solid #05c46b;"><button id="regi" onclick="show('regi')" class="who-btn"><img src="img/personal.png"/><p>등록하기</p></button></td>
          <td><button id="pati" onclick="show('pati')" class="who-btn"><img src="img/online-shopping.png"/><p>참여하기</p></button></td>
        </tr>
      </table>
    </div>
    <br/>
    <!-- 등록할 경우 -->
    <div id="my_modal">
        <section id="stage1">
          <h4>🌁시/구</h4>
          <div class="txt_area">
            <input type="text" id="ci" placeholder="시">
            <input type="text" id="s" placeholder="구/군"><br/>
          </div> 
          <div class="btn_area">
            <input type="button" onclick="bye()" value="취소"><input type="button" id="next_1" value="다음">
          </div> 
        </section>
        <section id="stage2">
          <h4>🤲🏻상품 등록하기</h4>
          <table>
          	<tr>
              <td class="what">상품명</td>
              <td><input type="text" placeholder="상품명" id="n"></td>
            </tr>
            <tr>
            	<td class="what">수량/무게</td>
            	<td><input type="text" placeholder="수량" id="c"></td>
            </tr>
            <tr>
              <td class="what"> 가격</td>
              <td><input type="text" placeholder="가격" id="p"></td>
            </tr>
            <tr>
              <td class="what">수령지</td>
              <td><input type="text" placeholder="수령지" id="a"></td>
            </tr>
            <tr>
              <td class="what">진행기간</td>
              <td><input type="text" placeholder="몇일 동안 진행하나요" id="d"></td>
            </tr>
          </table>
          <div class="btn_area">
            <input type="button" onclick="bye()" class="cancel" value="취소"><input type="button" id="next_2" value="다음">
          </div> 
        </section>
        <section id="stage3">
          <form method="post" action="makeRoom.pj">
            <h4>✅아래의 정보를 확인해주세요</h4>
            <table>
             <tr>
                <td width="10%" class="what">시</td>
                <td><input type="text" name="city" id="city" placeholder="시" readonly></td>
                <td width="20%" class="what">구/군</td>
                <td><input type="text" name="state" id="state" placeholder="구/군" readonly></td>
              </tr>
              <tr>
                <td class="what" colspan="2">상품명</td>
                <td colspan="2"><input type="text" name="pname" id="pname" placeholder="상품명"  readonly></td>
              </tr>
              <tr>
              	<td class="what" colspan="2">수량</td>
              	<td colspan="2"><input type="text" name="count" id="count" placeholder="수량"  readonly></td>
              </tr>
              <tr>
                <td class="what" colspan="2">가격</td>
                <td colspan="2"><input type="text" name="price" id="price" placeholder="가격"  readonly></td>
              </tr>
              <tr>
                <td  class="what" colspan="2">수령지</td>
                <td colspan="2"><input type="text" name="address" id="address" placeholder="주소"  readonly></td>
              </tr>
              <tr>
                <td class="what" colspan="2">진행자</td>
                <td colspan="2"><input type="text" value="${userid}" name="hid" id="hid" placeholder="등록자" readonly></td>
              </tr>
              <tr>
                <td class="what" colspan="2">진행기간</td>
                <td colspan="2"><input type="text" name="due" id="due"  placeholder="마감일"  readonly></td>
              </tr>
          </table>
          <div class="btn_area">
            <input type="submit" value="등록하기" id="sub_btn">
          </div>
        </form>
        </section>   
      </div>
    <!-- 참여할 경우 -->
    <div id="modal">
      <section id="participate">
        <section id="select">
          <h4>🌁시/구</h4>
          <div class="txt_area">
            <form method="post" action="groupList.pj">
              <input type="text" name="city" id="c1" placeholder="시">
              <input type="text" name="state" id="s1" placeholder="구/군">
              <div class="btn_area">
                <input type="button" onclick="bye()" class="cancel" value="취소"><input type="submit" value="찾기">
              </div> 
            </form>
          </div> 
        </section>
      </section>
    </div>
  </div> 
</body>
</html>