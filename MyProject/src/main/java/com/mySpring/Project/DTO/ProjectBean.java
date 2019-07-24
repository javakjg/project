package com.mySpring.Project.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectBean {
	private int Bookid;
	private String Name;
	private String Pwd;
	private String Content;
}
