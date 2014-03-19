package com.darknight.cms.base.entity;

import com.darknight.cms.util.Parameter;
import com.xqlc.core.orm.entity.IdEntity;

import javax.persistence.*;

/**
 * Created with IntelliJ IDEA.
 * User: DarKnight
 * Date: 13-11-17
 * Time: 下午4:48
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "t_cms_base_content")
public class Content extends IdEntity {
    private String title; //标题(内容标题)
    private String subTitle; //副标题
    private String contentBody; //新闻正文
    private int visitNum = VisitNum.VISIT_START;
    private String templatePath;
    private String usableTag = UsableTag.USEABLE;

    private Site site;
    private Category category;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubTitle() {
        return subTitle;
    }

    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }

    @Lob
    public String getContentBody() {
        return contentBody;
    }

    public void setContentBody(String contentBody) {
        this.contentBody = contentBody;
    }

    public int getVisitNum() {
        return visitNum;
    }

    public void setVisitNum(int visitNum) {
        this.visitNum = visitNum;
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
    @JoinColumn(name = "category_id")
    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public interface VisitNum {
        int VISIT_START = Parameter.VISIT_START;
    }

    public interface UsableTag {
        String USEABLE = Parameter.USEABLE;
        String USELESS = Parameter.USELESS;
    }
}
