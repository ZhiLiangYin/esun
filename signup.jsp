<%@page contentType="text/html;charset=utf-8" language="java" import="java.sql.*"%>
<%@include file="config.jsp" %>
<%
	sql = "SELECT MAX(`userid`)  FROM `user` ";
	ResultSet rs=  con.createStatement().executeQuery(sql);
	rs.next();
	int userid=rs.getInt(1)+1;
    //con.close();//結束資料庫連結
    
   
	%>
	


<form action="user_addtosql.jsp" method="POST">
使用者編號：<input type="text" name="userid" value=<%=userid%> readonly /><br />
使用者名稱：<input type="text" name="username" /><br />
email：<input type="text" name="email" /><br />
密碼：<input type="password" name="password" /><br />
自我介紹：<input type="text" name="bio" /><br />
<input type="submit" name="b1" value="新增" />
<input type="reset" name="b1" value="重設">
</form>


