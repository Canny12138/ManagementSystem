package com.example.demo.entity;

import lombok.Data;

import javax.persistence.*;


@Entity
@Data
@IdClass(GradeKey.class)
public class Grade {
    @Id
    private String Sno ;
    @Id
    private String Kno;
    @Id
    private String Term;
    private int Grade;
}