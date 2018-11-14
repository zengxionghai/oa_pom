package com.qf.oa.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.UUID;

/**
 * @Author Administrator
 * @Time 2018/11/2 17:36
 * @Version 1.0
 */
@Controller
@RequestMapping("/img")
public class ImgController {

    @Value("${uploadpath}")
    private String uploadPath;

    /**
     * 上传图片
     *
     * @param file
     * @return
     */
    @RequestMapping("/upload")
    @ResponseBody
    public String uploadImg(MultipartFile file) {

        // 获得上传流
        InputStream in = null;
        OutputStream out = null;
        // 输出地址
        String path = null;

        try {
            in = file.getInputStream();
            // 输出流一定要定位到文件（这个文件可以不存在，会自动创建）
            path = uploadPath + UUID.randomUUID().toString();
            out = new FileOutputStream(path);

            // 文件上传
            IOUtils.copy(in, out);

            return "{\"uploadpath\":\"" + path + "\"}";
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }


    /**
     * 获得图片
     *
     * @param path
     * @param response
     */
    @RequestMapping("/getImg")
    public void getImg(String path, HttpServletResponse response) {
        InputStream in = null;
        OutputStream out = null;
        try {
            // 用户需要显示的图片
            if (path != null && !"".equals(path)) {
                in = new FileInputStream(path);
                out = response.getOutputStream();

                IOUtils.copy(in, out);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
