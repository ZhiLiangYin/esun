<%@page contentType="text/html;charset=utf-8" language="java" import="java.sql.*, java.util.*"%>
<%@include file="config.jsp" %>
<%

try {
    Class.forName("com.mysql.jdbc.Driver");
    try {
		
		   con=DriverManager.getConnection(url,"root","up654xu;6");
		   if(con.isClosed())
              out.println("連線建立失敗");
           else {
			  
              sql="USE `esun`";//Step 3: 選擇資料庫 
              con.createStatement().execute(sql);
			  

//Step 4: 執行 SQL 指令	


              if( request.getParameter("username") != null && !request.getParameter("username").equals("") &&
				  request.getParameter("email") != null && !request.getParameter("email").equals("") &&
			      request.getParameter("password") != null && !request.getParameter("password").equals("") &&
				  request.getParameter("bio") != null && !request.getParameter("bio").equals("") ){		
				  
				 
				String userid=request.getParameter("userid");
				String username=request.getParameter("username");
                String email=request.getParameter("email");
				String password=request.getParameter("password");
                String bio=request.getParameter("bio");				
				
			    sql="insert `user` (`userid`,`username`,`email`,`password`,`bio` ) values ("+ userid + ", '"+ username + "', '" + email + "', '" + password + "', '" + bio + "' )" ;     
				//out.print(sql);
                con.createStatement().executeUpdate(sql);
			  
				out.println("註冊成功"+"<br>");
								%> <a href="index.html">首頁</a>
			 <%

			  }
			  else {
				  out.println("新增內容不符 !!") ;
			  }
			  
			  
//Step 6: 關閉連線
              con.close();
          }
		   
	}
    catch (SQLException sExec) {
           out.println("SQL錯誤"+sExec.toString());
		   
    }
}
catch (ClassNotFoundException err) {
      out.println("class錯誤"+err.toString());
}
%>