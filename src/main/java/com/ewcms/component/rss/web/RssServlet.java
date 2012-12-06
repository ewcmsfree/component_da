/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.rss.web;

import com.ewcms.component.rss.service.RssService;
import com.ewcms.component.rss.vo.Channel;
import com.ewcms.component.rss.vo.Item;
import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.text.SimpleDateFormat;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 *
 * @author wangwei
 */
public class RssServlet extends HttpServlet {

	private static final long serialVersionUID = 5977480428740059838L;

	private static final String XML_TYPE = "text/xml";
    private static final String DEFAULT_ENCODING = "UTF-8";
    private static final Integer DEFAULT_ROW = 12;
    private static final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String encoding = DEFAULT_ENCODING;
        initResponseHeader(response, encoding);
        String value = getParameterValue(request, "id");
        String rss = "";
        try {
            int id = Integer.valueOf(value);
            String dns = request.getServerName();
            rss = constructRss(id, dns);
        } catch (Exception e) {
            StringBuilder builder = new StringBuilder();
            builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>  ");
            builder.append("<rss version=\"2.0\">");
            builder.append("</xml>");
            rss = builder.toString();
        }
        Writer writer = response.getWriter();
        writer.write(rss);
        writer.flush();
    }

    private String getParameterValue(HttpServletRequest request, final String parameter) {
        return request.getParameter(parameter);
    }

    private String constructRss(Integer id, String dns) {
        StringBuilder builder = new StringBuilder();
        builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        builder.append("<rss version=\"2.0\">");
        builder.append("<channel>");
        RssService service = getRssService();
        String cRss = channelRss(service, id, dns);
        if (cRss != null) {
            builder.append(cRss);
            builder.append(itemRss(service, id, dns));
        }
        builder.append("</channel>");
        builder.append("</rss>");

        return builder.toString();
    }

    private String channelRss(RssService service, Integer id, String dns) {
        Channel channel = service.getChannel(id);
        if (channel == null) {
            return "";
        }
        StringBuilder builder = new StringBuilder();
        builder.append("<title>").append(channel.getTitle()).append("</title>");
        builder.append("<link>http://").append(dns).append(channel.getUrl()).append("</link>");
        builder.append("<description>").append(channel.getUrl()).append("</description>");
        builder.append("<language>zh-cn</language>");
        builder.append("<copyright></copyright>");
        builder.append("<generator>").append(dns).append("RSS Generator</generator>");

        return builder.toString();
    }

    private String itemRss(RssService service, Integer id, String dns) {
        List<Item> items = service.findItemByChannel(id, DEFAULT_ROW);
        StringBuilder builder = new StringBuilder();
        for (Item item : items) {
            builder.append("<item>");
            builder.append("<title>").append(item.getTitle()).append("</title>");
            builder.append("<link>http://").append(dns).append(item.getUrl()).append("</link>");
            builder.append("<description>").append(item.getDescription()).append("</description>");
            builder.append("<category></category>");
            builder.append("<author></author>");
            builder.append("<copyright></copyright>");
            builder.append("<pubDate>").append(format.format(item.getPublished())).append("</pubDate>");
            builder.append("</item>");
        }

        return builder.toString();
    }

    private void initResponseHeader(final HttpServletResponse response, final String encoding) {
        response.setHeader("Content-Language", "zh-CN");
        String fullContentType = XML_TYPE + ";charset=" + encoding;
        response.setContentType(fullContentType);
    }

    private RssService getRssService() {
        ServletContext application = getServletContext();
        WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(application);
        return (RssService) wac.getBean("rssService");
    }
}
