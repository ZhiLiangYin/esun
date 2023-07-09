<%@page contentType="text/html;charset=utf-8" language="java" import="java.sql.*"%>
<%@include file="config.jsp" %>
<style type="text/css">
.header{
  height: 30px;
  margin:0px;
  padding:0px;
}
.left,.center{
  height: 1500px;
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
			 sql = "SELECT * FROM `post` WHERE `postid` = '" + postid + "' " ;
             rs=  con.createStatement().executeQuery(sql);
			 while(rs.next()){			

		        out.println("原始內容: <br>");
			    out.println("文章編號:"+postid+"<br>");
                out.println("使用者編號:"+rs.getString(2)+"<br>");
                out.println("文章內容:"+rs.getString(3)+"<br>");
                out.println("發文時間:"+rs.getString(4)+"<br><hr>");


%>	
<form action="post_updatetosql.jsp?postid=<% out.print(postid); %>" method="POST">
修改內容:<br />
文章內容：<input type="text" name="context" /><br />

<input type="submit" name="b1" value="修改" />
<input type="reset" name="b1" value="重設">
</form>
<%			
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


    con.close();//結束資料庫連結
	
}
else{
	con.close();//結束資料庫連結
}
%>

