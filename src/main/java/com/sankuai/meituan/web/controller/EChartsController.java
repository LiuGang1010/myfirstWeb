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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by mashuai on 15/12/1.
 */
@Controller
public class EChartsController {

    private static final Logger logger = LoggerFactory.getLogger(EChartsController.class);

    @RequestMapping(value = "/echarts/line_data",method = RequestMethod.POST)
    @ResponseBody
    public String lineData() {
        logger.info("lineData....");

        List<String> legend = new ArrayList<String>(Arrays.asList(new String[]{"PDF"}));//数据分组
        List<String> category = new ArrayList<String>();//横坐标
        List<Series> series = new ArrayList<Series>();//纵坐标


        for(int i=0;i<=100;i++){
            String time_point=i+"";
            category.add(time_point);
        }
        String pdf="0.014349786149278367:0.014349786149278367:0.014349786149278367:0.014349786149278367:0.008031771171816415:0.008031771171816415:0.014349786149278364:0.025637727734647658:0.025637727734647658:0.0458050786651602:0.0458050786651602:0.0458050786651602:0.02563772773464766:0.008031771171816412:0.008031771171816412:0.02563772773464766:0.02563772773464766:0.0458050786651602:0.08183662972152037:0.14621160271625544:0.14621160271625544:0.0458050786651602:0.0458050786651602:0.025637727734647658:0.014349786149278364:0.008031771171816412:0.004495491952656405:0.002516188206072615:0.002516188206072615:0.002516188206072615:0.002516188206072615:0.004495491952656405:0.004495491952656405:0.004495491952656405:0.004495491952656405:0.002516188206072615:0.002516188206072615:0.001408344883063975:0.001408344883063975:0.001408344883063975:0.001408344883063975:0.001408344883063975:0.001408344883063975:0.001408344883063975:0.001408344883063975:7.882698539265157E-4:7.882698539265157E-4:0.001408344883063975:0.001408344883063975:0.001408344883063975:0.001408344883063975:0.001408344883063975:7.882698539265155E-4:4.4120539654852716E-4:4.4120539654852716E-4:4.4120539654852716E-4:4.4120539654852716E-4:4.4120539654852716E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4:2.4694868257855513E-4";
        Double PDF[]=stringToDouble(pdf);
        int len=PDF.length;

        Double P[]=new Double[len];
        for(int i=0;i<len;i++){
            double temp = 0.0;
            for(int j=0;j<=i;j++){
                temp+=PDF[j];
            }
            P[i]=temp;
        }

        series.add(new Series("PDF", "line", new ArrayList<Double>(Arrays.asList(P))));
        EchartData data = new EchartData(legend, category, series);
        String jsondata= JSONArray.toJSONString(data);
        return jsondata;
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

    @RequestMapping("/line_page")
    public String linePage() {
        logger.info("linePage....");
        return "report/line";
    }


}
