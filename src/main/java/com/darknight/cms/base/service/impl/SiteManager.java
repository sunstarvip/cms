package com.darknight.cms.base.service.impl;

import com.darknight.cms.base.dao.SiteDao;
import com.darknight.cms.base.entity.Site;
import com.darknight.cms.base.service.SiteService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: DarKnight
 * Date: 13-11-17
 * Time: 下午5:14
 * To change this template use File | Settings | File Templates.
 */
@Component
@Transactional(readOnly = true)
public class SiteManager implements SiteService{
    private static Logger logger = LoggerFactory.getLogger(SiteManager.class);
    private SiteDao siteDao;

    public void setSiteDao(SiteDao siteDao) {
        this.siteDao = siteDao;
    }

    @Override
    public Site get(String siteId) {
        Site site = null;
        if(StringUtils.isNotBlank(siteId)) {
            site = siteDao.findOne(siteId);
        }else {
            logger.debug("SiteManager.get()传入的站点ID为null或空白字符串");
        }
        return site;
    }

    @Override
    @Transactional(readOnly = false)
    public Site save(Site site) {
        if(site != null) {
            siteDao.saveAndFlush(site);
        }else {
            logger.debug("SiteManager.save()传入的站点Site为null");
        }
        return site;
    }

    @Override
    @Transactional(readOnly = false)
    public List<Site> saveAll(List<Site> sites) {
        if(!sites.isEmpty()) {
            siteDao.save(sites);
            siteDao.flush();
        }else {
            logger.debug("SiteManager.saveAll()传入的站点List sites为empty");
        }
        return sites;
    }

    @Override
    @Transactional(readOnly = false)
    public void delete(Site site) {
        if(site != null) {
            siteDao.delete(site);
            siteDao.flush();
        }else {
            logger.debug("SiteManager.delete()传入的站点Site为null");
        }
    }

    @Override
    @Transactional(readOnly = false)
    public void deleteAll(List<Site> sites) {
        if(!sites.isEmpty()) {
            siteDao.delete(sites);
            siteDao.flush();
        }else {
            logger.debug("SiteManager.deleteAll()传入的站点List sites为empty");
        }
    }

    @Override
    public Page<Site> findPageByMap(Map<String, Object> map, Pageable pageable) {
        return siteDao.queryPageByMap(map, pageable);
    }
}
