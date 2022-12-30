package com.dao;

import com.dto.EMPLOYEE_GetDto;
import com.dto.EMPLOYEE_PostDto;

public interface EMPLOYEE_Dao {
	public String getJSON(EMPLOYEE_GetDto getDTO);
    public String getXML(EMPLOYEE_GetDto getDTO);
    public String insert(EMPLOYEE_PostDto postDTO);
    public String delete(EMPLOYEE_PostDto postDTO);
    public String update(EMPLOYEE_PostDto postDTO);
}
