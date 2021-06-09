<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script>
$(function(){
	login('kim','1234');
});
function login(userid,pwd){
	var param="userid="+userid+"&passwd="+pwd;
	$.ajax({
		type: "post",
		url: "${path}/webview_servlet/login.do",
		data: param,
		success: function(result){
			$("#result").html(result);
			window.android.setMessage(result); //서버의 실행결과를 앱에 전달 
		}
	});
}
</script>

</head>
<body>
<h2>웹뷰와의 통신</h2>
<div id="result"></div>
</body>
</html>













