package com.qf.oa.controller;

import com.qf.oa.entity.Role;
import com.qf.oa.service.IRoleService;
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
 * @Time 2018/11/3 16:06
 * @Version 1.0
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

    @Autowired
    private IRoleService roleService;

    /**
     * 查询角色
     *
     * @param page
     * @param model
     * @return
     */
    @RequiresPermissions("/role/list")
    @RequestMapping("/list")
    public String roleList(Page page, Model model) {
        List<Role> roles = roleService.queryAll();
        model.addAttribute("roles", roles);
        return "rolelist";
    }

    /**
     * ajax查询角色信息（方案一）
     *
     * @return
     */
    @RequestMapping("/listAjax")
    @ResponseBody
    public List<Role> roleListAjax() {
        List<Role> roles = roleService.queryAll();
        return roles;
    }

    /**
     * ajax查询角色信息（方案二）
     *
     * @return
     */
    @RequestMapping("/listAjax2")
    @ResponseBody
    public List<Role> roleListAjax2(Integer eid) {
        List<Role> roles = roleService.queryAllByEid(eid);
        return roles;
    }

    /**
     * 添加或修改角色
     *
     * @param role
     * @return
     */
    @RequiresPermissions("/role/saveorupdate")
    @RequestMapping("/saveorupdate")
    public String saveOrUpdate(Role role) {
        roleService.saveOrUpdate(role);
        return "redirect:/role/list";
    }


    /**
     * 删除角色
     *
     * @param id
     * @return
     */
    @RequiresPermissions("/role/delete")
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        roleService.delete(id);
        return "redirect:/role/list";
    }

    /**
     * 修改角色权限
     *
     * @param rid
     * @param reids
     * @return
     */
    @RequiresPermissions("/role/saveorupdate")
    @RequestMapping("/updateresc")
    @ResponseBody
    public Integer updateResc(Integer rid, Integer[] reids) {
        roleService.updateResc(rid, reids);
        return 1;
    }
}
