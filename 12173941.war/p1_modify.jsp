<%@ page contentType="text/html;charset=utf-8" 
			import="java.sql.*"%>
<%
//1.사용자가 전달한 idx값 알아내기
String code = request.getParameter("code");


try {
	//2. JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/pagedata?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

	//3. 연결자 생성
	Connection con =  DriverManager.getConnection(DB_URL,"admin","1234");
	
	
//1차분류 넣기
	Statement stmt = null;
	ResultSet rs1   = null;
	 //4. Statement 객체를 생성한다.
    stmt = con.createStatement();

    
    String query = "SELECT DISTINCT sort1 FROM kate"; 
    
    //5.쿼리를 전달하고, ResultSet 객체를 반환 받는다.
    rs1 = stmt.executeQuery(query);
//1차분류끝
	//4. member 테이블에서 idx에 해당하는 레코드 검색하기위한 쿼리 문자열 구성
	String sql = "SELECT sort1, sort2 FROM kate WHERE code=?";
		
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//5. pstmt에 SELECT문의 WHERE절 이하를 구성하기 위한 메소드 설정.
	pstmt.setInt(1,Integer.parseInt(code));

	//6. 쿼리 실행
	ResultSet rs = pstmt.executeQuery();
	
	//7. 레코드 커서 이동시키기
	rs.next();
	
	//8. 레코드에 저장된 id, name, pwd 값을 알아내어 각 변수에 저장하기
	
	String sort1 = rs.getString("sort1");
	String sort2 = rs.getString("sort2");
	
	
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
	display: table-cell;
	position: relative;
	top: 30px;
	float: right;
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

</head>
<body>
	오늘의 날짜 시간:<%=new java.util.Date() %>
	<form action="p1_modify_do.jsp" method="post">
		<ul class="menubar">
			<li><a href="p4_main">홈</a></li>
			<li><a href="p2_main.jsp">게시물관리</a></li>
			<li><a href="p1_in">메뉴관리</a></li>
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
  				  while(rs1.next()) {
				%><tr>
					<td><%=rs1.getString("sort1") %></td>
					
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

				Number(code) : <input type="text" name="code" readOnly value="<%=code%>"><!--9.입력양식에 값 출력하기 --><br>
				1차 분류 : <input type="text" name="sort1" maxlength="8" size="8" value="<%=sort1%>"><!--10.입력양식에 값 출력하기 --><br>
				2차 분류: <input type="text" name="sort2" maxlength="12" size="12" value="<%=sort2%>"><!--11.입력양식에 값 출력하기 --><br>
				
				<hr>
				<input type="submit" value="수정하기"> 
				<input type="button" value="돌아가기" onclick="location.href='p1_in.jsp?'">
		</content>
				</form>
</body>
<body>




</html>
<%
//DB관련 객체 close시키기
	rs.close();
	pstmt.close();
	con.close();
}catch(SQLException e) {
	out.print(e);
	return;
}
%>