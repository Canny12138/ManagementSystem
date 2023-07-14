package com.example.demo.controller;

import com.example.demo.entity.Student;
import com.example.demo.entity.Student_View;
import com.example.demo.repository.Student_ViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedList;
import java.util.List;

@RestController
@RequestMapping("/student_view")
@CrossOrigin
public class Student_ViewHandler {
    @Autowired
    private Student_ViewRepository student_viewRepository;
    @GetMapping("/findAll/{page}")
    public Page<Student_View> findAll(@PathVariable("page") Integer page){
        Pageable pageable = PageRequest.of(page-1,8);
        Page<Student_View> list = student_viewRepository.findAll(pageable);
        for (Student_View student_view : list){
            student_view.setZhuanye(student_view.getZhuanye().trim());
            student_view.setSdept(student_view.getSdept().trim());
            student_view.setSname(student_view.getSname().trim());
        }
        return list;
    }
    @GetMapping("/findById/{id}")
    public List<Student_View> findById(@PathVariable("id") String id){
        List<Student_View> list = new LinkedList<>();
        Student_View student_view = new Student_View();
        try{
            student_view = student_viewRepository.findById(id).get();
        }catch (Exception ignored){
            ;
        }
        student_view.setSname(student_view.getSname().trim());
        student_view.setSdept(student_view.getSdept().trim());
        student_view.setZhuanye(student_view.getZhuanye().trim());
        list.add(student_view);
        return list;
    }
}
