<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <head>
        <title>Employee</title>
        <link href="${pageContext.request.contextPath}/images/favicon.ico" rel="shortcut icon" />
    </head>

    <!-- The localization file we need, English in this case -->
    <link rel="stylesheet" type="text/css" media="screen" href='<%=request.getContextPath()%>/css/jquery.ui.theme.css' />
    <link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath()%>/css/jquery.checkboxtree.min.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath()%>/css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="<%=request.getContextPath()%>/js/jqGrid460/css/ui.jqgrid.css" />

    <script src="<%=request.getContextPath()%>/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script src='<%=request.getContextPath()%>/js/jquery-ui-1.10.4.custom.js' type="text/javascript"></script>
    <script src='<%=request.getContextPath()%>/js/jquery.bgiframe.js' type="text/javascript"></script>
    <script src='<%=request.getContextPath()%>/js/jquery.uniform.js' type="text/javascript"></script>
    <script src='<%=request.getContextPath()%>/js/jquery.checkboxtree.js' type="text/javascript"></script>
    <script src='<%=request.getContextPath()%>/js/jquery.maskedinput.js' type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/jqGrid460/grid.locale-en.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/jqGrid460/jquery.jqGrid.js" type="text/javascript"></script>

    <div id="mainbody">
        <%@ include file="../common/header.jsp"%>
            <div id="ja-wrapper">
                <div id="ja-wrapper-top"></div>
                <div id="ja-wrapper-inner" class="clearfix">
                    <font style="font-size: x-large;">QL Nhân Viên</font> <br /> <br />

                    <div id="dialog_search" title="Tìm kiếm">
                        <table width="70%">
                            <tr>
                                <td align=right><label for="EMP_ID_search">Mã nhân viên</label></td>
                                <td align=left><input type="text" id="EMP_ID_search" name="EMP_ID_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
                                <td align=right><label for="DEPARTMENT_search">Phòng ban</label></td>
                                <td align=left><input type="text" id="DEPARTMENT_search" name="DEPARTMENT_search" value="" class="text ui-widget-content ui-corner-all" maxlength="" /></td>
                            </tr>
                            <tr>
                            </tr>
                            <tr>
                                <td></td>
                                <td align=left><button id="search">Tìm kiếm</button></td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <button id="create" name="button" style="float: left;">Thêm	mới</button>
                    <button id="edit" name="button" style="float: left;">Sửa</button>
                    <button id="delete" name="button" style="float: left;">Xóa</button>
                    <br /> <br />
                    <table id="EMPLOYEEGrid"></table>
                    <div id="Pager1"></div>
                    <br />
                </div>
                <%@ include file="../common/footer.jsp"%>
            </div>
    </div>


    <script type="text/javascript">
        function reloadEMPLOYEEList() {
            var params = "";
            params += "emp_id=" + $("#EMP_ID_search").val();
            params += "&department=" + $("#DEPARTMENT_search").val();
            jQuery("#EMPLOYEEGrid").setGridParam({url: "<%=request.getContextPath() %>/EMPLOYEE_Servlet?" + params});
            jQuery("#EMPLOYEEGrid").clearGridData();
            jQuery("#EMPLOYEEGrid").trigger("reloadGrid");
        }

        function clear_create() {
            $("#EMP_ID_create").val("");
            $("#NAME_create").val("");
            $("#POSITION_create").val("");
            $("#HIRE_DATE_create").val("");
            $("#SALARY_create").val("");
            $("#BRANCH_CODE_create").val("");
            $("#DEPARTMENT_create").val("");
        }

        function isValidForm_create() {
            var emp_id = trim($("#EMP_ID_create").val());
            var name = trim($("#NAME_create").val());
            if (!((emp_id == "") || (name == ""))) {
                return true;
            }
        }

        function isValidForm_edit() {
        	console.log("valid form");
        	//
            var emp_id = trim($("#EMP_ID_edit").val());
            console.log(emp_id);
            var name = trim($("#NAME_edit").val());
            console.log(name);
            if (!((emp_id == "") || (name == ""))) {
                return true;
            }
        }

        function trim(value) {
            var reL = /\s*((\S+\s*)*)/;
            var reR = /((\s*\S+)*)\s*/;
            value = value.replace(reL, "$1");
            return value.replace(reR, "$1");
        }

        function buildDataCreate() {
            var obj = new Object();
            obj.method = "insert";
            obj.EMP_ID = $("#EMP_ID_create").val();
            obj.NAME = $("#NAME_create").val();
            obj.POSITION = $("#POSITION_create").val();
            obj.HIRE_DATE = $("#HIRE_DATE_create").val();
            obj.SALARY = $("#SALARY_create").val();
            obj.BRANCH_CODE = $("#BRANCH_CODE_create").val();
            obj.DEPARTMENT = $("#DEPARTMENT_create").val();
            return obj;
        }

        function buildDataEdit() {
            var obj = new Object();
            obj.method = "update";
            obj.EMP_ID = $("#EMP_ID_edit").val();
            obj.NAME = $("#NAME_edit").val();
            obj.POSITION = $("#POSITION_edit").val();
            obj.HIRE_DATE = $("#HIRE_DATE_edit").val();
            obj.SALARY = $("#SALARY_edit").val();
            obj.BRANCH_CODE = $("#BRANCH_CODE_edit").val();
            obj.DEPARTMENT = $("#DEPARTMENT_edit").val();
            return obj;
        }

        function buildDataDelete() {
            var obj = new Object();
            obj.method = "delete";
            var id = jQuery("#EMPLOYEEGrid").jqGrid('getGridParam', 'selrow');
            if (id) {
                var ret = jQuery("#EMPLOYEEGrid").jqGrid('getRowData', id);
            }
            obj.EMP_ID = ret.EMP_ID;
            /* obj.name = $("#NAME_edit").val();
            obj.GT = $("#POSITION_edit").val();
            obj.NS = $("#HIRE_DATE_edit").val();
            obj.Que = $("#SALARY_edit").val();
            obj.Lop = $("#BRANCH_CODE_edit").val(); */
            return obj;
        }

        $(function() {

            jQuery("#EMPLOYEEGrid").jqGrid({
                url: '<%=request.getContextPath()%>/EMPLOYEE_Servlet',
                datatype: "json",
                colNames: ['STT', 'EMP_ID', 'NAME', 'POSITION', 'HIRE_DATE', 'SALARY', 'BRANCH_CODE', 'DEPARTMENT'],
                colModel: [{
                    name: 'STT',
                    index: 'STT',
                    width: 80,
                    align: "center"
                }, {
                    name: 'EMP_ID',
                    index: 'EMP_ID',
                    width: 110
                }, {
                    name: 'NAME',
                    index: 'NAME',
                    width: 180
                }, {
                    name: 'POSITION',
                    index: 'POSITION',
                    width: 100
                }, {
                    name: 'HIRE_DATE',
                    index: 'HIRE_DATE',
                    width: 100,
                    align: "center"
                }, {
                    name: 'SALARY',
                    index: 'SALARY',
                    width: 120,
                    align: "center"
                }, {
                    name: 'BRANCH_CODE',
                    index: 'BRANCH_CODE',
                    width: 100
                }, {
                    name: 'DEPARTMENT',
                    index: 'DEPARTMENT',
                    width: 120
                }],
                rowNum: 15,
                rowList: [15, 30, 60, 80, 150],
                pager: '#Pager1',
                scrollrows: true,
                autowidth: true,
                height: 370,
                width: 1200,
                shrinkToFit: false,
                caption: " Danh sách Nhân viên",
                sortname: 'EMP_ID',
                viewrecords: true,
                sortorder: "ASC",

            }).navGrid('#Pager1', {
                edit: false,
                add: false,
                del: false,
                search: false,
                refresh: true,
                view: false,
                position: "left",
                cloneToTop: true
            });

            $("#create")
                .button()
                .click(function() {
                    clear_create();
                    $("#dialog_form_create").dialog({
                        autoOpen: true,
                        height: 300,
                        width: 400,
                        modal: true,
                        buttons: {
                            Cancel: {
                                text: 'Hủy bỏ',
                                click: function() {
                                    $(this).dialog("close");
                                }
                            },
                            Create: {
                                text: 'Lưu',
                                click: function() {
                                    blockflag = true;
                                    if (isValidForm_create()) {
                                        $.ajax({
                                            type: "POST",
                                            url: "<%=request.getContextPath()%>/EMPLOYEE_Servlet",
                                            data: buildDataCreate(),
                                            error: function() {
                                                $("#dialog_error").dialog({
                                                    modal: true,
                                                    buttons: {
                                                        OK: function() {
                                                            $(this).dialog("close");
                                                        }
                                                    }
                                                });
                                                blockflag = false;
                                            },
                                            success: function(msg) {
                                                if (msg.trim() == 'success') {
                                                    jQuery("#EMPLOYEEGrid").trigger("reloadGrid");
                                                } else {
                                                    document.getElementById('dialog_error').innerHTML = "<font style='color:red;'>Có lỗi xảy ra " + msg + ". Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
                                                    $("#dialog_error").dialog({
                                                        modal: true,
                                                        buttons: {
                                                            OK: function() {
                                                                $(this).dialog("close");
                                                            }
                                                        }
                                                    });
                                                    blockflag = false;
                                                };
                                            }
                                        });
                                        $(this).dialog("close");
                                    } else {
                                        $("#dialog_validate").dialog({
                                            modal: true,
                                            height: 230,
                                            width: 350,
                                            buttons: {
                                                OK: function() {
                                                    $(this).dialog("close");
                                                }
                                            }
                                        });
                                    }
                                }
                            }
                        }
                    })
                });


            $("#edit")
                .button()
                .click(function() {
                    $("#dialog_form_edit").dialog({
                        autoOpen: false,
                        height: 300,
                        width: 400,
                        modal: true,
                        buttons: {
                            Cancel: {
                                text: 'Hủy bỏ',
                                click: function() {
                                    $(this).dialog("close");
                                }
                            },
                            Save: {
                                text: 'Lưu',
                                click: function() {
                                    blockflag = true;
                                    if (isValidForm_edit()) {
                                        $.ajax({
                                            type: "POST",
                                            url: "<%=request.getContextPath()%>/EMPLOYEE_Servlet",
                                            data: buildDataEdit(),
                                            error: function() {

                                                $("#dialog_error").dialog({
                                                    modal: true,
                                                    buttons: {
                                                        OK: function() {
                                                            $(this).dialog("close");
                                                        }
                                                    }
                                                });
                                                blockflag = false;
                                            },
                                            success: function(msg) {
                                                if (msg.trim() == 'success') {
                                                    jQuery("#EMPLOYEEGrid").trigger("reloadGrid");
                                                } else {
                                                    document.getElementById('dialog_error').innerHTML = "<font style='color:red;'>Có lỗi xảy ra " + msg + ". Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
                                                    $("#dialog_error").dialog({
                                                        modal: true,
                                                        buttons: {
                                                            OK: function() {
                                                                $(this).dialog("close");
                                                            }
                                                        }
                                                    });
                                                    blockflag = false;
                                                };
                                            }
                                        });
                                        $(this).dialog("close");
                                    } else {
                                        $("#dialog_validate").dialog({
                                            modal: true,
                                            height: 230,
                                            width: 350,
                                            buttons: {
                                                OK: function() {
                                                    $(this).dialog("close");
                                                }
                                            }
                                        });
                                    }
                                }
                            }
                        }
                    });
                    var id = jQuery("#EMPLOYEEGrid").jqGrid('getGridParam', 'selrow');
                    if (id) {
                        var ret = jQuery("#EMPLOYEEGrid").jqGrid('getRowData', id);
                        $("#EMP_ID_edit").val(ret.EMP_ID);
                        $("#NAME_edit").val(ret.NAME);
                        $("#POSITION_edit").val(ret.POSITION);
                        $("#HIRE_DATE_edit").val(ret.HIRE_DATE);
                        $("#SALARY_edit").val(ret.SALARY);
                        $("#BRANCH_CODE_edit").val(ret.BRANCH_CODE);
                        $("#DEPARTMENT_edit").val(ret.DEPARTMENT);
                        $("#dialog_form_edit").dialog("open");
                    } else {
                        $("#dialog_info").dialog({
                            modal: true,
                            height: 230,
                            width: 350,
                            buttons: {
                                OK: function() {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    }
                });


            $("#delete")
                .button()
                .click(function() {
                    var id1 = jQuery("#EMPLOYEEGrid").jqGrid('getGridParam', 'selrow');
                    if (id1) {
                        var ret = jQuery("#EMPLOYEEGrid").jqGrid('getRowData', id1);
                        $("#dialog_confirm_delete").dialog({
                            resizable: false,
                            height: 140,
                            modal: true,
                            buttons: {
                                "Xóa": function() {
                                    blockflag = true;
                                    $.ajax({
                                        type: "POST",
                                        url: "<%=request.getContextPath()%>/EMPLOYEE_Servlet",
                                        data: buildDataDelete(),
                                        error: function() {
                                            $(
                                                    "#dialog_error")
                                                .dialog({
                                                    modal: true,
                                                    buttons: {
                                                        OK: function() {
                                                            $(
                                                                    this)
                                                                .dialog(
                                                                    "close");
                                                        }
                                                    }
                                                });
                                            blockflag = false;
                                        },
                                        success: function(
                                            msg) {
                                            if (msg
                                                .trim() == 'success') {
                                                jQuery(
                                                        "#EMPLOYEEGrid")
                                                    .trigger(
                                                        "reloadGrid");
                                            } else {
                                                document
                                                    .getElementById('dialog_error').innerHTML = "<font style='color:red;'>Có lỗi xảy ra " +
                                                    msg +
                                                    ". Vui lòng thử lại hoặc liên hệ với hỗ trợ.</font>";
                                                $(
                                                        "#dialog_error")
                                                    .dialog({
                                                        modal: true,
                                                        buttons: {
                                                            OK: function() {
                                                                $(
                                                                        this)
                                                                    .dialog(
                                                                        "close");
                                                            }
                                                        }
                                                    });
                                                blockflag = false;
                                            };
                                        }
                                    });
                                    $(this).dialog(
                                        "close");
                                },
                                Cancel: function() {
                                    $(this).dialog(
                                        "close");
                                }
                            }
                        });
                        /* $( this ).dialog( "close" ); */
                    } else {
                        $("#dialog_info").dialog({
                            modal: true,
                            height: 230,
                            width: 350,
                            buttons: {
                                OK: function() {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    }
                });
        });
    </script>


    <div id="dialog_form_create" style="display: none;" title="Thêm mới">
        <form>
            <table width="100%">
                <tr>
                    <td align=left><label for="EMP_ID_create">Mã nhân viên<font
						color="red"> (*)</font></label></td>
                    <td align=left><input type="text" id="EMP_ID_create" name="EMP_ID_create" value="" class="text ui-widget-content ui-corner-all" maxlength="50" /></td>
                </tr>
                <tr>
                    <td align=left><label for="NAME_create">Họ tên<font
						color="red"> (*)</font></label></td>
                    <td align=left><input type="text" id="NAME_create" name="NAME_create" value="" class="text ui-widget-content ui-corner-all" maxlength="200" /></td>
                </tr>

                <tr>
                    <td align=left><label for="POSITION_create">Vị trí</label></td>
                    <td align=left><input type="text" id="POSITION_create" name="POSITION_create" value="" class="text ui-widget-content ui-corner-all" maxlength="16" /></td>
                </tr>

                <tr>
                    <td align=left><label for="HIRE_DATE_create">Ngày</label></td>
                    <td align=left><input type="text" id="HIRE_DATE_create" name="HIRE_DATE_create" value="" class="text ui-widget-content ui-corner-all" maxlength="16" /></td>
                </tr>


                <tr>
                    <td align=left><label for="SALARY_create">Lương</label></td>
                    <td align=left><input type="text" id="SALARY_create" name="SALARY_create" value="" class="text ui-widget-content ui-corner-all" maxlength="100" /></td>
                </tr>

                <tr>
                    <td align=left><label for="BRANCH_CODE_create">Chi
						nhánh</label></td>
                    <td align=left><input type="text" id="BRANCH_CODE_create" name="BRANCH_CODE_create" value="" class="text ui-widget-content ui-corner-all" maxlength="100" /></td>
                </tr>

                <tr>
                    <td align=left><label for="DEPARTMENT_create">Phòng ban</label></td>
                    <td align=left><input type="text" id="DEPARTMENT_create" name="DEPARTMENT_create" value="" class="text ui-widget-content ui-corner-all" maxlength="100" /></td>
                </tr>

                <tr>
                </tr>
            </table>
        </form>
    </div>
    <br />


    <div id="dialog_form_edit" style="display: none" title="Sửa">
        <form>
            <table width="100%">
                <tr>
                    <td align=left><label for="EMP_ID_edit">Mã nhân viên<font
						color="red">(*)</font></label></td>
                    <td align=left><input type="text" id="EMP_ID_edit" name="EMP_ID_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="50" disabled="disabled" /></td>
                </tr>
                <tr>
                    <td align=left><label for="NAME_edit">Họ tên<font
						color="red">(*)</font></label></td>
                    <td align=left><input type="text" id="NAME_edit" name="NAME_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="200" /></td>
                </tr>
                <tr>
                    <td align=left><label for="POSITION_edit">Vị trí</label></td>
                    <td align=left><input type="text" id="POSITION_edit" name="POSITION_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="200" /></td>
                </tr>
                <tr>
                    <td align=left><label for="HIRE_DATE_edit">Ngày sinh</label></td>
                    <td align=left><input type="text" id="HIRE_DATE_edit" name="HIRE_DATE_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="8" /></td>
                </tr>

                <tr>
                    <td align=left><label for="SALARY_edit">Lương</label></td>
                    <td align=left><input type="text" id="SALARY_edit" name="SALARY_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="100" /></td>
                </tr>

                <tr>
                    <td align=left><label for="BRANCH_CODE_edit">Chi nhánh</label></td>
                    <td align=left><input type="text" id="BRANCH_CODE_edit" name="BRANCH_CODE_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="100" /></td>
                </tr>

                <tr>
                    <td align=left><label for="DEPARTMENT_edit">Phòng ban</label></td>
                    <td align=left><input type="text" id="DEPARTMENT_edit" name="DEPARTMENT_edit" value="" class="text ui-widget-content ui-corner-all" maxlength="100" /></td>
                </tr>


                <tr>
                </tr>
            </table>
        </form>
    </div>




    <div id="dialog_validate" style="display: none" title="Thông báo">
        Dữ liệu nhập vào chưa đầy đủ. Hãy kiểm tra lại các trường có dấu
        <font color="red"> (*)</font> <br />
    </div>

    <div id="dialog_info" style="display: none" title="Thông báo">Hãy chọn một bản ghi</div>

    <div id="dialog_confirm_delete" style="display: none" title="Thông báo">
        Có chắc muốn xóa không?</div>
    <div id="dialog_error" style="display: none" title="Báo lỗi">Có lỗi xảy ra. Hãy kiểm tra lại!</div>
    <script type="text/javascript">
        $(document).ready(
            function() {
                $("#EMP_ID_search").keypress(function(event) {
                    if (event.which == 13) {
                        reloadEMPLOYEEList();
                    }
                });
                $("#DEPARTMENT_search").keypress(function(event) {
                    if (event.which == 13) {
                        reloadEMPLOYEEList();
                    }
                });
                $("#search").button().click(function() {
                    reloadEMPLOYEEList();
                }); //end #search 

                $("#HIRE_DATE_create")
                    .datepicker({
                        dateFormat: "dd/mm/yy",
                        dayNames: ['Thứ hai', 'Thứ ba', 'Thứ tư',
                            'Thứ năm', 'Thứ sáu', 'Thứ bảy',
                            'Chủ nhật'
                        ],
                        dayNamesMin: ['CN', 'T2', 'T3', 'T4',
                            'T5', 'T6', 'T7'
                        ],
                        dayNamesShort: ['CN', 'Th2', 'Th3',
                            'Th4', 'Th5', 'Th6', 'Th7'
                        ],
                        monthNames: ['Tháng 1', 'Tháng 2',
                            'Tháng 3', 'Tháng 4', 'Tháng 5',
                            'Tháng 6', 'Tháng 7', 'Tháng 8',
                            'Tháng 9', 'Tháng 10', 'Tháng 11',
                            'Tháng 12'
                        ],
                        yearSuffix: ''
                    });

                $("#HIRE_DATE_edit")
                    .datepicker({
                        dateFormat: "dd/mm/yy",
                        dayNames: ['Thứ hai', 'Thứ ba', 'Thứ tư',
                            'Thứ năm', 'Thứ sáu', 'Thứ bảy',
                            'Chủ nhật'
                        ],
                        dayNamesMin: ['CN', 'T2', 'T3', 'T4',
                            'T5', 'T6', 'T7'
                        ],
                        dayNamesShort: ['CN', 'Th2', 'Th3',
                            'Th4', 'Th5', 'Th6', 'Th7'
                        ],
                        monthNames: ['Tháng 1', 'Tháng 2',
                            'Tháng 3', 'Tháng 4', 'Tháng 5',
                            'Tháng 6', 'Tháng 7', 'Tháng 8',
                            'Tháng 9', 'Tháng 10', 'Tháng 11',
                            'Tháng 12'
                        ],
                        yearSuffix: ''
                    });

            });
    </script>