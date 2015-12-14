package com.sankuai.meituan.web.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * Created by mashuai on 15/11/17.
 */
public class User {
    private Integer id;
    private String username;
    private Integer age;
    private String email;
    private Date birthday;

    public User() {
    }

    public User(String username, Integer age, String email, Date birthday) {
        this.username = username;
        this.age = age;
        this.email = email;
        this.birthday = birthday;
    }

    public User(Integer id, String username, Integer age, String email, Date birthday) {
        this.id = id;
        this.username = username;
        this.age = age;
        this.email = email;
        this.birthday = birthday;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", age=" + age +
                ", email='" + email + '\'' +
                ", birthday=" + birthday +
                '}';
    }
}
