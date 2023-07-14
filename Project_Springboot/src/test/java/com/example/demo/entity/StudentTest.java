package com.example.demo.entity;

import com.example.demo.repository.StudentRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class StudentTest {
    @Autowired
    private StudentRepository studentRepository;

    @Test
    void findAll() {
        List<Student> list = studentRepository.findAll();
        int size = list.size();
        for(int i=0;i<size;i++){
            list.get(i).setSname(list.get(i).getSname().trim());
        }
        System.out.println(list);

    }

    @Test
    void save() {
        Student student = new Student();
        student.setSno("20009");
        student.setSname("学生九");
        Student student1 = studentRepository.save(student);
        System.out.println(student1);
    }

    @Test
    void findById() {
        Student student = studentRepository.findById("20005").get();
        System.out.println(student);
    }

    @Test
    void update() {
        Student student = new Student();
        student.setSno("20005");
        student.setSname("学生6");
        Student student1 = studentRepository.save(student);
        System.out.println(student1);
    }

    @Test
    void delete() {
        studentRepository.deleteById("20005");
    }
}