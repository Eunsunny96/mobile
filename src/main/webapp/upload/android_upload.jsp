<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>    
<%
String upload_path="c:/upload"; //파일을 업로드할 디렉토리
int size=10*1024*1024; //파일 업로드 최대 용량
try{
	MultipartRequest multi=new MultipartRequest(request, upload_path,
			size, "utf-8", new DefaultFileRenamePolicy());
	String name="";
	String fileName="";
	Enumeration<?> files=multi.getFileNames();
	if(files.hasMoreElements()){ //다음 요소가 있으면
		name=(String)files.nextElement();  // 다음 요소를 읽음
		fileName=multi.getFilesystemName(name); //첨부 파일의 이름
	}
	out.println("success! fileName:"+fileName);
}catch(Exception e){
	e.printStackTrace();
}
%>