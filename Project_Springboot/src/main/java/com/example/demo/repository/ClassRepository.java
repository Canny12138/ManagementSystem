package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.Class;

public interface ClassRepository extends JpaRepository<Class,String> {

}
