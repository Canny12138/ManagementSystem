package com.example.demo.entity;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;


@Entity
@Data
public class Student_View {
    @Id
    private String Sno;
    private String Cno;
    private String Zhuanye;
    private String Sdept;
    private String Sname;
}
