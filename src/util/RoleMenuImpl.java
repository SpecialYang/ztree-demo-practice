package util;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.mysql.jdbc.PreparedStatement;

public class RoleMenuImpl implements RoleMenuDAO{

	@Override
	public List findMenuIdByRoleId(Integer roleId) {
		java.sql.Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	    List<Menu> menus = new ArrayList<Menu>();
		try{
			conn=DbUtil.getConnection();
			String sql="select * from menu where id in (select m_id from role_menu where r_id=? )" ;
			ps=(PreparedStatement) conn.prepareStatement(sql);
			ps.setInt(1,roleId);
			rs=ps.executeQuery();	
			while(rs.next()){
				 Menu ui = new Menu();
				 ui.setId(rs.getInt("id"));
				 ui.setName(rs.getString("name"));
		        menus.add(ui);
				}
		}catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}finally{
			DbUtil.closeAll(conn, ps, rs);
		}
		return menus;
	}
	
}
