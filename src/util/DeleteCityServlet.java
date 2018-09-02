package util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class DeleteCityServlet
 */
@WebServlet("/DeleteCityServlet")
public class DeleteCityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CityDAO c = new CityImpl();  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idStirng = request.getParameter("ids");
		String id[] = idStirng.split(",");
		int ids[] = new int[id.length];
		for(int i=0;i<id.length;i++)
			ids[i]=Integer.parseInt(id[i]);
		String msg = "删除失败！";
		boolean flag = false;
		for(int temp : ids){
				c.deleteCity(temp);
				msg = "删除成功";
				flag=true;
		}
		JSONObject jO = new JSONObject();
		jO.put("success", flag);
		jO.put("msg", msg);
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
