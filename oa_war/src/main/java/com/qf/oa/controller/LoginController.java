package com.qf.oa.controller;

import com.qf.oa.entity.Employee;
import com.qf.oa.service.IEmpService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 * @Author Administrator
 * @Time 2018/11/1 17:13
 * @Version 1.0
 */
@Controller
@SessionAttributes("loginuser")
public class LoginController {

    @Autowired
    private IEmpService empService;

    /**
     * 登录
     *
     * @param email
     * @param password
     * @return
     */
    @RequestMapping("/login")
    public String login(String email, String password, Model model) {
        Subject subject = SecurityUtils.getSubject();

        if (!subject.isAuthenticated()) {
            UsernamePasswordToken token = new UsernamePasswordToken(email, password);
            try {
                subject.login(token);
            } catch (AuthenticationException ae) {
                model.addAttribute("error", 1);
                return "login";
            }
        }

        // 登录成功
        Employee employee = (Employee) subject.getPrincipal();
        model.addAttribute("loginuser", employee);
        return "index";
    }


//    @RequestMapping("/loginout")
////    public String loginOut(HttpSession session) {
////        session.invalidate();
////        return "login";
////    }

    /**
     * 跳转页面
     *
     * @param page
     * @return
     */
    @RequestMapping("/topage/{page}")
    public String toPage(@PathVariable String page) {
        return page;
    }
}
