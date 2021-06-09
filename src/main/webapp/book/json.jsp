<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
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
	String sql="select * from book order by book_name";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	JSONObject jsonMain=new JSONObject(); //json 객체
	JSONArray jArray=new JSONArray(); //json 배열
	int count=0;
	while(rs.next()){ 
		JSONObject jsonObj=new JSONObject();
		// put(key,value)  "book_code" : 5
		jsonObj.put("book_code", rs.getString("book_code"));
		jsonObj.put("book_name", rs.getString("book_name"));
		jsonObj.put("press", rs.getString("press"));
		jsonObj.put("price", rs.getString("price"));
		jsonObj.put("amount", rs.getString("amount"));
		jArray.add(count, jsonObj); //json 배열에 json 객체 추가
		count++;
	}
	jsonMain.put("sendData", jArray); // json 배열 추가
	out.clear();
	out.println(jsonMain);
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
