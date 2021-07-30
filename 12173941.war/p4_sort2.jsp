<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
String sort1 = request.getParameter("sort1");
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

    String sql = "SELECT DISTINCT sort1 FROM kate"; 
    
    //4. Statement 객체를 생성한다.
    stmt = con.createStatement();
  //5.쿼리를 전달하고, ResultSet 객체를 반환 받는다.
    rs = stmt.executeQuery(sql);
    
    String query = "SELECT sort2 FROM kate WHERE sort1=?"; 
    //5.쿼리를 전달하고, ResultSet 객체를 반환 받는다.
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1,sort1);

  	//6. 쿼리 실행
  	ResultSet rse = pstmt.executeQuery();
  	listmt = con.createStatement();
	String lisql ="SELECT * FROM post";
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
            font-family: Arial,휴먼고딕;
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
            float:right;
            background-color: pink;
            width: 60%;
            height: 500px;
        }
        .list li:hover{
            background-color:hotpink;
            color:antiquewhite;
        }
        table{
            background-color:lightpink;
        }
        li{
            color:mediumvioletred;
        }
        td {
            color: mediumvioletred;
        }
        .mainpost{
         width        : 400px;     /* 너비는 변경될수 있습니다. */
  text-overflow: ellipsis;  /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
     white-space  : nowrap; /* 줄바꿈을 하지 않습니다. */
  overflow     : hidden;    /* 내용이 길면 감춤니다 */
  display      : block;    
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
 <form action="p4_search.jsp" method="get">
        <ul class="menubar">
            <li><a href="p4_main.jsp" style="background-color: hotpink;padding: 10px 10px;height: 30px;border-style: double;border-width: 5px;border-color: antiquewhite;">홈</a></li>
            <li><a href="p2_main.jsp" style="padding: 10px 10px;height: 30px;border-style: double;border-width: 5px;border-color: antiquewhite;">게시물관리</a></li>
            <li><a href="p1_in.jsp" style="padding: 10px 10px;height: 30px;border-style: double;border-width: 5px;border-color: antiquewhite;">메뉴관리</a></li>
        </ul>
        <header>
            <h1>Article On</h1>
        </header>
        <nav>
            <ul class="list">
                <li>
                    &nbsp; <em>분류명_1</em>&nbsp;<br><br>
                     
				<%
				
  				  while(rs.next()) {
  					  
  					  
				%><em><input type="button" name="sort1" value="<%=rs.getString("sort1") %>" style="background-color: white;" onclick="location.href='p4_sort2.jsp?sort1=<%=rs.getString("sort1") %>'"></em>
					<br>
				<%} %>
          
                </li>
                <hr>
                <li>
                    &nbsp;<em>분류명_2</em>&nbsp;<br>
                    <em>
                        <select name="sort2" id="s2">
                        <%
  				  while(rse.next()) {
				%>
					<option value="<%=rse.getString("sort2") %>"><%=rse.getString("sort2") %></option>
					
				
				<%} %>
                        
                            
                        </select>
                    </em>
                    <hr>
                    <br />
                    <em><input type="submit" value="검색"></em>
                </li>
                <hr />
            </ul>
        </nav>
        <content>
            <ul id="article">
            <%
  				  while(list.next()) {
  					if(list.getString("stage").equals("complete")){
				%><li>
                    <table border="1" width="100%;">
                    	
                        <tr>
                            <td>
                               <img src="<%="./uploadimg/"+list.getString("thumbnail") %>" width="15" height="15">
                            </td>
                            <td>
                    		            기사제목
                            </td>
                            <td><a href="p5_main.jsp?code=<%=list.getInt("code")%>"><%=list.getString("title") %></a></td>
                        </tr>
                        </table>
                        <table border="1" width="100%;">
                        <tr>
                            <td class="mainpost" ><%=list.getString("detail") %></td>
                        </tr>
                    </table>
                    <hr />
                  
                </li>
				<%}} %>
                   
            </ul>
        </content>
    </form>

</body>
</html>