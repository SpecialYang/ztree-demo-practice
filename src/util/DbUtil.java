package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DbUtil {
	public static Connection getConnection()
	{
		Connection conn = null;
		try{
			//加载数据库驱动
			Class.forName("com.mysql.jdbc.Driver");
			//获取和数据库的链接
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/practice?useUnicode=true&characterEncoding=utf-8","root","123456");
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void closeAll(Connection conn,PreparedStatement ps,ResultSet rs)
	{
		try{
			rs.close();
			ps.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static void closeAll(Connection conn,PreparedStatement ps)
	{
		try{
			ps.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
