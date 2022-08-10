/**
 *  Copyright 2015 ChinaSoft International Ltd. All rights reserved.
 */
package com.chinasofti.util.bean.convertor;
/**
 * <p>
 * Title: BooleanConvertor
 * </p>
 * <p>
 * Description: 将字符串数据转换为Boolean类型数据的工具
 * </p>
 * <p>
 * Copyright: Copyright (c) 2015
 * </p>
 * <p>
 * Company: ChinaSoft International Ltd.
 * </p>
 *
 * @author etc
 * @version 1.0
 */
public class BooleanConvertor implements TypeConvertor{

	/**
	 * 执行类型转换的方法
	 *
	 * @param srcString
	 *            原始数据值
	 * @return 转换后的结果数据
	 * */
	@Override
	public Object convertToObject(Object srcString) {
		// TODO Auto-generated method stub
		return new Boolean(srcString.toString());
	}

}
