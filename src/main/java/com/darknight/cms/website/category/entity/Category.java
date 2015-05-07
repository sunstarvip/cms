package com.darknight.cms.website.category.entity;

import com.darknight.core.base.entity.DefaultEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CMS系统栏目对象
 * Created by DarKnight on 2015/4/22.
 */
@Entity
@DynamicInsert()
@DynamicUpdate()
@Table(name = "t_cms_category")
public class Category extends DefaultEntity {
    /**
     * 栏目名称
     */
    private String name;
    /**
     * 栏目描述
     */
    private String description;

    /**
     * 父级栏目
     */
    private Category parent;
    /**
     * 子级栏目
     */
    private List<Category> children = new ArrayList<>();

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @ManyToOne
    @JoinColumn(name = "parent_id", referencedColumnName = "id")
    public Category getParent() {
        return parent;
    }

    public void setParent(Category parent) {
        this.parent = parent;
    }

    @OneToMany(mappedBy = "parent")
//    @OrderBy("createTime")
    public List<Category> getChildren() {
        return children;
    }

    @JsonIgnore
    public void setChildren(List<Category> children) {
        this.children = children;
    }
}
