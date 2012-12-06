/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.online.vo;

import java.io.Serializable;
import java.util.List;

/**
 * 事项基本信息
 * 
 * <ul>
 * <li>id:编号</li>
 * <li>name:名称</li>
 * <li>acceptedWay:受理方式</li>
 * <li>handleSite:办理地点</li>
 * <li>handleBasis:办理依据</li>
 * <li>handleWay:审批、服务数量及方式</li>
 * <li>acceptedCondition:受理条件</li>
 * <li>petitionMaterial:申请材料</li>
 * <li>handleCourse:办理程序</li>
 * <li>timeLimit:法定时限</li>
 * <li>deadline:承诺期限</li>
 * <li>fees:收费标准</li>
 * <li>feesBasis:收费依据</li>
 * <li>consultingTel:咨询电话</li>
 * <li>contactName:联系人</li>
 * <li>department:所在部门</li>
 * <li>contactTel:联系电话</li>
 * <li>email:E-Mail</li>
 * <li>organ:组织机构对象</li>
 * <li>matterAnnexs:事项附件</li>
 * <li>citizens:公民对象</li>
 * </ul>
 * 
 * @author 吴智俊
 */
public class Matter implements Serializable {

	private static final long serialVersionUID = 473196717799783359L;

	private Integer id;
    private String name;
    private String acceptedWay;
    private String handleSite;
    private String handleBasis;
    private String handleWay;
    private String acceptedCondition;
    private String petitionMaterial;
    private String handleCourse;
    private String timeLimit;
    private String deadline;
    private String fees;
    private String feesBasis;
    private String consultingTel;
    private String contactName;
    private String department;
    private String contactTel;
    private String email;
    private Organ organ;
    private List<MatterAnnex> matterAnnexs;

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

    public String getAcceptedWay() {
        return acceptedWay;
    }

    public void setAcceptedWay(String acceptedWay) {
        this.acceptedWay = acceptedWay;
    }

    public String getHandleSite() {
        return handleSite;
    }

    public void setHandleSite(String handleSite) {
        this.handleSite = handleSite;
    }

    public String getHandleBasis() {
        return handleBasis;
    }

    public void setHandleBasis(String handleBasis) {
        this.handleBasis = handleBasis;
    }

    public String getHandleWay() {
        return handleWay;
    }

    public void setHandleWay(String handleWay) {
        this.handleWay = handleWay;
    }

    public String getAcceptedCondition() {
        return acceptedCondition;
    }

    public void setAcceptedCondition(String acceptedCondition) {
        this.acceptedCondition = acceptedCondition;
    }

    public String getPetitionMaterial() {
        return petitionMaterial;
    }

    public void setPetitionMaterial(String petitionMaterial) {
        this.petitionMaterial = petitionMaterial;
    }

    public String getHandleCourse() {
        return handleCourse;
    }

    public void setHandleCourse(String handleCourse) {
        this.handleCourse = handleCourse;
    }

    public String getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(String timeLimit) {
        this.timeLimit = timeLimit;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    public String getFees() {
        return fees;
    }

    public void setFees(String fees) {
        this.fees = fees;
    }

    public String getFeesBasis() {
        return feesBasis;
    }

    public void setFeesBasis(String feesBasis) {
        this.feesBasis = feesBasis;
    }

    public String getConsultingTel() {
        return consultingTel;
    }

    public void setConsultingTel(String consultingTel) {
        this.consultingTel = consultingTel;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getContactTel() {
        return contactTel;
    }

    public void setContactTel(String contactTel) {
        this.contactTel = contactTel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Organ getOrgan() {
        return organ;
    }

    public void setOrgan(Organ organ) {
        this.organ = organ;
    }

    public List<MatterAnnex> getMatterAnnexs() {
        return matterAnnexs;
    }

    public void setMatterAnnexs(List<MatterAnnex> matterAnnexs) {
        this.matterAnnexs = matterAnnexs;
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
        Matter other = (Matter) obj;
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
