<%
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://localhost/?serverTimezone=UTC";
Connection con=DriverManager.getConnection(url,"root","up654xu;6");
String sql="USE `esun`";
con.createStatement().execute(sql);
%>