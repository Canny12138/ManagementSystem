package com.example.demo.controller;

import com.example.demo.entity.Student;
import com.example.demo.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.domain.Page;

import java.util.LinkedList;
import java.util.List;

@RestController
@RequestMapping("/student")
@CrossOrigin
public class StudentHandler {
    @Autowired
    private StudentRepository studentRepository;
    @GetMapping("/findAll/{page}")
    public Page<Student> findAll(@PathVariable("page") Integer page){
        Pageable pageable = PageRequest.of(page-1,8);
        Page<Student> list = studentRepository.findAll(pageable);
        for (Student student : list) {
            student.setSname(student.getSname().trim());
        }
        return list;
    }
    @PostMapping("/save")
    public String save(@RequestBody Student student)
    {
        try {
            Student originStudent = studentRepository.findById(student.getSno()).get();
            return "error";
        }catch (Exception e){
            studentRepository.save(student);
            return "success";
        }
    }
    @GetMapping("/findById/{id}")
    public List<Student> findById(@PathVariable("id") String id)
    {
        List<Student> list = new LinkedList<>();
        Student student = new Student();
        try{
            student = studentRepository.findById(id).get();
        }catch (Exception ignored){
            ;
        }
        student.setSname(student.getSname().trim());
        list.add(student);
        return list;
    }
    @PutMapping("/update")
    public String update(@RequestBody Student student)
    {
        try {
            Student originStudent= studentRepository.findById(student.getSno()).get();
            studentRepository.save(student);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") String id){
        try {
            studentRepository.deleteById(id);
            return "success";
        }catch (Exception e){
            return "error";
        }
    }
}
