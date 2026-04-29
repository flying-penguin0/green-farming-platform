package com.farmer.mapper;

import com.farmer.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    User selectByUsername(@Param("username") String username);
    User selectById(@Param("id") Long id);
    int insertUser(User user);
    int updateProfile(User user);
    int updatePassword(@Param("id") Long id, @Param("password") String password);
}
