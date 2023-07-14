package com.example.demo.controller;


import com.example.demo.entity.Grade;
import com.example.demo.entity.Grade_View;
import com.example.demo.entity.Student_View;
import com.example.demo.repository.Grade_ViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedList;
import java.util.List;

@RestController
@RequestMapping("/grade_view")
@CrossOrigin
public class Grade_ViewHandler {
    @Autowired
    private Grade_ViewRepository grade_viewRepository;
    @GetMapping("/findAll/{page}")
    public Page<Grade_View> findAll(@PathVariable("page") Integer page){
        Pageable pageable = PageRequest.of(page-1,8);
        Page<Grade_View> list = grade_viewRepository.findAll(pageable);
        for(Grade_View grade_view:list){
            grade_view.setKname(grade_view.getKname().trim());
        }
        return list;
    }
    @GetMapping("/findById/{sno}")
    public List<Grade_View> findById(@PathVariable("sno") String id)
    {

        List<Grade_View> list = grade_viewRepository.findAll();
        List<Grade_View> resultList = new LinkedList<>();
        for(Grade_View grade_view : list){
            if(grade_view.getSno().trim().equals(id)){
                grade_view.setKname(grade_view.getKname().trim());
                resultList.add(grade_view);
            }
        }
        return resultList;
    }
}
