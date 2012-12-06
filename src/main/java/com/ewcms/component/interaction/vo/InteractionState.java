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

/**
 *
 * @author wangwei
 */
public enum InteractionState {
    INIT("办理中"),BACK("回复");

    private String title;
    private InteractionState(String title){
        this.title = title;
    }

    public String getTitle(){
        return this.title;
    }
}
