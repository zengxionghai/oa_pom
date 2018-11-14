package com.qf.oa.controller;

import com.qf.oa.entity.Count;
import com.qf.oa.entity.Department;
import com.qf.oa.service.IDepService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/1 17:32
 * @Version 1.0
 */

@Controller
@RequestMapping("/dep")
public class DepController extends BaseController {

    @Autowired
    private IDepService depService;


    /**
     * 查询部门
     *
     * @param page
     * @param model
     * @return
     */
    @RequiresPermissions("/dep/list")
    @RequestMapping("/list")
    public String depList(Page page, Model model) {
        List<Department> deps = depService.queryAll();
        model.addAttribute("deps", deps);
        return "deplist";
    }

    @RequestMapping("/listAjax")
    @ResponseBody
    public List<Department> depListAjax() {
        List<Department> deps = depService.queryAll();
        return deps;
    }

    /**
     * 添加或者修改部门
     *
     * @param department
     * @return
     */
    @RequiresPermissions("/dep/saveorupdate")
    @RequestMapping("/saveorupdate")
    public String saveOrUpdate(Department department) {
        depService.saveOrUpdate(department);
        return "redirect:/dep/list";
    }

    /**
     * 删除部门
     *
     * @param id
     * @return
     */
    @RequiresPermissions("/dep/delete")
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        depService.delete(id);
        return "redirect:/dep/list";
    }

    /**
     * 部门统计
     *
     * @return
     */
    @RequestMapping("/count")
    public String depCount() {
        return "count";
    }


    /**
     * 部门人数统计
     * @return
     */
    @RequestMapping("/numcount")
    @ResponseBody
    public List<Count> numCount() {
        List<Department> deps = depService.numConut();
        List<Count> numCounts = new ArrayList<>();
        for (Department dep : deps) {
            Count count = new Count();
            count.setName(dep.getDname());
            count.setCount(dep.getCount());
            numCounts.add(count);
        }
        return numCounts;
    }
}
