package com.sankuai.meituan.web.service;

import com.sankuai.meituan.web.dao.UserDao;
import com.sankuai.meituan.web.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by mashuai on 15/11/17.
 */
@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public int insert(User user){
        int affect=userDao.insert(user);
        return  affect;
    }


    public int deleteById(int id){
        int affect=userDao.deleteById(id);
        return affect;
    }

//    @Transactional
    public int update(User user){
        int affect=userDao.update(user);
        return affect;
    }

    public User findUserById(Integer id){

        User user=userDao.findUserById(id);
        return  user;
    }

    public List<User> findAll(){
        List<User> list=userDao.findAll();
        return list;
    }
}
