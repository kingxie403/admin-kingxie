package com.lte.util;

import org.springframework.http.MediaType;
import org.springframework.http.converter.StringHttpMessageConverter;

import java.nio.charset.Charset;

/**
 * Created by think on 2016/11/12.
 */
public class UTF8StringHttpMessageConverter extends StringHttpMessageConverter {
    private static final MediaType utf8 = new MediaType("text", "plain", Charset.forName("UTF-8"));

    @Override
    protected MediaType getDefaultContentType(String dumy) {
        return utf8;
    }
}
