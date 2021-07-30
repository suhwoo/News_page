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



    
   //3. 연결자를 생성한다.
    con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    
    
  //4. member 테이블에서 idx에 해당하는 레코드 검색하기위한 쿼리 문자열 구성
  	String sqle = "SELECT sort2 FROM kate WHERE sort1=?";
  		
  	PreparedStatement pstmt = con.prepareStatement(sqle);
  	
  	//5. pstmt에 SELECT문의 WHERE절 이하를 구성하기 위한 메소드 설정.
  	pstmt.setString(1,sort1);

  	//6. 쿼리 실행
  	ResultSet rse = pstmt.executeQuery();

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
            <form method="POST" action="p3_add.jsp" enctype="multipart/form-data">
                <tr>
                    <td><b id="maintitlefont">게시판</b></td>
                    <td>
                        코드:
                    
                    </td>

                    <td>
                    1차 분류:
                    <select name="sort1" id="s1">
                    <option><%=sort1 %></option>
                    </select>
                        
                        
                    </td>

                    <td>
                        2차 분류:
                        <select name="sort2" id="s2">
                        <%
  				  while(rse.next()) {
				%>
					<option><%=rse.getString("sort2") %></option>
					
				
				<%} %>
                        
                            
                        </select>
                    </td>

                </tr>
                <tr>
                    <td><b id="maintitlefont">제목</bid="maintitlefont"></td>
                    <td colspan="3"><textarea cols="50" rows="1" name="title" id="title">게시물 제목을 입력하세요</textarea></td>
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
                        기사취재일:<input type="date" name="sday" id="sday">

                    </td>
                </tr>
                <tr>
                    <td>
                        기자이름:<input type="text" name="name" id="name">

                    </td>
                    <td>
                        기자이메일:<input type="text" name="email" id="email">

                    </td>
                    <td>
                        썸네일이미지:<input type="file" accept="image/jpg,image/gif" name="thumbnail" id="image">

                    </td>
                </tr>
                
            </table>
    </div>
    <div id="content2">
        
           
                
                    
                        <fieldset>
                            <legend><b id="maintitlefont"> 기본쓰기</b></legend>

                            기사입력:<br>
                            <textarea name="detail" cols="70" rows="8" name="mainwrite"></textarea><br>
                            기사 이미지:<input type="file" accept="image/jpg,image/gif" name="mainimage">
                        </fieldset>
                    
                    <button type="reset">취소</button>
                     <input type="submit" value="등록">
             



            </form>
        
</div>

</body>
</html>