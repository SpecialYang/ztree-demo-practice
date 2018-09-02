package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoleImpl implements RoleDAO{

	@Override
	public Page findAllRole(int pageNo,int pageSize) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Page page = new Page();
		List<Role> list = new ArrayList<Role>();
		try{
			conn = DbUtil.getConnection();
			String sql = "select count(*) from role";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				page.setTotal(rs.getInt(1));
			}
			String sql2 = "select * from role limit ?,?";
			ps = conn.prepareStatement(sql2);
			ps.setInt(1,(pageNo-1)*pageSize);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			while(rs.next())
			{
				Role e = new Role();
				e.setId(rs.getInt("r_id"));
				e.setName(rs.getString("r_name"));
				list.add(e);
			}
			page.setRows(list);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DbUtil.closeAll(conn, ps, rs);
		}
		return page;
	}
	
}
