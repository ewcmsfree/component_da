/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.interaction.web;

import com.ewcms.component.interaction.vo.Interaction;
import com.ewcms.component.vo.Page;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class SearchAction extends IndexAction {

	private static final long serialVersionUID = 1619837012285739558L;

	private String title;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Override
    public String execute() {
        if (title == null || title.trim().length() == 0) {
            interactions = new ArrayList<Interaction>();
            page = new Page.Builder(0, 1).build();
            return SUCCESS;
        } else {
            String[] titles = titleArray();
            FindType findType = FindType.values()[type];
            page = constractPage(findType, titles);
            interactions = findInteractions(findType, titles);

            return SUCCESS;
        }
    }

    private List<Interaction> findInteractions(FindType findType, String[] titles) {

        if (findType == FindType.ALL) {
            return interactionService.findInteractionByTitle(titles, pageNumber, row);
        }
        if (findType == FindType.REPLAY) {
            return interactionService.findInteractionByTitleReplay(titles, true, pageNumber, row);
        }
        if (findType == FindType.NOREPLAY) {
            return interactionService.findInteractionByTitleReplay(titles, false, pageNumber, row);
        }
        return new ArrayList<Interaction>();
    }

    private Page constractPage(FindType findType, String[] titles) {
        int count = 0;
        if (findType == FindType.ALL) {
            count = interactionService.findInteractionByTitleCount(titles);
        }
        if (findType == FindType.REPLAY) {
            count = interactionService.findInteractionByTitleReplayCount(titles, true);
        }
        if (findType == FindType.NOREPLAY) {
            count = interactionService.findInteractionByTitleReplayCount(titles, false);
        }

        return new Page.Builder(count, pageNumber + 1).setPageSize(row).build();
    }

    private String[] titleArray() {

        String value = title;
        value = value.trim();
        value.replace(',', ' ');
        String[] array = value.split(" ");

        return array;
    }
}
