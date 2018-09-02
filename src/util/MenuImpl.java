package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MenuImpl  implements MenuDAO{

	@Override
	public List findTypeChildrenById(Integer id) {
		java.sql.Connection conn = null;
		java.sql.PreparedStatement ps = null;
		ResultSet rs = null;
		List<Menu> list =new ArrayList<Menu>();
		try{
			conn = DbUtil.getConnection();
			String sql = "select * from menu  where p_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			while(rs.next())
			{
				Menu e = new Menu();
				e.setId(rs.getInt("id"));
				e.setpId(rs.getInt("p_id"));
				e.setName(rs.getString("name"));
				list.add(e);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DbUtil.closeAll(conn, ps, rs);
		}
		return list;
	}

//	@Override
//	public void deleteCity(Integer id) {
//		Connection conn = null;
//		PreparedStatement ps = null;
//		try{   
//				conn = DbUtil.getConnection();
//				String sql = "delete from essaytype where id = ?";
//				ps = conn.prepareStatement(sql);
//				ps.setInt(1, id);
//				ps.execute();	
//			}catch(Exception e){
//				e.printStackTrace();
//			}finally{
//				DbUtil.closeAll(conn, ps);
//			}
//	}
//
//	@Override
//	public void editCity(Integer id, String city) {
//		Connection conn = null;
//		PreparedStatement ps = null;
//		try{   
//				conn = DbUtil.getConnection();
//				String sql = "update essaytype set province = ? where id = ?";
//				ps = conn.prepareStatement(sql);
//				ps.setString(1, city);
//				ps.setInt(2, id);
//				ps.execute();	
//			}catch(Exception e){
//				e.printStackTrace();
//			}finally{
//				DbUtil.closeAll(conn, ps);
//			}
//	}
//
//	@Override
//	public void addCity(Integer pId, String city) {
//		Connection conn = null;
//		PreparedStatement ps = null;
//		try{   
//				conn = DbUtil.getConnection();
//				String sql = "insert into essaytype(parent_id,province) values(?,?)";
//				ps = conn.prepareStatement(sql);
//				ps.setInt(1, pId);
//				ps.setString(2, city);
//				ps.execute();	
//			}catch(Exception e){
//				e.printStackTrace();
//			}finally{
//				DbUtil.closeAll(conn, ps);
//			}
//	
//	}
	
	
}
