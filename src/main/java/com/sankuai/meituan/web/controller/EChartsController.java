package com.sankuai.meituan.web.controller;

import com.alibaba.fastjson.JSONArray;
import com.sankuai.meituan.web.domain.EchartData;
import com.sankuai.meituan.web.domain.Series;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * Created by mashuai on 15/12/1.
 */
@Controller
@RequestMapping("/echarts")
public class EChartsController {

    private static final Logger logger = LoggerFactory.getLogger(EChartsController.class);

    @RequestMapping(value = "/line_data",method = RequestMethod.POST)
    @ResponseBody
    public String lineData() {
        logger.info("LineData...");
        List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"PDF","P"}));//数据分组
        List<String> category = new ArrayList<String>();//横坐标
        List<Series> series = new ArrayList<Series>();//纵坐标


        //设置x轴数据显示
        for(int i=0;i<=100;i++){
            String time_point=i+"";
            category.add(time_point);
        }
        //根据参数,从数据库中返回指定商家训练之后的概率密度函数
        String pdf="0.475924417:0.253408005:0.253408005:0.010845062:0.0057745:4.64E-04:3.73E-05:1.32E-04:3.00E-06:3.00E-06:4.53E-07:4.53E-07:6.83E-08:1.03E-08:2.92E-09:4.41E-10:3.55E-11:5.36E-12:2.85E-12:8.08E-13:4.30E-13:4.30E-13:4.30E-13:2.29E-13:2.29E-13:2.29E-13:1.22E-13:1.22E-13:1.22E-13:1.22E-13:6.50E-14:3.46E-14:1.84E-14:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:9.81E-15:2.78E-15:1.48E-15:4.20E-16:4.20E-16:4.20E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:2.24E-16:1.19E-16:6.34E-17:6.34E-17:3.37E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17:1.80E-17";
        Double PDF[]=stringToDouble(pdf);
        int len=PDF.length;

        //设置概率积分分布数据
        Double P[]=new Double[len];
        for(int i=0;i<len;i++){
            double temp = 0.0;
            for(int j=0;j<=i;j++){
                temp+=PDF[j];
            }
            P[i]=temp;
        }

        series.add(new Series("PDF", "line", new ArrayList<Double>(Arrays.asList(PDF))));
        series.add(new Series("P", "line", new ArrayList<Double>(Arrays.asList(P))));
        EchartData data = new EchartData(legend, category, series);
        String jsondata= JSONArray.toJSONString(data);
        return jsondata;
    }

    @RequestMapping("/getPoiInfo")
    public String setPoiInfo(Map<String,Object> map){
        Map<String,String> platMap=new HashMap<String, String>();
        map.put("platMap",platMap);
        return "echarts";
    }

    //将概率密度double化
    private Double[] stringToDouble(String pdf){
        String re[]=pdf.split(":");
        Double reslult[]=new Double[re.length];
        for(int i=0;i<re.length;i++){
            reslult[i]=Double.parseDouble(re[i]);
        }
        return reslult;
    }

}
