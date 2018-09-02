package util;

import java.io.Serializable;
import java.util.List;

public class Page implements Serializable {	
	private int total;
	private List rows;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List getRows() {
		return rows;
	}
	public void setRows(List rows) {
		this.rows = rows;
	}
	@Override
	public String toString() {
		return "Page [totalNumber=" + total + ", rows=" + rows + "]";
	}
	
}
