package util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONObject;

/**
 * Servlet implementation class AddCityServlet
 */
@WebServlet("/AddCityServlet")
public class AddCityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CityDAO c = new CityImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer parentId = Integer.parseInt(request.getParameter("parentId"));
		String  city = request.getParameter("city");
		String msg ="";
		c.addCity(parentId, city);
		msg = "添加成功！";                     //我这里默认添加成功了，你可以设置异常，然后分情况
		JSONObject jO = new JSONObject();
		jO.put("success", true);
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
