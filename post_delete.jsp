<%@page contentType="text/html;charset=utf-8" language="java" import="java.sql.*, java.util.*"%>
<%@include file="config.jsp" %>
<style type="text/css">
.header{
  height: 30px;
  margin:0px;
  padding:0px;
}
.left,.center{
  height: 1000px;
  float:left;
}

.left{
  wuseridth: 90px;
}
.center{
  wuseridth: 1400px;

}
</style>
<%
if(session.getAttribute("userid") != null ){
    sql = "SELECT * FROM `user` WHERE `userid`='" +session.getAttribute("userid")+"';"; 
	ResultSet rs =con.createStatement().executeQuery(sql);
	String userid="", password="";
	//讀出userid, password當成使用者要更改時的內定值
	while(rs.next()){
	    userid=rs.getString("userid");
		password=rs.getString("password");
	}
	%>
<div class="header">
<p align="right">哈囉，<%=userid%>，<a href='login_cms.html'>登出</a></p><br />
</div>

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
			  
			  String postid = request.getParameter("postid");
			  String context=request.getParameter("context");
//Step 4: 執行 SQL 指令	.

              sql = "delete from `post` where `postid` = '" + postid + "' " ;
			  con.createStatement().executeUpdate(sql);
			  out.println("文章刪除成功"+"<br>");
			  
					%><a href="post.jsp">首頁</a>
			 <%


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

    con.close();//結束資料庫連結
	
}
else{
	con.close();//結束資料庫連結
}
%>