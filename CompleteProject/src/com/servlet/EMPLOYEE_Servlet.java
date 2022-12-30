package com.servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EMPLOYEE_Dao;
import com.dto.EMPLOYEE_GetDto;
import com.dto.EMPLOYEE_PostDto;
import com.jdbc.EMPLOYEE_Impl;
import com.util.Constant;
import com.util.Util;

@WebServlet("/EMPLOYEE_Servlet")
public class EMPLOYEE_Servlet extends AbstractServlet {
	private static final long serialVersionUID = 1L;

	public EMPLOYEE_Servlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = Util.getStoredConnection(request);
		EMPLOYEE_Dao daoObj = new EMPLOYEE_Impl(conn);
		EMPLOYEE_GetDto getDTO = new EMPLOYEE_GetDto();
		initGetDTO(getDTO, request);

		String method = request.getParameter("method");
		String cbbName = request.getParameter("cbbName");

		String strResult = "";
		if (method != null && cbbName != null && method.equals("getCbbData")) {
			EMPLOYEE_PostDto dtoObj = new EMPLOYEE_PostDto();
//			if (cbbName.equals("Que"))
//				strResult = daoObj.getCbbQue1();
		} else {
			getDTO.emp_id = Util.checkNull(request.getParameter("emp_id"));
			getDTO.name = Util.checkNull(request.getParameter("name"));
			strResult = daoObj.getJSON(getDTO);
		}

		response.setContentType(Constant.CONTENT_TYPE_JSON);
		response.getWriter().print(strResult);
		System.out.println("EMPLOYEE_Servlet: doGet: end");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = Util.getStoredConnection(request);
		String method = request.getParameter("method");

		EMPLOYEE_Dao daoObj = new EMPLOYEE_Impl(conn);
		EMPLOYEE_PostDto dtoObj = new EMPLOYEE_PostDto();
		dtoObj.getDTO(request);

		System.out.println("EMPLOYEE_Servlet: doPost: Method=" + method);
		String msg = "success";
		if (method.equals("update")) {
			msg = daoObj.update(dtoObj);
		} else if (method.equals("delete")) {
			msg = daoObj.delete(dtoObj);
		} else if (method.equals("insert")) {
			msg = daoObj.insert(dtoObj);
		}
		response.getWriter().println(msg);
		System.out.println("EMPLOYEE_Servlet: doPost: End");
	}

}
