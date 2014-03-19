package com.darknight.cms.base.entity;

import com.darknight.cms.util.Parameter;
import com.xqlc.core.orm.entity.IdEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created with IntelliJ IDEA.
 * User: DarKnight
 * Date: 13-11-17
 * Time: 下午4:10
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "t_cms_base_site")
public class Site extends IdEntity {
    private String cname;
    private String ename;
    private int siteSort = SiteSort.SORT_START;
    private String templatePath;
    private String usableTag = UsableTag.USEABLE;

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public int getSiteSort() {
        return siteSort;
    }

    public void setSiteSort(int siteSort) {
        this.siteSort = siteSort;
    }

    public String getTemplatePath() {
        return templatePath;
    }

    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }

    public String getUsableTag() {
        return usableTag;
    }

    public void setUsableTag(String usableTag) {
        this.usableTag = usableTag;
    }

    public interface SiteSort {
        int SORT_START = Parameter.SORT_START;
    }

    public interface UsableTag {
        String USEABLE = Parameter.USEABLE;
        String USELESS = Parameter.USELESS;
    }
}
