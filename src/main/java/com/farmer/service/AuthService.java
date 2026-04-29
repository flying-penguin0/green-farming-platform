package com.farmer.service;

import com.farmer.entity.User;

public interface AuthService {
    User login(String username, String password);
    String register(User user, String confirmPassword);
}
