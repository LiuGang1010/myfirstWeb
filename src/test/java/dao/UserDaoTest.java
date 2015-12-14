package dao;

import com.sankuai.meituan.web.dao.UserDao;
import com.sankuai.meituan.web.domain.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by mashuai on 15/11/17.
 */
@ContextConfiguration(locations = "classpath:ApplicationContext-myWeb.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class UserDaoTest {
    @Autowired
    private UserDao userDao;
    @Test
    public void testUserDao(){
        List<User> list= userDao.findAll();
        for(User user:list){
            System.out.println(user);
        }
        System.out.println("Test UserDao Succefully");
    }
}
