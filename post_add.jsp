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
int puserid=0;
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
<p align="right">哈囉，<%=userid%>，<a href='index.html'>登出</a></p><br />
</div>

<%
	sql = "SELECT MAX(`postid`)  FROM `post` ";
	rs=  con.createStatement().executeQuery(sql);
	rs.next();
	puserid=rs.getInt(1)+1;
   con.close();//結束資料庫連結
   
   
   java.sql.Date post_date=new java.sql.Date(System.currentTimeMillis());
   
   
	%>
	


<form action="post_addtosql.jsp" method="POST">
文章編號：<input type="text" name="postid" value=<%=puserid%> readonly /><br />
使用者編號：<input type="text" name="userid" value=<%=userid%> readonly /><br />
文章內容(必填)：<input type="text" name="context" /><br />
發文時間：<input type="text" name="time" value=<%=post_date%> readonly /><br />


<input type="submit" name="b1" value="新增" />
<input type="reset" name="b1" value="重設">
</form>


	<%
}
else{
	con.close();//結束資料庫連結
}
%>
