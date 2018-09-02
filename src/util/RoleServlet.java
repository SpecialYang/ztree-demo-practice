package util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;



/**
 * Servlet implementation class RoleServlet
 */
@WebServlet("/RoleServlet")
public class RoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private RoleDAO rd = new RoleImpl();  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		Integer pageNo = request.getParameter("offset") == null ? 0
				: Integer.parseInt(request.getParameter("offset"));
		Integer pageSize = request.getParameter("limit") == null ? 10 
				: Integer.parseInt(request.getParameter("limit"));
		pageNo = PageUtil.getPageNo(pageNo, pageSize);
		
		Page page = new Page();
		page=rd.findAllRole(pageNo,pageSize);
		JSONObject jO = new JSONObject();
		jO.put("rows",page.getRows());
		jO.put("total", page.getTotal());
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().println(jO.toString());	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
