<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="org.jdom.*" %>
<%@ page import="org.jdom.output.*" %>
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
	Element root=new Element("books"); //root node
	Document doc=new Document(root); //xml 파일에 root node 추가
	doc.setRootElement(root);
	while(rs.next()){
		Element data=new Element("book"); //tag
		Element book_code=new Element("book_code"); //child tag
		book_code.setText(rs.getString("book_code")); //태그에 텍스트 추가
		Element book_name=new Element("book_name");
		book_name.setText(rs.getString("book_name"));
		Element press=new Element("press");
		press.setText(rs.getString("press"));
		Element price=new Element("price");
		price.setText(rs.getString("price"));
		Element amount=new Element("amount");
		amount.setText(rs.getString("amount"));
		data.addContent(book_code); //parent 태그에 child 태그 추가
		data.addContent(book_name);
		data.addContent(press);
		data.addContent(price);
		data.addContent(amount);
		root.addContent(data); // xml 문서에 태그 추가
	}
	XMLOutputter xout=new XMLOutputter(); //xml 출력 객체
	Format f=xout.getFormat();
	f.setEncoding("utf-8"); 
	f.setIndent("\t"); //들여쓰기
	f.setLineSeparator("\r\n"); //줄바꿈 처리
	f.setTextMode(Format.TextMode.TRIM); //공백제거
	xout.setFormat(f);
	String result=xout.outputString(doc);
	out.clear();
	out.print(result); //xml 문자열이 화면에 출력됨
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
