package cn.heckman.module.framework.pojo;

import java.util.Date;

public class TPermission {
    /**
     * 主键id
     */
    private Integer pId;

    /**
     * token值
     */
    private String pToken;

    /**
     * 链接url
     */
    private String pUrl;

    /**
     * 描述
     */
    private String pDescription;

    /**
     * 类型，1：菜单；2：操作
     */
    private String pType;

    /**
     * 添加时间
     */
    private Date pAddTime;

    /**
     * 状态（0：正常；1：删除）
     */
    private String pStatus;

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public String getpToken() {
        return pToken;
    }

    public void setpToken(String pToken) {
        this.pToken = pToken == null ? null : pToken.trim();
    }

    public String getpUrl() {
        return pUrl;
    }

    public void setpUrl(String pUrl) {
        this.pUrl = pUrl == null ? null : pUrl.trim();
    }

    public String getpDescription() {
        return pDescription;
    }

    public void setpDescription(String pDescription) {
        this.pDescription = pDescription == null ? null : pDescription.trim();
    }

    public String getpType() {
        return pType;
    }

    public void setpType(String pType) {
        this.pType = pType == null ? null : pType.trim();
    }

    public Date getpAddTime() {
        return pAddTime;
    }

    public void setpAddTime(Date pAddTime) {
        this.pAddTime = pAddTime;
    }

    public String getpStatus() {
        return pStatus;
    }

    public void setpStatus(String pStatus) {
        this.pStatus = pStatus == null ? null : pStatus.trim();
    }
}