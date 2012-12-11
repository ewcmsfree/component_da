/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexUtil {
	
	private final static String REGEX_SCRIPT = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>";
	private final static String REGEX_STYLE = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>";
	private final static String REGEX_HTML = "<[^>]+>";
	
	public static String FilterScriptAndStyle(String content){
		if (content == null) return null;
		if (content.isEmpty()) return "";
		
		Pattern p_script = Pattern.compile(REGEX_SCRIPT, Pattern.CASE_INSENSITIVE);
		Matcher m_script = p_script.matcher(content);
		content = m_script.replaceAll("");
		
		Pattern p_style = Pattern.compile(REGEX_STYLE, Pattern.CASE_INSENSITIVE);
		Matcher m_style = p_style.matcher(content);
		content = m_style.replaceAll("");
		
		return content;
	}
	
	public static String FilterHtml(String content){
		content = FilterScriptAndStyle(content);
		
		Pattern p_html = Pattern.compile(REGEX_HTML, Pattern.CASE_INSENSITIVE);
		Matcher m_html = p_html.matcher(content);
		
		return m_html.replaceAll("");
	}
	
//	public static void main(String[] args){
//		System.out.println(FilterScriptAndStyle("http://localhost:8080/main.js?callback=<script>alert('12345');</script>"));
//		System.out.println(FilterScriptAndStyle("http://localhost:8080/main.js?callback=&lg;script&lt;alert('12345');&lt;/script&lg;"));
//		System.out.println(FilterScriptAndStyle("http://localhost:8080/main.js?callback=abc"));
//		System.out.println("-1-" + FilterScriptAndStyle(null));
//		System.out.println("-2-" + FilterScriptAndStyle(""));
//	}
}
