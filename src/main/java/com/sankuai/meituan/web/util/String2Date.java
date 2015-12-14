package com.sankuai.meituan.web.util;


import org.springframework.core.convert.converter.Converter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by mashuai on 15/11/27.
 */
public class String2Date implements Converter<String,Date>{
    @Override
    public Date convert(String s) {
        Date date=null;
        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            date = (Date) dateFormat.parse(s);
        } catch (Exception e) {
        }
        return date;
    }
}
