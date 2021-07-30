<%@ page contentType="text/html;charset=utf-8" 
			import="java.sql.*"%>
<%
//1.사용자가 전달한 idx값 알아내기
String sort1 = request.getParameter("sort1");


try {
	//2. JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/pagedata?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

	//3. 연결자 생성
	Connection con =  DriverManager.getConnection(DB_URL,"admin","1234");

	//4. member 테이블에서 idx에 해당하는 레코드 검색하기위한 쿼리 문자열 구성
	String sql = "SELECT code,sort2 FROM kate WHERE sort1=?";
		
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//5. pstmt에 SELECT문의 WHERE절 이하를 구성하기 위한 메소드 설정.
	pstmt.setString(1,sort1);

	//6. 쿼리 실행
	ResultSet rs = pstmt.executeQuery();
	
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
function del(){
	confirm("정말로 삭제하시겠습니까?");
	 if(con_test==true){
		
	 }else if(con_test==false){
		 
	 }
}
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
			2 차 분 류 <br>
			<table border="1" style="border-collapse:collapse">
	<tr>
	<td>Code</td>
	<td>Sort2</td>
	<td>비고</td>

	</tr>
	<%
	    while(rs.next()) {
	%>
	<tr>
	<td><%=rs.getString("code") %></td>
	<td><%=rs.getString("sort2") %></td>
	<td>
	<!-- 8. 삭제를 처리하기 위한 링크를 구성한다. 
	      삭제 페이지는 delete_do.jsp인것으로 한다.-->
	    
	  <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="p1_delete.jsp?code=<%=rs.getInt("code")%>"> 삭 제</a>
	<!-- 9. 수정 기능을 구현하기 위한 버튼을 만든다. 
	      단, 수정페이지는 DB에 저장된 정보를 먼저 출력해주어야 할 것이다.
	         수정을 위한 정보 출력 페이지는 modify.jsp인 것으로 한다 -->
	<input type="button" value="수정" onclick="location.href='p1_modify.jsp?code=<%=rs.getInt("code") %>'">

	</td>

	</tr>
	<%
	    } // end while
	%>
	</table>
	<input type="button" value="돌아가기" onclick="location.href='p1_in.jsp?'">
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
	
<% 
	//DB관련 객체 close시키기
	rs.close();
	pstmt.close();
	con.close();
%>

<%
}catch(SQLException e) {
	out.print(e);
	return;
}
%>
</body>
</html>