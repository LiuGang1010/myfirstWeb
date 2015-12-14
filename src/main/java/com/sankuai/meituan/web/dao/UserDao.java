package com.sankuai.meituan.web.dao;


import com.sankuai.meituan.web.domain.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by mashuai on 15/11/15.
 */
@Component
public interface UserDao {
    static final String Table="user";
    static final String INSERT_KEYS="username,age,email,birthday";
    static final String INSERT_VALUES="#{username}, #{age}, #{email}, #{birthday}";
    static final String SELECT_KEYS="username, age, email, birthday";

    @Options(useGeneratedKeys = true,keyProperty = "id")
    @Insert("INSERT INTO "+Table+"("+INSERT_KEYS+") VALUES ("+INSERT_VALUES+")")
    public int insert(User user);

    @Delete("DELETE FROM "+Table+" WHERE id=#{id}")
    public int deleteById(@Param("id") int id);

    @Update("UPDATE "+Table+" SET username=#{username},age=#{age},email=#{email},birthday=#{birthday} WHERE id=#{id} ")
    public int update(User user);

    @Select("SELECT "+SELECT_KEYS+" FROM "+Table+" WHERE id=#{id} ")
    public User findUserById(@Param("id") Integer id);

    @Select("SELECT * FROM "+Table)
    public List<User> findAll();
}
