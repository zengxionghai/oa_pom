package com.qf.oa.realm;

import com.qf.oa.entity.Employee;
import com.qf.oa.entity.Resc;
import com.qf.oa.service.IEmpService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @Author Administrator
 * @Time 2018/11/7 16:03
 * @Version 1.0
 */
@Component
public class OARealm extends AuthorizingRealm {

    @Autowired
    private IEmpService empService;

    /**
     * 授权管理
     *
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        // 获得登录用户的信息
        Employee employee = (Employee) principalCollection.getPrimaryPrincipal();

        // 获得登录用户的权限信息
        List<Resc> rescs = employee.getRescs();

        AuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        for (Resc resc : rescs) {
            if (resc.getRespath() != null && !resc.getRespath().trim().equals("")) {
                ((SimpleAuthorizationInfo) authorizationInfo).addStringPermission(resc.getRespath());
            }
        }

        return authorizationInfo;
    }

    /**
     * 登录认证
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 获得输入的用户名
        String email = (String) authenticationToken.getPrincipal();

        // 调用service获得用户信息
        Employee employee = empService.queryByEmail(email);
        AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(employee, employee.getPassword(), this.getName());

        return authenticationInfo;
    }
}
