package com.qf.oa.controller;

import com.qf.oa.entity.Count;
import com.qf.oa.entity.Employee;
import com.qf.oa.entity.ResultInfo;
import com.qf.oa.entity.Role;
import com.qf.oa.service.IEmpService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/2 13:50
 * @Version 1.0
 */
@Controller
@RequestMapping("/emp")
public class EmpController extends BaseController {

    @Autowired
    private IEmpService empService;

    /**
     * 查询员工
     *
     * @return
     */
    @RequestMapping("/list")
    public String empList(Page page, Model model) {
        List<Employee> emps = empService.queryAll();
        model.addAttribute("emps", emps);
        return "emplist";
    }

    /**
     * 添加或修改员工
     *
     * @param employee
     * @return
     */
    @RequiresPermissions("/emp/saveorupdate")
    @RequestMapping("/saveorupdate")
    public String saveOrUpdate(Employee employee) {
        empService.saveOrUpdate(employee);
        return "redirect:/emp/list";
    }

    /**
     * 删除员工
     *
     * @param id
     * @return
     */
    @RequiresPermissions("/emp/delete")
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        empService.delete(id);
        return "redirect:/emp/list";
    }


    /**
     * 修改角色信息
     *
     * @return
     */
    @RequiresPermissions("/emp/saveorupdate")
    @RequestMapping("/updaterole")
    public String updateRole(Integer eid, Integer[] rid) {
        empService.updateRoleInfo(eid, rid);
        return "redirect:/emp/list";
    }


    /**
     * 根据id查询该员工拥有的角色
     *
     * @param eid
     * @return
     */
    @RequestMapping("/queryrole")
    @ResponseBody
    public List<Role> queryRole(Integer eid) {
        List<Role> roles = empService.queryRoleByEid(eid);
        return roles;
    }

    /**
     * 关键字查找
     *
     * @param keyword
     * @param employee
     * @return
     */
    @RequestMapping("/queryinfo")
    @ResponseBody
    public ResultInfo queryEmpInfo(String keyword, @SessionAttribute("loginuser") Employee employee) {
        List<Employee> employees = empService.queryEmpInfo(keyword, employee.getId());

        // 将List<Employee>转换为 ResultInfo
        ResultInfo resultInfo = new ResultInfo();
        List<ResultInfo.Info> infos = new ArrayList<>();
        for (Employee employee1 : employees) {
            ResultInfo.Info info = new ResultInfo.Info();
            info.setValue(employee1.getName() + "(" + employee1.getEmail() + ")"); // 在页面上显示的内容 姓名（邮箱）
            info.setData(employee1.getEmail()); // 要传输的内容
            infos.add(info);
        }
        resultInfo.setSuggestions(infos);
        return resultInfo;
    }

    /**
     * 部门性别统计
     *
     * @return
     */
    @RequestMapping("/sexcount")
    @ResponseBody
    public List<Count> sexCount() {
        List<Employee> emps = empService.sexCount();
        List<Count> counts = new ArrayList<>();

        for (Employee emp : emps) {
            Count count = new Count();
            if (emp.getSex() == 0) {
                count.setSex("女");
            } else {
                count.setSex("男");
            }
            count.setCount(emp.getCount());
            counts.add(count);
        }
        return counts;
    }
}
