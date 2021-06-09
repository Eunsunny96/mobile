<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
String url="jdbc:oracle:thin:@localhost:1521/xe";
String id="java";
String pw="java1234";
Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection(url, id, pw);
	String sql="select name from member where userid=? and passwd=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("userid"));
	pstmt.setString(2, request.getParameter("passwd"));
	rs=pstmt.executeQuery();
	String result="";
	JSONObject jsonObj=new JSONObject(); //json 객체
	if(rs.next()){  //로그인 성공
		jsonObj.put("name",rs.getString("name"));
	}else{ // 실패
		jsonObj.put("name","null");
	}
	out.clear();
	out.println(jsonObj);
	out.flush();
}catch(Exception e){
	e.printStackTrace();
}finally{
	try{
		if(rs!=null) rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	try{
		if(pstmt!=null) pstmt.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	try{
		if(conn!=null) conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
