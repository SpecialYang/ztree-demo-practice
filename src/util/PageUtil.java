package util;
public class PageUtil {
	public static Integer getPageNo(int pageNo,int pageSize){
		if (pageNo != 0) {// 获取页数
			pageNo = pageNo / pageSize;
		}
		pageNo += 1;
		return pageNo;
	}
}
