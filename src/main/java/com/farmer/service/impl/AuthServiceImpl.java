package com.farmer.service.impl;

import com.farmer.entity.User;
import com.farmer.mapper.UserMapper;
import com.farmer.service.AuthService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AuthServiceImpl implements AuthService {

    @Resource
    private UserMapper userMapper;

    @Override
    public User login(String username, String password) {
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            return null;
        }
        if (!"ENABLED".equals(user.getStatus())) {
            return null;
        }
        return user.getPassword().equals(password) ? user : null;
    }

    @Override
    public String register(User user, String confirmPassword) {
        if (user == null) {
            return "注册信息不能为空";
        }
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return "请输入用户名";
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            return "请输入密码";
        }
        if (!user.getPassword().equals(confirmPassword)) {
            return "两次输入的密码不一致";
        }
        if (user.getRealName() == null || user.getRealName().trim().isEmpty()) {
            return "请输入姓名";
        }
        if (userMapper.selectByUsername(user.getUsername().trim()) != null) {
            return "用户名已存在";
        }

        user.setUsername(user.getUsername().trim());
        user.setRoleType("USER");
        user.setStatus("ENABLED");
        if (user.getGender() == null || user.getGender().trim().isEmpty()) {
            user.setGender("男");
        }
        userMapper.insertUser(user);
        return null;
    }
}
