package com.example.demo.entity;

import lombok.Data;

import javax.persistence.*;


@Entity
@Data
public class Class {
    @Id
    private String Cno;
    private String Zhuanye;
    private String Sdept;

}
