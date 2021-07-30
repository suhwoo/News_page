<%@ page contentType="text/html;charset=utf-8" 
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.sql.*, java.io.*" 
%>
<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/pagedata?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";


//1.upload 이름을 가지는 실제 서버의 경로명 알아내기
ServletContext context =  getServletContext();
String realFolder = context.getRealPath("uploadimg");

//2. 최대 전송 파일 크기 5Mbytes로 정의
int maxsize = 5*1024*1024;

try {
	//3. MultipartRequest 객체 생성. 
	//   만일, 서버에 동일한 파일이름이 저장되어있다면, 파일이름 뒤에 숫자를 증가시킴
	MultipartRequest multi =  new MultipartRequest(request, realFolder,
			 maxsize, "utf-8",
			 new DefaultFileRenamePolicy());;

	//4. 사용자가 id, name, pwd 파라미터에 전송한 값 알아내기
	
	String code=multi.getParameter("code");
	String sort1=multi.getParameter("sort1");
	String sort2=multi.getParameter("sort2");
	String title=multi.getParameter("title");
	String stage=multi.getParameter("submitstage");
	String lastsave=multi.getParameter("lastsave");
	String sday=multi.getParameter("sday");
	String name=multi.getParameter("name");
	String email=multi.getParameter("email");
	String detail=multi.getParameter("detail");

	//5. 서버에 저장된 파일이름 알아내기
	String thumbnail = multi.getFilesystemName("thumbnail");
	String mainimage = multi.getFilesystemName("mainimage");

	//6. DB 연결자 생성(이곳에 빈즈나 Connection Pool로 대치 가능)
	Connection con =  DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	
	//7. id, name, pwd, fileName을 저장하기 위한 insert 문자열 구성
	String sql = "INSERT INTO post(sort1,sort2,title,stage,lastsave,takeday,name,email,thumbnail,detail,mainimage) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
	
	PreparedStatement pstmt = con.prepareStatement(sql);

	//8. pstmt의 SQL 쿼리 구성

	pstmt.setString(1,sort1);
	pstmt.setString(2,sort2);
	pstmt.setString(3, title);
	pstmt.setString(4, stage);
	pstmt.setString(5,lastsave);
	pstmt.setString(6, sday);
	pstmt.setString(7, name);
	pstmt.setString(8,email);
	pstmt.setString(9,thumbnail);
	pstmt.setString(10,detail);
	pstmt.setString(11,mainimage);
	
	
//stage mariadb에 넣어야 함. insert sql아직 안씀.//완료
	

	//9. 쿼리 실행
	pstmt.executeUpdate();
	
//
String up="update kate set count=1 where sort2=?";
PreparedStatement mpstmt = con.prepareStatement(up);
mpstmt.setString(1,sort2);
mpstmt.executeUpdate();
mpstmt.close();
	pstmt.close();
	con.close();

} catch(IOException e) { 
	out.println(e);
	return;
} catch(SQLException e) {
	out.println(e);
	return;
}
response.sendRedirect("p4_main.jsp");
%>