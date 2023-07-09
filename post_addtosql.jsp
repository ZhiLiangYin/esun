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
request.setCharacterEncoding("UTF-8");
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


              if( request.getParameter("context") != null && !request.getParameter("context").equals("") ){		
                String postid=request.getParameter("postid");
				//String user=request.getParameter("userid");
				String context=request.getParameter("context");
                String post_date=request.getParameter("time");
				 
				
			    sql="insert `post` (`postid`,`userid`,`content`,`time`) values ("+ postid + ", '"+ userid + "', '" + context + "', '" + post_date + "' )" ;     
				//out.print(sql);
                con.createStatement().executeUpdate(sql);
			  
				out.println("文章新增成功"+"<br>");
			  
				sql = "SELECT * FROM `post` WHERE `postid` = '" + postid + "' " ;
				
				rs=  con.createStatement().executeQuery(sql);
				while(rs.next()){		
				  out.println("文章編號："+postid+"<br>");
				  out.println("使用者編號："+rs.getString(2)+"<br>");
				  out.println("文章內容："+rs.getString(3)+"<br>");
				  out.println("發文時間："+rs.getString(4)+"<br><hr>");
				}
				
				%><a href="post.jsp">首頁</a>
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

    con.close();//結束資料庫連結
	
}
else{
	con.close();//結束資料庫連結
}
%>