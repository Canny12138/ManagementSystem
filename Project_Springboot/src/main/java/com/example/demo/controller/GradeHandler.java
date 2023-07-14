package com.example.demo.controller;

import com.example.demo.entity.Grade;
import com.example.demo.repository.GradeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import java.util.LinkedList;
import java.util.List;

@RestController
@RequestMapping("/grade")
@CrossOrigin
public class GradeHandler {
    @Autowired
    private GradeRepository gradeRepository;

    @GetMapping("/findAll/{page}")
    public Page<Grade> findAll(@PathVariable("page") Integer page) {
        Pageable pageable = PageRequest.of(page - 1, 8);
        return gradeRepository.findAll(pageable);
    }

    @PostMapping("/save")
    public String save(@RequestBody Grade grade) {
        List<Grade> list = gradeRepository.findAll();
        for (Grade value : list) {
            if (grade.getSno().equals(value.getSno().trim())) {
                if (grade.getKno().equals(value.getKno().trim())) {
                    if (grade.getTerm().equals(value.getTerm())) {
                        return "error";
                    }
                }
            }
        }
        gradeRepository.save(grade);
        return "success";
    }

    @GetMapping("/findById/{sno}")
    public List<Grade> findById(@PathVariable("sno") String id) {
        List<Grade> list = gradeRepository.findAll();
        List<Grade> resultList = new LinkedList<>();
        for (Grade grade : list) {
            if (grade.getSno().trim().equals(id)) {
                resultList.add(grade);
            }
        }
        return resultList;
    }

    @PutMapping("/update")
    public String update(@RequestBody Grade grade) {
        List<Grade> list = gradeRepository.findAll();
        for (Grade value : list) {
            if (grade.getSno().equals(value.getSno().trim())) {
                if (grade.getKno().equals(value.getKno().trim())) {
                    if (grade.getTerm().equals(value.getTerm())) {
                        gradeRepository.save(grade);
                        return "success";
                    }
                }
            }
        }
        return "error";
    }

    @PostMapping("/delete")
    public String delete(@RequestBody Grade grade) {
        List<Grade> list = gradeRepository.findAll();
        for (Grade value : list) {
            if (grade.getSno().equals(value.getSno().trim())) {
                if (grade.getKno().equals(value.getKno().trim())) {
                    if (grade.getTerm().equals(value.getTerm())) {
                        gradeRepository.delete(grade);
                        return "success";
                    }
                }
            }

        }
        return "error";
    }
}