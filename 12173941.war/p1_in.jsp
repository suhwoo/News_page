<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
String nid=request.getParameter("ncode");
String ns1=request.getParameter("ns1");
String ns2=request.getParameter("ns2");
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


    
   //3. 연결자를 생성한다.
    con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    //4. Statement 객체를 생성한다.
    stmt = con.createStatement();

    
    String query = "SELECT DISTINCT sort1 FROM kate"; 
    
    //5.쿼리를 전달하고, ResultSet 객체를 반환 받는다.
    rs = stmt.executeQuery(query);
    

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기사게시화면</title>
<style>
a {
	text-align: center;
	color: antiquewhite;
	text-decoration: none;
	font-family: Arial, 휴먼고딕;
	border-style: double;
	border-width: 5px;
	border-color: antiquewhite;
	height: 30px;
	padding: 10px 10px;
	background-color: lightpink;
}

.menubar li {
	display: inline;
	
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
	text-align: center;
	display: table-cell;
	position: relative;
	top: 30px;
	left: 30px;
	background-color: pink;
	width: 30%;
	height: 500px;
	border-style: double;
	border-width: 5px;
	border-color: antiquewhite;
	float: left;
}

content {
	text-align: center;
	display: table-cell;
	position: relative;
	top: 30px;
	float:right;
	background-color: pink;
	width: 65%;
	height: 500px;
	border-style: double;
	border-width: 5px;
	border-color: antiquewhite;
}

.list li:hover {
	background-color: hotpink;
	color: antiquewhite;
}

table {
	background-color: lightpink;
	width: 50%;
	text-align: center;
	left: 40px;
}

li {
	color: mediumvioletred;
}

li:hover {
	color: antiquewhite;
}

td {
	color: mediumvioletred;
}

ol {
	border-style: dotted;
	border-color: hotpink;
}
</style>
<script>
	/*
	 var good_a = [ "야구", "축구", "배구", "골프" ];
	 var good_b = [ "물리", "화학", "지구과학", "생명과학" ];
	 var good_c = [ "속보", "인물", "의료", "식품", "범죄" ];
	 function categoryChange(e) {
	 alert("sort");
	
	 var target = document.getElementById("s2");

	 if (e.value == "스포츠")
	 var d = good_a;
	 else if (e.value == "과학")
	 var d = good_b;
	 else if (e.value == "사회")
	 var d = good_c;

	 target.options.length = 0;

	 for (x in d) {
	 var opt = document.createElement("option");
	 opt.value = d[x];
	 opt.innerHTML = d[x];
	 target.appendChild(opt);
	 }
	 }


	 function edit(){
	 alert("edit");
	 var c=document.getElementById("cc");
	 var s1=document.getElementById("s1");
	 var s2=document.getElementById("s2");
	
	 document.getElementById("ncode").value = cc.value;
	 document.getElementById("ns1").value = s1.value;
	 document.getElementById("ns2").value = s2.value;
	
	
	
	
	 }
	 function del(){
	
	 confirm("정말로 삭제하시겠습니까?");
	 var s2=document.getElementById("s2");
	 alert(s2.value+"를 삭제합니다.");
	 s2.removeChild(s2);
	 }
	 function add() {
	 //alert("here");
	
	 var code = document.getElementById("ncode");
	 var s1 = document.getElementById("ns1");
	 var s2 = document.getElementById("ns2");
	 var flag = 0;
	 var slag = 0;
	 alert("코드:"+ code.value + "\n1차분류:" + s1.value + "\n2차분류:" + s2.value);
	 //이미 있는 코드인지

	 var codearr = document.getElementsByName("code");
	 for (c in codearr) {
	 if (code.value == codearr[c].value) {
	 alert("이미 존재하는 코드입니다.");
	 flag = 1;
	 }
	 }
	 //존재하는 s1인지.
	 if (flag == 0) {
	 //alert("flag=0");
	 var s1arr = document.getElementsByName("sort1");
	 /*for(ss in s1arr){
	 alert("s1val:"+s1.value+"s1arr:"+s1arr[ss].value+"\n");
	 }*
	 for (ss in s1arr) {
	 if (s1.value == s1arr[ss].value) {
	 slag = 1;
	 ///	alert("go to" + s1.value);
	 var s2arr=document.getElementById("s2");
	 //	alert("s2arr");
	 var optionOBJ=document.createElement("option");
	 //alert("optioncre");
	 optionOBJ.setAttribute("value","s2.value");
	 //alert("set val");
	 var t=document.createTextNode(s2.value);
	 //alert("t");
	 optionOBJ.appendChild(t);
	 //alert("option");
	 s2arr.appendChild(optionOBJ);
	 //alert("addcom");
	 //s2추가완료
	 /
	 var s2arr=document.getElementById("s2");
	 alert(s1.value);
	
	 if (s1.value == "스포츠") {
	 good_a.push(s2.value);
	 } else if (s1.value == "과학")
	 good_b.push(s2.value);
	 else if (s1.value == "사회")
	 good_c.push(s2.value);


	 var ccarr=document.getElementById("cc");
	 //alert("ccarr");
	 var optionOBJc=document.createElement("option");
	 //alert("coptioncre");
	 optionOBJ.setAttribute("value","code.value");
	 //alert(code.value);
	 var tc=document.createTextNode(code.value);
	 //alert("tc");
	 optionOBJc.appendChild(tc);
	 //alert("coption");
	 ccarr.appendChild(optionOBJc);
	 //alert("addcom");
	 //code 추가완료
	
	 }
	 }
	 if (slag == 0) {
	 alert("해당하는 1차분류가 없습니다. 다시 입력해주세요.");
	 }
	 }
	 }
	 */
</script>

</head>
<body>
	오늘의 날짜 시간:<%=new java.util.Date() %>
	<form method="get" action="p1_save_add.jsp">
		<ul class="menubar">
			<li><a href="p4_main.jsp">홈</a></li>
			<li><a href="p2_main.jsp">게시물관리</a></li>
			<li><a href="p1_in.jsp" style="background-color: hotpink">메뉴관리</a></li>
		</ul>
		<header>
			<h1>Modify a Menu</h1>
		</header>
		<nav>
		현재 메뉴<br>
			
			<hr>
			1 차 분 류 <br>
			<table border="1" style="border-collapse:collapse">
				<%
  				  while(rs.next()) {
				%><tr>
					<td><%=rs.getString("sort1") %></td>
					
					<td><input type="button" value="찾기" onclick="location.href='p1_findsort2.jsp?sort1=<%=rs.getString("sort1") %>'"></td>
				</tr>
				<%} %>
				</table>
		</nav>
			
				
		
		<content>
				<ol>
						<li>새로운 분류명을 작성할 경우 추가하기버튼을 눌러주세요</li>
						<li>이미 작성된 분류명을 수정할 경우 수정버튼을 눌러주세요.</li>
						<li>이미 작성된 분류명을 삭제할 경우 삭제버튼을 눌러주세요.</li>

					</ol>

				<hr>


				1차 분류 : <input type="text" name="ns1"> <br>
				2차 분류 : <input type="text" name="ns2"> <br>
				<hr>
				<input type="submit" value="추가하기"> 
		</content>
				</form>
</body>
</html>