package com.darknight.cms.base.entity;

import com.darknight.cms.util.Parameter;
import com.xqlc.core.orm.entity.IdEntity;

import javax.persistence.*;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: DarKnight
 * Date: 13-11-17
 * Time: 下午4:17
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "t_cms_base_category")
public class Category extends IdEntity {
    private String cname;
    private String ename;
    private int categorySort = CategorySort.SORT_START;
    private String templatePath;
    private String usableTag = UsableTag.USEABLE;

    private Site site;
    private Category parent;
    private List<Category> children;

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

    public int getCategorySort() {
        return categorySort;
    }

    public void setCategorySort(int categorySort) {
        this.categorySort = categorySort;
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

    @ManyToOne
    @JoinColumn(name = "site_id")
    public Site getSite() {
        return site;
    }

    public void setSite(Site site) {
        this.site = site;
    }

    @ManyToOne
    @JoinColumn(name = "pid")
    public Category getParent() {
        return parent;
    }

    public void setParent(Category parent) {
        this.parent = parent;
    }

    @OneToMany(targetEntity = Category.class, cascade = { CascadeType.ALL }, mappedBy = "parent")
    @OrderBy("categorySort asc")
    public List<Category> getChildren() {
        return children;
    }

    public void setChildren(List<Category> children) {
        this.children = children;
    }

    public interface CategorySort {
        int SORT_START = Parameter.SORT_START;
    }

    public interface UsableTag {
        String USEABLE = Parameter.USEABLE;
        String USELESS = Parameter.USELESS;
    }
}
