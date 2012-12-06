/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.online.vo;

import java.io.Serializable;
import java.util.List;

/**
 * 网上办事主体
 * 
 * <ul>
 * <li>id:编号</li>
 * <li>name: 栏目名称</li>
 * </ul>
 * 
 * @author 吴智俊
 */
public class Working implements Serializable {

	private static final long serialVersionUID = -2176090511626720380L;

	private Integer id;
    private String name;
    private Integer parentId;
    private Organ organ;
    private Matter matter;
    private List<Working> children;
    private List<Article> articles;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Working> getChildren() {
        return children;
    }

    public void setChildren(List<Working> children) {
        this.children = children;
    }

    public Organ getOrgan() {
        return organ;
    }

    public void setOrgan(Organ organ) {
        this.organ = organ;
    }

    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parent) {
        this.parentId = parent;
    }

    public Matter getMatter() {
        return matter;
    }

    public void setMatter(Matter matter) {
        this.matter = matter;
    }
    
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        Working other = (Working) obj;
        if (id == null) {
            if (other.id != null) {
                return false;
            }
        } else if (!id.equals(other.id)) {
            return false;
        }
        return true;
    }
}
