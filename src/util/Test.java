package util;

import java.io.UnsupportedEncodingException;

public class Test {
	public static void main(String argus) throws UnsupportedEncodingException{
		String s1="中国";
		String s2=new String(s1.getBytes("ISO-8859-1"),"utf-8");
		System.out.println(s2);
	}
}
