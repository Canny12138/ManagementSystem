package com.example.demo.controller;
import com.example.demo.entity.Power;
import com.example.demo.repository.PowerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.LinkedList;

@RestController
@RequestMapping("/power")
@CrossOrigin
public class PowerHandler {
    @Autowired
    private PowerRepository powerRepository;
    @PostMapping("/login")
    public List<Power> login(@RequestBody Power power){
        Power user;
        List<Power> resultList = new LinkedList<>();
        Power nullPower=new Power();
        try {
            user = powerRepository.findById(power.getNum()).get();
        }catch (Exception e){
            resultList.add(nullPower);
            return resultList;
        }
        if(user.getPassword().trim().equals(power.getPassword().trim())){
            user.setName(user.getName().trim());
            resultList.add(user);
        }else {
            resultList.add(nullPower);
        }
        return resultList;
    }
    @GetMapping("/findAll/{page}")
    public Page<Power> findAll(@PathVariable("page") Integer page)
    {
        Pageable pageable = PageRequest.of(page-1,5);
        Page<Power> list =powerRepository.findAll(pageable);
        for (Power power:list)
        {
            power.setName(power.getName().trim());
        }
        return list;
    }
    @PutMapping("/update")
    public String changePassword(@RequestBody Power power){
       try{
           Power originPower = powerRepository.findById(power.getNum()).get();
           originPower.setPassword(power.getPassword());
           powerRepository.save(originPower);
           return "success";
       }catch (Exception e){
           return "error";
       }
    }
    @GetMapping("/findById/{num}")
    public  String findById(@PathVariable("num") String id)
    {
        Power power=powerRepository.findById(id).get();
        return power.getNum();
    }
}
