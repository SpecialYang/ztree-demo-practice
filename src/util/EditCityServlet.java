package util;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sun.org.apache.xalan.internal.xsltc.compiler.Template;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class EditCityServlet
 */
@WebServlet("/EditCityServlet")
public class EditCityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CityDAO c = new CityImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		Integer id      =  Integer.parseInt(request.getParameter("id"));
		String  city = request.getParameter("name");
		Integer pId = Integer.parseInt(request.getParameter("pId"));
		List<City> cities = c.findTypeChildrenById(pId);
		String msg ="";
		boolean flag = true;   //成功或者失败的标志
		for(City  temp:cities){          //遍历孩子节点  看看名称是否重复
			if(temp.getCity().equals(city)){
				flag= false;
				break;
			}
		}
		if(flag){
			c.editCity(id, city);
			msg = "修改成功！";
		}
		else {
			msg = "修改失败，同一级下该名称已存在，请尝试修改为其它名称！";
		}
		JSONObject jO = new JSONObject();
		jO.put("msg", msg);
		jO.put("success", flag);
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
