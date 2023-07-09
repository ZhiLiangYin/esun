<%@page contentType="text/html;charset=utf-8" language="java" import="java.sql.*"%>
<%@include file="config.jsp" %>
<style type="text/css">
.header{
  height: 30px;
  margin:0px;
  padding:0px;
}
.left,.center{
  height: 2000px;
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
<p align="right">哈囉，<%=userid%>，<a href='index.html'>登出</a></p><br />
</div>

	<%

try {
    Class.forName("com.mysql.jdbc.Driver");
    try {
           sql="USE `esun`";//選擇資料庫 
           con.createStatement().execute(sql);
           sql="SELECT * FROM `post`"; //算出共幾筆留言
           rs=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY).executeQuery(sql);
		    
           rs.last();
           int total_content=rs.getRow();
           out.println("共"+total_content+"筆文章<p>");
		   %>
		   
		   <p><a href='post_add.jsp'>新增其他文(+)</a></p>  
		   
		   <%
            //每頁顯示5筆, 算出共幾頁
           int page_num=(int)Math.ceil((double)total_content/5.0); //無條件進位
           
           //使用超連結方式, 呼叫自己, 使用get方式傳遞參數(變數名稱為page)
				for(int i=1;i<=page_num;i++) 
					out.print("<a href='post.jsp?page="+i+"'>"+i+"</a>&nbsp;");
				out.println("<p>");
           //讀取page變數
				String page_string = request.getParameter("page");
				if (page_string == null) 
					page_string = "0";          
				int current_page=Integer.valueOf(page_string);
				if(current_page==0) //若未指定page, 令current_page為1
					current_page=1;
				if(current_page!=1) 
					out.print("<a href='post.jsp?page=1'>"+"第一頁</a>&nbsp;"); //&nbsp;html的空白
				if(current_page>1) 
					out.print("<a href='post.jsp?page="+(current_page-1)+"'>"+"上一頁</a>&nbsp;"); //&nbsp;html的空白
				if(current_page<page_num){
					out.print("<a href='post.jsp?page="+(current_page+1)+"'>"+"下一頁</a>&nbsp;"); //&nbsp;html的空白
					out.print("<a href='post.jsp?page="+page_num+"'>"+"最後一頁</a>&nbsp;"); //&nbsp;html的空白
				}
				if(current_page>page_num)
					current_page=1;
				out.println("共"+page_num+"頁，目前在第"+current_page+"頁");
				out.println("<form name='f' action='post.jsp' method='POST'>跳至<input type='text' size='3' name='page' value=1>頁<input type='submit' value='送出'>");
				out.println("</form><hr>");
	       //計算開始記錄位置   
		   
		   
//Step 5: 顯示結果 
           int start_record=(current_page-1)*5;
           //遞減排序, 讓最新的資料排在最前面
           sql="SELECT * FROM `post` ORDER BY `postid` DESC LIMIT ";
           sql+=start_record+",5";
		   rs=con.createStatement().executeQuery(sql);
// current_page... SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT
//      current_page=1: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 0, 5
//      current_page=2: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 5, 5
//      current_page=3: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 10, 5
           rs=con.createStatement().executeQuery(sql);
//  逐筆顯示, 直到沒有資料(最多還是5筆)
           while(rs.next())
                {
                 out.println("文章編號："+rs.getString(1)+"<br>");
                 out.println("使用者編號："+rs.getString(2)+"<br>");
                 out.println("文章內容："+rs.getString(3)+"<br>");
                 out.println("發文時間："+rs.getString(4)+"<br>");
				 if (userid.equals( rs.getString(2) ) ) {
					 out.println("<p><a href='post_update.jsp?postid="+ rs.getString(1) +"'>修改文章</a> <a href='post_delete.jsp?postid="+ rs.getString(1) +"'>刪除文章</a> </p><hr>") ;
				 }		
				 else {
					 out.println("<p></p><hr>") ;
				 }
				 %>

				 <%
				 
				 
				 
				 
				 
				 
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