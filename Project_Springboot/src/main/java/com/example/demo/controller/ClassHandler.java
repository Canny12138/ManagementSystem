package com.example.demo.controller;

import com.example.demo.entity.Class;
import com.example.demo.repository.ClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/class")
@CrossOrigin
public class ClassHandler {
    @Autowired
    private ClassRepository classRepository;
    @GetMapping("/findAll/{page}")
    public Page<Class> findAll(@PathVariable("page") Integer page){
        Pageable pageable = PageRequest.of(page-1,8);
        Page<Class> list = classRepository.findAll(pageable);
        for(Class aClass:list){
            aClass.setZhuanye(aClass.getZhuanye().trim());
            aClass.setSdept(aClass.getSdept().trim());
        }
        return list;
    }
    @PostMapping("/save")
    public String save(@RequestBody Class aClass){
        try {
            Class originClass = classRepository.findById(aClass.getCno()).get();
            return "error";
        }catch (Exception e){
            classRepository.save(aClass);
            return "success";
        }
    }
    @GetMapping("/findById/{id}")
    public Class findById(@PathVariable("id") String id){
        try {
            Class aClass = classRepository.findById(id).get();
            aClass.setZhuanye(aClass.getZhuanye().trim());
            aClass.setSdept(aClass.getSdept().trim());
            return aClass;
        }catch (Exception e){
            return null;
        }
    }
    @PutMapping("/update")
    public String update(@RequestBody Class aClass) {
        try {
            Class originClass = classRepository.findById(aClass.getCno()).get();
            classRepository.save(aClass);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") String id){
        try {
            classRepository.deleteById(id);
            return "success";
        }catch (Exception e){
            return "error";
        }
    }
}
