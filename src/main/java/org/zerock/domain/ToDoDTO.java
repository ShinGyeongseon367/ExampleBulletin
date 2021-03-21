package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ToDoDTO {

	private String title;
	private Date dueDate;
}
