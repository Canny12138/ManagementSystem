package com.example.demo.entity;


import lombok.Data;

import javax.persistence.*;


@Entity
@Data
public class Power {
    @Id
    private String Num ;
    private String Type;
    private String Name;
    private String Password;
}