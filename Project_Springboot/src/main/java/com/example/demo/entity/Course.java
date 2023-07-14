package com.example.demo.entity;

import lombok.Data;

import javax.persistence.*;


@Entity
@Data
public class Course {
    @Id
    private String Kno;
    private String Kname;
    private String Term;

}