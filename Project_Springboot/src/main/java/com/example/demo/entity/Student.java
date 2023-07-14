package com.example.demo.entity;

import lombok.Data;

import javax.persistence.*;


@Entity
@Data
public class Student {
    @Id
    private String sno ;
    private String sname;
    private String cno;

}
