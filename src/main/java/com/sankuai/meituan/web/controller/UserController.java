package com.sankuai.meituan.web.controller;

import com.sankuai.meituan.web.domain.User;
import com.sankuai.meituan.web.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by mashuai on 15/11/15.
 */
@Controller
public class UserController {
    private final Logger log = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private UserService userService;
    @RequestMapping(value = "/testadd",method = RequestMethod.POST)
    public String testadd(User user){

        log.info("insert a new record ({})",user);
        userService.insert(user);
        return "success";
    }
    @RequestMapping(value = "/testupdate",method = RequestMethod.POST)
    public String testupdate(User user){
        user.setId(2);
        log.info("update user ({})",user);
        userService.update(user);
        return "success";
    }
    @RequestMapping(value = "/testdelete",method = RequestMethod.GET)
    public String testdelete(Integer id){
        userService.deleteById(id);
        log.info("delete a user within id=({})",id);
        return "success";
    }

    @RequestMapping(value = "/testfind",method = RequestMethod.GET)
    public String testfind(Model model,Integer id){
        User user= userService.findUserById(id);
        log.info("find a user ({})",user);
        model.addAttribute("user",user);
        return "success";
    }
    @RequestMapping(value = "/testfindall",method = RequestMethod.GET)
    public String testfindAll(){
        List<User> list=userService.findAll();
        log.info("find all user ({})",list);
        return "success";
    }

    @RequestMapping("/test")
    public String test() {
        log.info("index.ftl");
        return "index";
    }

    @RequestMapping("/testftl")
    public String testFtl() {
        log.info("hello ftl");
        return "testftl";
    }

    @RequestMapping("/myserver")
    @ResponseBody
    public String testAjax(HttpServletRequest request) throws UnsupportedEncodingException {
        String username= request.getParameter("username");
        System.out.println(username);
        String msg="";
        if(username!=null){
            msg=username+" is aready exist ! you can get it";
        }else {
            msg=username+" is not exist,you need to register it first";
        }
        return msg;
    }

}
