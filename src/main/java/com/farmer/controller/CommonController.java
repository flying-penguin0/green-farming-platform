package com.farmer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common")
public class CommonController {

    @GetMapping("/forbidden")
    public String forbidden() {
        return "common/forbidden";
    }

    @GetMapping("/note")
    public String note() {
        return "common/project-note";
    }
}
