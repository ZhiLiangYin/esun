<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@page contentType="text/html;charset=utf-8" language="java" import="java.sql.*"%>
<%@include file="config.jsp" %>
<%
if(request.getParameter("userid") != null && !request.getParameter("userid").equals("") && request.getParameter("password") != null && !request.getParameter("userid").equals("")){

    sql = "SELECT * FROM `user` WHERE `userid`=? AND `password`=?";
	
    PreparedStatement pstmt = null;
	pstmt=con.prepareStatement(sql);
    pstmt.setString(1,request.getParameter("userid"));
    pstmt.setString(2,request.getParameter("password"));
	
	ResultSet paperrs = pstmt.executeQuery();
	//ResultSet paperrs =con.createStatement().executeQuery(sql);
    
    if(paperrs.next()){            
        session.setAttribute("userid",request.getParameter("userid"));
		con.close();//結束資料庫連結
        response.sendRedirect("post.jsp") ;
    }
    else{
        con.close();//結束資料庫連結
	    out.println("密碼帳號不符 !! <a href='index.html'>按此</a>重新登入") ;
	}
}
else
	response.sendRedirect("index.html");
%>
