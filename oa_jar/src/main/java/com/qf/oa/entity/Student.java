package com.qf.oa.entity;

/**
 * @Author Administrator
 * @Time 2018/11/9 14:55
 * @Version 1.0
 */
public class Student {
    private Integer id;
    private String name;
    private String sex;

    public Student(Integer id, String name, String sex) {
        this.id = id;
        this.name = name;
        this.sex = sex;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

}
