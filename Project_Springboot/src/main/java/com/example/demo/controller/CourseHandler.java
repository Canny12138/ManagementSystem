package com.example.demo.controller;
import com.example.demo.entity.Course;
import com.example.demo.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/course")
@CrossOrigin
public class CourseHandler {
    @Autowired
    private CourseRepository courseRepository;
    @GetMapping("/findAll/{page}")
    public Page<Course> findAll(@PathVariable("page") Integer page){
        Pageable pageable = PageRequest.of(page-1,8);
        Page<Course> list = courseRepository.findAll(pageable);
        for(Course course:list){
            course.setKname(course.getKname().trim());
        }
        return list;
    }
    @PostMapping("/save")
    public String save(@RequestBody Course course){
        try {
            Course originCourse = courseRepository.findById(course.getKno()).get();
            return "error";
        }catch (Exception e){
            courseRepository.save(course);
            return "success";
        }
    }
    @GetMapping("/findById/{id}")
    public Course findById(@PathVariable("id") String id){
        Course course = courseRepository.findById(id).get();
        course.setKname(course.getKname().trim());
        return course;
    }
    @PutMapping("/update")
    public String update(@RequestBody Course course){
        try {
            Course originCourse= courseRepository.findById(course.getKno()).get();
            courseRepository.save(course);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") String id){
        try {
            courseRepository.deleteById(id);
            return "success";
        }catch (Exception e){
            return "error";
        }
    }
}
