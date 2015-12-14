package com.sankuai.meituan.web.controller;

import com.alibaba.fastjson.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;


/**
 * Created by mashuai on 15/11/29.
 */
@Controller
public class TestAjaxController {
    private final Logger log = LoggerFactory.getLogger(TestAjaxController.class);
    @RequestMapping("/testajax")
    public String test(){
        log.info("begin into ajax test");
        return "ajax";
    }

    @RequestMapping("/validateForm")
    @ResponseBody
    public String testValidationForm(HttpServletRequest request){
        String catalogId=request.getParameter("catalogId");
        String msg="";
        if(catalogId!=null){
            msg="catalog is already be used";
        }else{
            msg="catalog can be use";
        }
        return  msg;
    }

    @RequestMapping("/getchartsData")
    @ResponseBody
    public String getChartsData(){
        String data="0.1:0.3:0.22:0.33:0.15";
        String res= JSONArray.toJSONString(data.split(":"));
        System.out.println(res);
        return res;
    }
}
