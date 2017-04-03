package com.yin.visualization.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by yinfeng on 2017/3/21 0021.
 */
@Controller
public class ViewController {

    @RequestMapping("/view")
    public String page(String type) {
        return type;
    }
}
