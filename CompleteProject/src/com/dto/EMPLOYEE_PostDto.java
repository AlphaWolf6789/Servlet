package com.dto;

import javax.servlet.http.HttpServletRequest;

import com.util.Util;

public class EMPLOYEE_PostDto {
	public String emp_id;
	public String name;
	public String position;
	public String hire_date;
	public String salary;
	public String branch_code;
	public String department;
	
    public void getDTO(HttpServletRequest request){
    	emp_id = Util.checkNull(request.getParameter("EMP_ID"));
    	name = Util.checkNull(request.getParameter("NAME"));
    	position = Util.checkNull(request.getParameter("POSITION"));
    	hire_date = Util.checkNull(request.getParameter("HIRE_DATE"));
    	salary = Util.checkNull(request.getParameter("SALARY"));
    	branch_code = Util.checkNull(request.getParameter("BRANCH_CODE"));
    	department = Util.checkNull(request.getParameter("DEPARTMENT"));
    }
}
