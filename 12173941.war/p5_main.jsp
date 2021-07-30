<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
String code=request.getParameter("code");

 %>
 <%
//2. JDBC 드라이버를 로드하기 위해 클래스 패키지를 지정한다.
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/pagedata?useSSL=false";
      //★주의 : mydb를 자신이 생성한 DB이름으로 변경하여 테스트 할것~!

String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con= null;

ResultSet rs   = null;



    
   //3. 연결자를 생성한다.
    con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    //4. Statement 객체를 생성한다.

    
    String query = "SELECT * FROM post WHERE code=?"; 
    //5.쿼리를 전달하고, ResultSet 객체를 반환 받는다.
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1,code);
    rs = pstmt.executeQuery();
    rs.next();
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
            height: 300px;
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
            <form  method="get" action="#" >
                <tr>
                    <td><b id="maintitlefont">게시판</b></td>
                    <td>
                        코드:<input type="text" name="code" readonly value="<%=rs.getString("code") %>">
                     
                    </td>

                    <td>
                        1차 분류:<input type="text" name="sort1" readonly value="<%=rs.getString("sort1") %>">
                        
                    </td>

                    <td>
                        2차 분류:<input type="text" name="sort2" readonly value="<%=rs.getString("sort2") %>">
                       
                    </td>

                </tr>
                <tr>
                    <td><b id="maintitlefont">제목</bid="maintitlefont"></td>
                    <td colspan="3"><input type="text" name="title" readonly value="<%=rs.getString("title") %>"></td>
                </tr>
                <tr>
                    <td>
                        등록상태:<input type="text" name="stage" readonly value="<%=rs.getString("stage") %>">
                    </td>

                    <td>
                        최종수정일:<input type="text" name="lastsave" readonly value="<%=rs.getString("lastsave") %>">

                    </td>
                    <td>
                        기사취재일:<input type="text" name="sday" readonly value="<%=rs.getString("takeday") %>">

                    </td>
                </tr>
                <tr>
                    <td>
                        기자이름:<input type="text" name="name" readonly value="<%=rs.getString("name") %>">

                    </td>
                    <td>
                        기자이메일:<input type="text" name="email" readonly value="<%=rs.getString("email") %>">

                    </td>
                    <td>
                        썸네일이미지:<img src="<%="./uploadimg/"+rs.getString("thumbnail") %>" width="30" height="30">

                    </td>
                </tr>
                
            </table>
    </div>
    <div id="content2">
        
           
                
                    
                        <fieldset>
                            <legend><b id="maintitlefont"> 기본쓰기</b></legend>

                            기사입력:<br>
                            <textarea cols="70" rows="8" name="mainwrite" readonly><%=rs.getString("detail") %></textarea><br>
                            기사 이미지:<img src="<%="./uploadimg/"+rs.getString("mainimage") %>" width="100" height="100">
                        </fieldset>
                    
             



            </form>
        
</div>

</body>
</html>