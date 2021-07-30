<%@ page  contentType="text/html;charset=utf-8" import="java.sql.*" %>
<%
//전체 만들어 보기
request.setCharacterEncoding("utf-8");		//URL 인코딩 : UTF-8. MySQL 인코딩 : utf8

String code =   request.getParameter("code");//1. 사용자가 입력한 idx 정보 가져오기

try {

	 //2.jdbc 클래스 드라이버 정의
	 
	Class.forName("org.mariadb.jdbc.Driver"); 
	String DB_URL ="jdbc:mariadb://localhost:3306/pagedata?useSSL=false";

	//3. 연결자정보 가져오기
	Connection con =  DriverManager.getConnection(DB_URL,"admin","1234");
	

	//4. DELETE 쿼리문 구성하기
	String sql = "DELETE FROM post WHERE code=?";
	
	//5. PreparedStatement 객체 생성하기
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//6. pstmt에  DELETE 쿼리문 구성하기
	pstmt.setInt(1,Integer.parseInt(code));

	//7. 쿼리문 실행
	pstmt.executeUpdate();

	//8. close하기
	pstmt.close();
	con.close();

}catch(ClassNotFoundException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}catch(Exception e) {
	out.print(e);
	return;
}

//9. 리스트출력 페이지로 이동시키기
response.sendRedirect("p2_main.jsp");
%>