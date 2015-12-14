package service;

import com.sankuai.meituan.web.domain.User;
import com.sankuai.meituan.web.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by mashuai on 15/11/27.
 */
@ContextConfiguration(locations = "classpath:ApplicationContext-myWeb.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class UserServiceTest {
    @Autowired
    private UserService userService;
    @Test
    public void test(){
        List<User>list= userService.findAll();
        for(User user:list){
            System.out.println(user);
        }
        System.out.println("Test UserService Succefully");
    }
}
