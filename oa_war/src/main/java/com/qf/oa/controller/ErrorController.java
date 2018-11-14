package com.qf.oa.controller;

import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * @Author Administrator
 * @Time 2018/11/7 17:49
 * @Version 1.0
 */
@ControllerAdvice
public class ErrorController {

    @ExceptionHandler(UnauthorizedException.class)
    public String exception(UnauthorizedException e) {
        System.out.println("权限不足！" + e.getMessage());
        return "error";
    }
}

