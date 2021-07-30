<%@ page contentType="text/html;charset=utf-8" 
			import="java.sql.*"%>
<%
//1.사용자가 전달한 idx값 알아내기
int code = Integer.parseInt(request.getParameter("code"));

System.out.println(code);
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
	String sql = "SELECT * FROM post WHERE code=?";
		
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//5. pstmt에 SELECT문의 WHERE절 이하를 구성하기 위한 메소드 설정.
	pstmt.setInt(1,code);
	
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
	height: 30px;
	padding: 10px 10px;
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
        a:hover{
            color:crimson;
        }
        td {
            font-family: Arial,휴먼고딕;
        }
        td:hover{
            background-color:hotpink;
            color:antiquewhite;
        }
        header {
            text-align: center;
            color: antiquewhite;
            background-color: hotpink;
            padding: 10px 10px;
            border-style: double;
            border-width: 5px;
            border-color: antiquewhite;
            font-family: Arial,휴먼고딕;
        }
        
        #content1 {
            width: 100%;
            background-color: pink;
            height: 80px;
            border-style: solid;
            border-width: 5px;
            border-color: antiquewhite;
            padding: 10px 10px;
            color:palevioletred;

        }
        #content2 {
            width: 100%;
            background-color: pink;
            height: 200px;
            border-style: solid;
            border-width: 5px;
            border-color: antiquewhite;
            padding: 10px 10px;
            color: palevioletred;
        }
       
        #maintitlefont{
            font-family:Arial,휴먼고딕;
        }
        
    </style>

</head>
<body>
	오늘의 날짜 시간:<%=new java.util.Date() %>
<ul class="menubar">
        <li><a href="p4_main.jsp">홈</a></li>
        <li><a href="p2_main.jsp">게시물관리</a></li>
        <li><a href="p1_in.jsp">메뉴관리</a></li>
    </ul>
    <header>
        <h1>Report</h1>
    </header>
    <div>
        <table border="1" id="content1">
            <form  method="post" action="p2_mod_do.jsp" enctype="multipart/form-data">
               
                <tr>
                    <td><b id="maintitlefont">게시판</b></td>
                    <td>
                        코드:<input type="text" name="code" readOnly value="<%=rs.getString("code")%>">
                     
                    </td>

                    <td>
                        1차 분류: <input type="text" name="sort1" maxlength="8" size="8" value="<%=rs.getString("sort1")%>">
                        
                    </td>

                    <td>
                        2차 분류:<input type="text" name="sort2" maxlength="8" size="8" value="<%=rs.getString("sort2")%>">
                    </td>

                </tr>
                <tr>
                    <td><b id="maintitlefont">제목</bid="maintitlefont"></td>
                    <td colspan="3"><textarea cols="50" rows="1" name="title" id="title" value="<%=rs.getString("title")%>"><%=rs.getString("title")%></textarea></td>
                </tr>
                <tr>
                    <td>
                        등록상태:
                        <select name="submitstage" id="ss">
                            <optgroup label="등록상태">
                                <option value="wait">등록대기</option>
                                <option value="complete">등록완료</option>
                            </optgroup>
                        </select>
                    </td>

                    <td>
                        최종수정일:<input type="text" name="lastsave" id="name" value="<%=new java.util.Date() %>">

                    </td>
                    <td>
                        기사취재일:<input type="date" name="sday" id="sday" value="<%=rs.getString("takeday")%>">

                    </td>
                </tr>
                <tr>
                    <td>
                        기자이름:<input type="text" name="name" id="name" value="<%=rs.getString("name")%>">

                    </td>
                    <td>
                        기자이메일:<input type="text" name="email" id="email" value="<%=rs.getString("email")%>">

                    </td>
                    <td>
                        썸네일이미지:<img src="./uploadimg/<%=rs.getString("thumbnail") %>" width="15" height="15">
          <br>              
                    변경할 이미지:    <input type="file" accept="image/jpg,image/gif" name="thumbnail" id="image">

                    </td>
                </tr>
                
            </table>
    </div>
    <div id="content2">
        
           
                
                    
                        <fieldset>
                            <legend><b id="maintitlefont"> 기본쓰기</b></legend>

                            기사입력:<br>
                            <textarea name="detail" cols="70" rows="8" name="mainwrite"><%=rs.getString("detail") %></textarea><br>
                            기사 이미지:<img src="./uploadimg/<%=rs.getString("mainimage") %>" width="100" height="100">
                            <input type="file" accept="image/jpg,image/gif" name="mainimage">
                        </fieldset>
                    
                    <button type="reset">취소</button>
                    <input type="submit" value="수정">
             

            </form>
        
</div>

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