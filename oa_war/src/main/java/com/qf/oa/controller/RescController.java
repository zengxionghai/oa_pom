package com.qf.oa.controller;

import com.qf.oa.entity.Resc;
import com.qf.oa.service.IRescService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/4 14:03
 * @Version 1.0
 */
@Controller
@RequestMapping("/resc")
public class RescController extends BaseController {

    @Autowired
    private IRescService rescService;

    /**
     * 查询权限
     *
     * @param page
     * @param model
     * @return
     */
    @RequiresPermissions("/resc/list")
    @RequestMapping("/list")
    public String rescList(Page page, Model model) {
        List<Resc> rescs = rescService.queryAll();
        model.addAttribute("rescs", rescs);
        return "resclist";
    }

    /**
     * ajax查询权限
     * @return
     */
    @RequestMapping("/listajax")
    @ResponseBody
    public List<Resc> rescsListAjax(){
        List<Resc> rescs = rescService.queryAll();
        return rescs;
    }

    /**
     * ajax回显权限
     * @return
     */
    @RequestMapping("/listajax2")
    @ResponseBody
    public List<Resc> rescsListAjax2(Integer rid){
        List<Resc> rescs = rescService.queryAllByRid(rid);
        return rescs;
    }

    /**
     * 添加或修改权限
     *
     * @param resc
     * @return
     */
    @RequiresPermissions("/resc/saveorupdate")
    @RequestMapping("/saveorupdate")
    public String saveOrUpdate(Resc resc) {
        rescService.saveOrUpdate(resc);
        return "redirect:/resc/list";
    }

    /**
     * 删除权限
     * @param id
     * @return
     */
    @RequiresPermissions("/resc/delete")
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        rescService.delete(id);
        return "redirect:/resc/list";
    }
}
