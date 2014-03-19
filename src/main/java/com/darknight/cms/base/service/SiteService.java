package com.darknight.cms.base.service;

import com.darknight.cms.base.entity.Site;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: DarKnight
 * Date: 13-11-17
 * Time: 下午5:06
 * To change this template use File | Settings | File Templates.
 */
public interface SiteService {
    public Site get(String siteId);
    public Site save(Site site);
    public List<Site> saveAll(List<Site> sites);
    public void delete(Site site);
    public void deleteAll(List<Site> sites);
    public Page<Site> findPageByMap(Map<String, Object> map, Pageable pageable);
}
