package com.farmer.controller;

import com.farmer.entity.User;
import com.farmer.service.AuthService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Resource
    private AuthService authService;

    @GetMapping("/login")
    public String loginPage() {
        return "portal/login";
    }

    @PostMapping("/login")
    public String login(String username, String password, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = authService.login(username, password);
        if (user == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "用户名或密码错误，或账号未启用");
            return "redirect:/auth/login";
        }
        session.setAttribute("loginUser", user);
        return redirectByRole(user);
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        if (!model.containsAttribute("form")) {
            model.addAttribute("form", new User());
        }
        return "portal/register";
    }

    @PostMapping("/register")
    public String register(User form, String confirmPassword, HttpSession session, RedirectAttributes redirectAttributes) {
        String errorMsg = authService.register(form, confirmPassword);
        if (errorMsg != null) {
            redirectAttributes.addFlashAttribute("errorMsg", errorMsg);
            redirectAttributes.addFlashAttribute("form", form);
            return "redirect:/auth/register";
        }
        User user = authService.login(form.getUsername(), form.getPassword());
        if (user != null) {
            session.setAttribute("loginUser", user);
            redirectAttributes.addFlashAttribute("successMsg", "注册成功，已为你登录");
            return redirectByRole(user);
        }
        redirectAttributes.addFlashAttribute("successMsg", "注册成功，请使用新账号登录");
        return "redirect:/auth/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/portal/home";
    }

    private String redirectByRole(User user) {
        if ("ADMIN".equals(user.getRoleType())) {
            return "redirect:/admin/dashboard";
        }
        if ("PLANTER".equals(user.getRoleType())) {
            return "redirect:/farmer/plant/dashboard";
        }
        if ("BREEDER".equals(user.getRoleType())) {
            return "redirect:/farmer/breed/dashboard";
        }
        return "redirect:/user/center";
    }
}
