package webview;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webview.dao.MemberDAO;
import webview.dto.MemberDTO;

@WebServlet("/webview_servlet/*")
public class WebviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url=request.getRequestURI().toString();
		MemberDAO dao=new MemberDAO();
		if(url.indexOf("login.do")!=-1) {
			String userid=request.getParameter("userid");
			String passwd=request.getParameter("passwd");
			String result="";
			MemberDTO dto=new MemberDTO();
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			MemberDTO output=dao.loginCheck(dto);
			if(output==null) {
				result="로그인 실패...";
			}else {
				result=output.getName()+"님 환영합니다.";
			}
			request.setAttribute("result", result);
			String page="/webview/login_result.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
