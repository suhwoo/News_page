<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");

 %>
<%
//2. JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/pagedata?useSSL=false";
      //★주의 : mydb를 자신이 생성한 DB이름으로 변경하여 테스트 할것~!

String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con= null;
Statement stmt = null;

ResultSet rs   = null;
Statement listmt = null;
ResultSet list   = null;



    
   //3. 연결자를 생성한다.
    con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    //4. Statement 객체를 생성한다.
    stmt = con.createStatement();

    
    String query = "SELECT DISTINCT sort1 FROM kate"; 
    //5.쿼리를 전달하고, ResultSet 객체를 반환 받는다.
    rs = stmt.executeQuery(query);
    
    listmt = con.createStatement();
	String lisql ="SELECT * FROM post LIMIT 21,41";
	list = listmt.executeQuery(lisql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기사등록페이지</title>
<style>
a {
	text-align: center;
	color: antiquewhite;
	text-decoration: none;
	font-family: Arial, 휴먼고딕;
	background-color: lightpink;
}

.menubar li {
	display: inline;
	background-color: lightpink;
	border-style: double;
	border-width: 1px;
	border-color: antiquewhite;
	padding: 2px 2px;
}

a:hover {
	color: crimson;
}

header {
	text-align: center;
	color: antiquewhite;
	background-color: hotpink;
	padding: 10px 10px;
	border-style: double;
	border-width: 5px;
	border-color: antiquewhite;
	font-family: Arial, 휴먼고딕;
	height: 80px;
}

em {
	border: dashed 3px hotpink;
}

nav {
	display: inline-block;
	position: relative;
	top: 20px;
	left: 30px;
	background-color: pink;
	width: 35%;
	height: 500px;
}

content {
	display: inline-block;
	position: relative;
	top: 20px;
	float: right;
	background-color: pink;
	width: 60%;
	height: 500px;
}

.list li:hover {
	background-color: hotpink;
	color: antiquewhite;
}

table {
	background-color: lightpink;
}

li {
	color: mediumvioletred;
}

td {
	color: mediumvioletred;
}

.mainpost {
	width: 400px; /* 너비는 변경될수 있습니다. */
	text-overflow: ellipsis; /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
	white-space: nowrap; /* 줄바꿈을 하지 않습니다. */
	overflow: hidden; /* 내용이 길면 감춤니다 */
	display: block;
}
</style>
<script>
/*
function categoryChange(e) {
	
    var good_a = ["야구", "축구", "배구", "골프"];
    var good_b = ["물리", "화학", "지구과학", "생명과학"];
    var good_c = ["속보", "인물", "의료", "식품", "범죄"];
    var target = document.getElementById("s2");
   
    if(e.value == "sport") var d = good_a;
    else if(e.value == "science") var d = good_b;
    else if(e.value == "society") var d = good_c;
   
    target.options.length = 0;
   
    for (x in d) {
      var opt = document.createElement("option");
      opt.value = d[x];
      opt.innerHTML = d[x];
      target.appendChild(opt);
    } 
  }


function show(){
	
	var code=document.getElementById("code");
	var s1=document.getElementById("s1");
	var s2=document.getElementById("s2");
	var title=document.getElementById("title");
	var stage=document.getElementById("ss");
	var sday=document.getElementById("sday");
	var name=document.getElementById("name");
	var email=document.getElementById("email");
	var image=document.getElementById("image");
	
	alert("코드:"+code.value+"\n1차분류:"+s1.value+"\n2차분류:"+s2.value+"\n제목:"+title.value+"\n등록상태:"+stage.value+"\n기사취재일:"+sday.value+"\n기자이름:"+name.value+"\n기사이메일:"+email.value+"\n이미지:"+image.value);
}*/

</script>
</head>
<body>
	<form action="p2_search.jsp" method="get">
		<ul class="menubar">
			<li><a href="p4_main.jsp"
				style="padding: 10px 10px; height: 30px; border-style: double; border-width: 5px; border-color: antiquewhite;">홈</a></li>
			<li><a href="p2_main.jsp"
				style="background-color: hotpink; padding: 10px 10px; height: 30px; border-style: double; border-width: 5px; border-color: antiquewhite;">게시물관리</a></li>
			<li><a href="p1_in.jsp"
				style="padding: 10px 10px; height: 30px; border-style: double; border-width: 5px; border-color: antiquewhite;">메뉴관리</a></li>
		</ul>
		<header>
			<h1>Article On</h1>
		</header>
		<nav>
			<ul class="list">
				
				<li>
				 	<select name="which">
							<option value="name">기자이름</option>
							<option value="title">기사제목</option>
							<option value="detail">기사내용</option>
					</select>
					<input type="text" name="s" id="s">
				 </li>
				 <input type="submit" value="검색">
				 <hr>
				 <input type="button" value="기사등록" style="background-color: white;" onclick="location.href='p3_in.jsp'">
				 
			</ul>
		</nav>
		<content>
		<table border="1" width="100%;">

			<tr>
				<td>분류</td>
				<td>이미지</td>
				<td>제목</td>
				<td>등록상태</td>
				<td>최종수정일</td>
				<td>취재일</td>
				<td>관리</td>
			</tr>
			<%
  				  while(list.next()) {
				%>
				<tr>
				<td><%=list.getString("sort1") %>-<%=list.getString("sort2")  %></td>
				<td><img
							src="<%="./uploadimg/"+list.getString("thumbnail") %>" width="15"
							height="15"></td>
							<td><%=list.getString("title") %></td>
				<td><%=list.getString("stage")  %></td>
				<td><%=list.getString("lastsave")  %></td>
				<td><%=list.getString("takeday")  %></td>
				<td>
				 <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="p2_del.jsp?code=<%=list.getInt("code")%>"> 삭 제</a>
				<br>
				<a href="p2_mod.jsp?code=<%=list.getInt("code")%>">수정</a>
				</td>
				</tr>
				<%} %>
		</table>
		 <a href="p2_1.jsp">1</a> <a href="p2_2.jsp">2</a> <a href="p2_3.jsp">3</a> <a href="p2_4.jsp">4</a> <a href="p2_5.jsp">5</a> <a href="p2_6.jsp">6</a> <a href="p2_7.jsp">7</a>
		 <a href="p2_8.jsp">8</a> <a href="p2_9.jsp">9</a> <a href="p2_10.jsp">10</a>
		</content>
	</form>

</body>
</html>