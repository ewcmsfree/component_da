/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.vo;

/**
 *
 * @author wangwei
 */
public class Page {

    private Builder builder;

    public static class Builder {

        private static final int DEFAULT_PAGE_SIZE = 10;
        private static final int DEFAULT_PAGE_MAX = 100;
        private static final int DEFAULT_PAGE_LIST_SIZE = 10;
        private int count;
        private int page;
        private int pageCount;
        private int pageMax = DEFAULT_PAGE_MAX;
        private int pageSize = DEFAULT_PAGE_SIZE;
        private int pageListSize = DEFAULT_PAGE_LIST_SIZE;

        public Builder(final int count, final int page) {
            this.count = count;
            this.page = page;
        }

        public Builder setPageSize(int pageSize) {
            this.pageSize = pageSize;
            return this;
        }

        public Builder setPageMax(int pageMax) {
            this.pageMax = pageMax;
            return this;
        }

        public Builder setPageListSize(int pageListSize) {
            this.pageListSize = pageListSize;
            return this;
        }

        public int getPage() {
            return page ;
        }

        public int getPageSize() {
            return pageSize;
        }

        public int getPageCount() {
            return pageCount;
        }

        public int getPageNext() {
            int next = page + 1;
            return next > pageCount ? -1 : next;
        }

        public int getPagePrev() {
            int prev = page - 1;
            return prev < 1 ? -1 : prev;
        }

        public int[] getPageListAll() {
            int[] pages = new int[pageCount];
            for (int i = 0; i < pageCount; i++) {
                pages[i] = i + 1;
            }
            return pages;
        }

        public int[] getPageList() {
            int start = page - (pageListSize / 2);
            start = (start <= 0 ? 0 : start);
            int length = pageCount - start;
            length = (length > pageListSize ? pageListSize : length);
            if (length < pageListSize && pageCount > pageListSize) {
                start = pageCount - pageListSize;
                length = pageListSize;
            }
            int[] pages = new int[length];
            for (int i = 0; i < length; i++) {
                pages[i] = start + i + 1;
            }
            return pages;
        }

        public Page build() {
            pageCount = (count + pageSize - 1) / pageSize;
            pageCount = (pageCount == 0 ? 1 : pageCount);
            pageCount = (pageCount > pageMax ? pageMax : pageCount);
            page = (page > pageCount ? pageCount : page);
            return new Page(this);
        }
    }

    private Page(Builder builder) {
        this.builder = builder;
    }

    public int getPage() {
        return builder.getPage();
    }

    public int getPageSize() {
        return builder.getPageSize();
    }

    public int getPageCount() {
        return builder.getPageCount();
    }

    public int getPageNext() {
        return builder.getPageNext();
    }

    public int getPagePrev() {
        return builder.getPagePrev();
    }

    public int[] getPageListAll() {
        return builder.getPageListAll();
    }

    public int[] getPageList() {
        return builder.getPageList();
    }
}
