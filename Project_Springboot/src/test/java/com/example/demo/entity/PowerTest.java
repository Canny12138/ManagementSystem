package com.example.demo.entity;
import com.example.demo.repository.PowerRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
class PowerTest {
    @Autowired
    private PowerRepository powerRepository;
    @Test
    void login()
    {
        Power power=new Power();
        power.setNum("30008");
        power.setPassword("10002");
            Power user = powerRepository.findById(power.getNum()).orElse(null);
            if (user==null)
            {
                System.out.println("null");
                return;
            }
            if(user.getPassword().trim().equals(power.getPassword().trim())){
                System.out.println(user.getType());

            }
    }

}