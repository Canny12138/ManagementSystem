package com.example.demo.entity;

import com.example.demo.repository.ClassRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ClassTest {
    @Autowired
    private  ClassRepository classRepository;
    @Test
    void   update()
    {
        Class aClass=new Class();
        aClass.setCno("0");
        aClass.setZhuanye("1213");
        aClass.setSdept("123");
        try {
            Class originClass = classRepository.findById(aClass.getCno()).get();
            System.out.println("error");
        }catch (Exception e){
            classRepository.save(aClass);
            System.out.println("success");
        }
    }

}