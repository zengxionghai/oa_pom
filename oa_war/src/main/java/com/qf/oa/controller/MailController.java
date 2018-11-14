package com.qf.oa.controller;

import com.qf.oa.entity.Mail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;

/**
 * @Author Administrator
 * @Time 2018/11/7 23:43
 * @Version 1.0
 */
@Controller
@RequestMapping("/mail")
public class MailController {

    @Autowired
    private JavaMailSender javaMailSender;

    @RequestMapping("/tomail")
    public String toMail() {
        return "editmail";
    }

    @RequestMapping("/sendmail")
    public String sendMail(Mail mail) throws MessagingException {
        // 创建邮件
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();

        // 初始化邮件辅助对象
        // 第二个参数表示支持附件
        MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true);
        // 发送方
        mimeMessageHelper.setFrom("15386272198@sina.cn");
        // 接收方
        mimeMessageHelper.setTo(mail.getTo());
        // 标题
        mimeMessageHelper.setSubject(mail.getSubject());
        // 内容
        mimeMessageHelper.setText(mail.getContent(), true);
        // 附件
        mimeMessageHelper.addAttachment(mail.getFile().getOriginalFilename(), new InputStreamSource() {
            @Override
            public InputStream getInputStream() throws IOException {
                return mail.getFile().getInputStream();
            }
        });

        // 发送邮件
        javaMailSender.send(mimeMessage);

        return "redirect:/mail/tomail";
    }
}
