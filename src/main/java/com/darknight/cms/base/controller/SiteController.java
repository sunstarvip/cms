package com.darknight.cms.base.controller;

import com.darknight.cms.base.entity.Site;
import com.darknight.cms.base.service.SiteService;
import com.xqlc.core.domain.PageSupport;
import com.xqlc.core.utils.WebUtils;
import com.xqlc.webapp.platform.account.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: DarKnight
 * Date: 13-11-17
 * Time: 下午6:54
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping(value = "/cms/site")
public class SiteController {
    private SiteService siteService;
    private UserService userService;

    @Autowired
    public void setSiteService(SiteService siteService) {

        this.siteService = siteService;
    }

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @ModelAttribute("site")
    public Site getSite(@RequestParam(value = "siteId", required = false) String siteId) {
        if (StringUtils.isNotEmpty(siteId)) {
            return siteService.get(siteId);
        }
        return new Site();
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(HttpServletRequest request, Model model, @PageableDefaults(10) Pageable pageable) {
//        Map<String, Object> map = WebUtils.getQueryParameter(request);
//        // 排序的用法
//        PageSupport pageSupport = new PageSupport(pageable, new Sort(Sort.Direction.ASC, "createTime"));
//        Page<Site> pageInfo = siteService.findPageByMap(map, pageSupport);
//        model.addAttribute("pageInfo", pageInfo);
//        model.addAllAttributes(map);
        return "/cms/base/site/siteList";
    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String create(Model model) {
        model.addAttribute("site", new Site());
        return "/cms/base/site/siteEdit";
    }

    @RequestMapping(value = "update", method = RequestMethod.GET)
    public String update(@PathVariable("siteId") String siteId, Model model) {
        Site site = siteService.get(siteId);
        model.addAttribute("site", site);
        return "/cms/base/site/siteEdit";
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@ModelAttribute("site") Site site) {
        siteService.save(site);
        return "redirect:/cms/site/list";
    }
}
