<%@ page contentType="text/html;charset=utf-8" 
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.sql.*, java.io.*" 
%>
<%
request.setCharacterEncoding("utf-8");

ServletContext context = getServletContext();

String realFolder = context.getRealPath("uploadimg");

int maxsize = 5*1024*1024;

MultipartRequest multi = new MultipartRequest(request,realFolder,maxsize,
		"utf-8",new DefaultFileRenamePolicy());

int code = Integer.parseInt(multi.getParameter("code"));
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

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/pagedata?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);

PreparedStatement pstmt=null;
PreparedStatement pstmte=null;
String sql = null;
if(thumbnail!=null){
	sql = "SELECT thumbnail FROM post WHERE code=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1,code);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	String oldFileName = rs.getString("thumbnail");
	
	rs.close();
	
	File oldFile = new File(realFolder+"\\"+"oldFileName");
	oldFile.delete();
	
	sql = "UPDATE post SET sort1=?,sort2=?,title=?,stage=?,lastsave=?,takeday=?,name=?,email=?,detail=? WHERE code=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,sort1);
	pstmt.setString(2,sort2);
	pstmt.setString(3,title);
	pstmt.setString(4,stage);
	pstmt.setString(5,lastsave);
	pstmt.setString(6,sday);
	pstmt.setString(7,name);
	pstmt.setString(8,email);
	pstmt.setString(9,detail);
	pstmt.setInt(10,code);
	
	
	
	
}else{
	sql = "UPDATE post SET sort1=?,sort2=?,title=?,stage=?,lastsave=?,takeday=?,name=?,email=?,detail=? WHERE code=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,sort1);
	pstmt.setString(2,sort2);
	pstmt.setString(3,title);
	pstmt.setString(4,stage);
	pstmt.setString(5,lastsave);
	pstmt.setString(6,sday);
	pstmt.setString(7,name);
	pstmt.setString(8,email);
	pstmt.setString(9,detail);
	pstmt.setInt(10,code);
	
}
if(mainimage!=null){
	sql = "SELECT mainimage FROM post WHERE code=?";
	pstmte = con.prepareStatement(sql);
	pstmte.setInt(1,code);
	ResultSet rs = pstmte.executeQuery();
	rs.next();
	String oldFileName = rs.getString("mainimage");
	
	rs.close();
	
	File oldFile = new File(realFolder+"\\"+"oldFileName");
	oldFile.delete();
	
	sql = "UPDATE post SET sort1=?,sort2=?,title=?,stage=?,lastsave=?,takeday=?,name=?,email=?,detail=? WHERE code=?";
	pstmte = con.prepareStatement(sql);
	pstmte.setString(1,sort1);
	pstmte.setString(2,sort2);
	pstmte.setString(3,title);
	pstmte.setString(4,stage);
	pstmte.setString(5,lastsave);
	pstmte.setString(6,sday);
	pstmte.setString(7,name);
	pstmte.setString(8,email);
	pstmte.setString(9,detail);
	pstmte.setInt(10,code);
	
	
	
}else{
	sql = "UPDATE post SET sort1=?,sort2=?,title=?,stage=?,lastsave=?,takeday=?,name=?,email=?,detail=? WHERE code=?";
	pstmte = con.prepareStatement(sql);
	pstmte.setString(1,sort1);
	pstmte.setString(2,sort2);
	pstmte.setString(3,title);
	pstmte.setString(4,stage);
	pstmte.setString(5,lastsave);
	pstmte.setString(6,sday);
	pstmte.setString(7,name);
	pstmte.setString(8,email);
	pstmte.setString(9,detail);
	pstmte.setInt(10,code);
	
}
pstmt.executeUpdate();
pstmte.executeUpdate();
pstmte.close();
pstmt.close();
con.close();


response.sendRedirect("p2_main.jsp");
%>