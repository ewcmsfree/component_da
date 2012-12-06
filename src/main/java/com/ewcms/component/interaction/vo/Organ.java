/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ewcms.component.interaction.vo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author wangwei
 */
public class Organ {
    private Integer id;
    private String name;
    private int backRatio;
    private int noBackRatio;
    private List<Organ> childer = new ArrayList<Organ>();

    public Organ(){
    }

    public Organ(int id){
        this.id = id;
    }

    public Organ(int id,String name){
        this.id = id;
        this.name = name;
    }
    
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

    public int getBackRatio() {
        return backRatio;
    }

    public void setBackRatio(int backRatio) {
        this.backRatio = backRatio;
    }

    public int getNoBackRatio() {
        return noBackRatio;
    }

    public void setNoBackRatio(int noBackRatio) {
        this.noBackRatio = noBackRatio;
    }

    public List<Organ> getChilder() {
        return childer;
    }

    public void setChilder(List<Organ> childer) {
        this.childer = childer;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Organ other = (Organ) obj;
        if (this.id != other.id && (this.id == null || !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 79 * hash + (this.id != null ? this.id.hashCode() : 0);
        return hash;
    }
}
