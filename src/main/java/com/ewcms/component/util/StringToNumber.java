/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.util;

/**
 * @author wuzhijun
 */
public class StringToNumber {
	public static Integer ToInteger(String id) throws Exception {
		return Integer.parseInt(id);
	}

	public static Long ToLong(String id) throws Exception {
		return Long.parseLong(id);
	}
}
