package com.qf.oa.entity;

import org.springframework.web.multipart.MultipartFile;

/**
 * @Author Administrator
 * @Time 2018/11/8 10:28
 * @Version 1.0
 */
public class Mail {

    // 标题
    private String subject;

    // 接收人
    private String to;

    // 内容
    private String content;

    // 附件
    private MultipartFile file;

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    @Override
    public String toString() {
        return "Mail{" +
                "subject='" + subject + '\'' +
                ", to='" + to + '\'' +
                ", content='" + content + '\'' +
                ", file=" + file +
                '}';
    }
}
