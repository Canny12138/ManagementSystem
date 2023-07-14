package com.example.demo.entity;

import lombok.Data;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;

@Entity
@Data
@IdClass(Grade_ViewKey.class)
public class Grade_View {
    @Id
    private String Kno;
    @Id
    private String Sno;
    @Id
    private String Term;
    private String Kname;
    private int Grade;
}
