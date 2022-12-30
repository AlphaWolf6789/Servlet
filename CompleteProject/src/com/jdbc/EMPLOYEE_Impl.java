package com.jdbc;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dao.EMPLOYEE_Dao;
import com.dto.EMPLOYEE_GetDto;
import com.dto.EMPLOYEE_PostDto;
import com.util.Util;

public class EMPLOYEE_Impl implements EMPLOYEE_Dao {
	private Connection conn;

	public EMPLOYEE_Impl(Connection conn) {
		this.conn = conn;
	}

	@Override
	public String getJSON(EMPLOYEE_GetDto getDTO) {
		JSONObject obj = new JSONObject();
		try {
			String orderby = getDTO.getSidx();
			String sord = getDTO.getSord();
			int Start = 1, End = 50;
			if (!getDTO.getStart().equals("")) {
				try {
					Start = Integer.parseInt(getDTO.getStart());
				} catch (Exception e) {
				}
			}
			if (!getDTO.getEnd().equals("")) {
				try {
					End = Integer.parseInt(getDTO.getEnd());
				} catch (Exception e) {
				}
			}

			String sqlCall = "{ CALL SP_EMPLOYEE_Select(?, ?, ?, ?, ?, ? )}";
			CallableStatement cs = conn.prepareCall(sqlCall);
			System.out.println("sqlCall=" + sqlCall);
			if (getDTO.emp_id == null || getDTO.emp_id.trim().equals(""))
				cs.setNull(1, java.sql.Types.VARCHAR);
			else
				cs.setString(1, getDTO.emp_id);
			if (getDTO.department == null || getDTO.department.trim().equals(""))
				cs.setNull(2, java.sql.Types.VARCHAR);
			else
				cs.setString(2, getDTO.department);
			cs.setInt(3, 1);
			cs.setInt(4, 999999);
			cs.setString(5, orderby);
			cs.setString(6, sord);

			ResultSet rs = cs.executeQuery();

			long ilimit = Integer.parseInt(getDTO.getLimit());
			long count = 0;
			while (rs.next()) {
				count++;
			}
			long iTotalPage = count / ilimit;
			long acCount = iTotalPage * ilimit;
			if (acCount < count)
				iTotalPage++;

			cs.setInt(3, Start);
			cs.setInt(4, End);
			rs = cs.executeQuery();

			List<String> l = new Vector<String>();
			l.add("STT");
			l.add("EMP_ID");
			l.add("NAME");
			l.add("POSITION");
			l.add("HIRE_DATE");
			l.add("SALARY");
			l.add("BRANCH_CODE");
			l.add("DEPARTMENT");
			JSONArray array = Util.buildDataGridJson(rs, l);

			/*
			 * obj.put("page", getDTO.getPage()); obj.put("total",
			 * String.valueOf(iTotalPage)); obj.put("records", String.valueOf(count));
			 * obj.put("rows", array);
			 */
			return String.format("{\"total\":%1$s, \"records\":%2$s, \"rows\":%3$s}", iTotalPage, count, array);
		} catch (Exception ex) {
			System.out.println("EMPLOYEE_Impl.getJSON() error : " + ex.toString());
			return "{\"total\":0, \"records\":0, \"rows\":null}";
		}
	}

	@Override
	public String getXML(EMPLOYEE_GetDto getDTO) {
		return null;
	}

	public String CallIUP(int action, EMPLOYEE_PostDto postDTO) { 
		// action = 1: Insert,
		// 2: Update,
		// 3: Delete
		try {
			String sqlCall = "{ CALL SP_EMPLOYEE_Update(?, ?, ?, ?, ?, ?, ?, ?, ?, ? )}";
			CallableStatement cs = conn.prepareCall(sqlCall);
			if (postDTO.emp_id == null || postDTO.emp_id.trim().equals(""))
				cs.setNull(1, java.sql.Types.VARCHAR);
			else
				cs.setString(1, postDTO.emp_id);
			if (postDTO.name == null || postDTO.name.trim().equals(""))
				cs.setNull(2, java.sql.Types.VARCHAR);
			else
				cs.setString(2, postDTO.name);
			if (postDTO.position == null || postDTO.position.trim().equals(""))
				cs.setNull(3, java.sql.Types.VARCHAR);
			else
				cs.setString(3, postDTO.position);
			if (postDTO.hire_date == null || postDTO.hire_date.trim().equals(""))
				cs.setNull(4, java.sql.Types.VARCHAR);
			else
				cs.setString(4, postDTO.hire_date);
			if (postDTO.salary == null || postDTO.salary.trim().equals(""))
				cs.setNull(5, java.sql.Types.FLOAT);
			else
				cs.setFloat(5, Float.parseFloat(postDTO.salary));
			if (postDTO.branch_code == null || postDTO.branch_code.trim().equals(""))
				cs.setNull(6, java.sql.Types.VARCHAR);
			else
				cs.setString(6, postDTO.branch_code);
			if (postDTO.department == null || postDTO.department.trim().equals(""))
				cs.setNull(7, java.sql.Types.VARCHAR);
			else
				cs.setString(7, postDTO.department);

			cs.setInt(8, action);
			cs.registerOutParameter(9, java.sql.Types.INTEGER);
			cs.registerOutParameter(10, java.sql.Types.VARCHAR);

			cs.execute();

			int errcode = cs.getInt(9);
			String error = cs.getString(10);

			if (errcode == 0) {
				return "success";
			} else if (errcode == 2627) {
				return "duplicate";
			} else
				return error;
		} catch (Exception ex) {
			System.out.println("EMPLOYEE.CallIUP() error : " + ex.toString());
			ex.printStackTrace();
			return "error"; // ex.toString();
		}
	}

	@Override
	public String insert(EMPLOYEE_PostDto postDTO) {
		try {
			return CallIUP(1, postDTO);
		} catch (Exception ex) {
			System.out.println("EMPLOYEE.insert() error : " + ex.toString());
			ex.printStackTrace();
			return "error"; // ex.toString();
		}
	}

	@Override
	public String delete(EMPLOYEE_PostDto postDTO) {
		try {
			return CallIUP(3, postDTO);
		} catch (Exception ex) {
			// Luu y check dieu kien FK Contraint neu can!
			System.out.println("EMPLOYEE.delete() error : " + ex.toString());
			ex.printStackTrace();
			return "error"; //ex.toString();
		}
	}

	@Override
	public String update(EMPLOYEE_PostDto postDTO) {
		try {
			return CallIUP(2, postDTO);
		} catch (Exception ex) {
			System.out.println("EMPLOYEE.update() error : " + ex.toString());
			ex.printStackTrace();
			return "error"; //ex.toString();
		}
	}

}
