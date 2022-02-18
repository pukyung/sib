package pj;

import java.io.IOException;

public class Util {
	
	public static String change( String a ) {
		try {
			byte[] bs = a.getBytes("8859_1");
			a = new String( bs, "utf-8" );
		}
		catch( IOException e ) {}
		return a;
	}
	
	public static String upload() {
		String t = System.getProperty("os.name");
		String upload = "/pukyung23/upload/project/";
		if( t.indexOf("indows") != -1 ) {
			upload = "C:\\upload\\project\\";
		}
		return upload;
	}
}
