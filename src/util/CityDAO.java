package util;

import java.util.List;

public interface CityDAO {
	public List findTypeChildrenById(Integer id);
	public void deleteCity(Integer id);
	public void editCity(Integer id, String city);
	public void addCity(Integer pId,String city);
}
