var clickedAddNew = false;
var clickEdit = false;
var beforeEditStartTime = "";
var beforeEditEndTime = "";
var beforeEditDayOfWeek = "";
var EditableTable = function () {

    return {

        //main function to initiate the module
        init: function () {
            function restoreRow(oTable, nRow) {
                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);

                for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                    oTable.fnUpdate(aData[i], nRow, i, false);
                }

                oTable.fnDraw();
            }

            /**
             *
             * @param oTable
             * @param nRow
             * @param type  2-新增
             */
            function editRow(oTable, nRow, type) {

                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);
                beforeEditDayOfWeek = aData[0];
                beforeEditStartTime = aData[1];
                beforeEditEndTime = aData[2];
                var week = ["Sun", "Mon", "Tus", "Wed", "Thu", "Fri", "Sat"];
                var option = "";
                if (type == 2) {
                    option = '<select class="form-control small ">';
                    for (var index = 0; index < week.length; index++) {
                        if (aData[0] == week[index]) {
                            option = option + '<option value="' + week[index] + '" selected>' + week[index] + '</option>';
                        } else {
                            option = option + '<option value="' + week[index] + '">' + week[index] + '</option>';
                        }
                    }
                    option = option + "</select>";
                } else {
                    option = aData[0];
                }
                var startTimeOption = "";
                var endTimeOption = "";
                var hour = 0;
                for (var index = 0; index < 24; index++) {
                    if (index < 10) {
                        hour = "0" + index;
                    } else {
                        hour = index;
                    }
                    if (hour + ":00" == aData[1]) {
                        startTimeOption = startTimeOption + '<option value="' + hour + ':00" selected>' + hour + ':00</option>';
                    } else {
                        startTimeOption = startTimeOption + '<option value="' + hour + ':00">' + hour + ':00</option>';
                    }
                    if (hour + ":30" == aData[1]) {
                        startTimeOption = startTimeOption + '<option value="' + hour + ':30" selected>' + hour + ':30</option>';
                    } else {
                        startTimeOption = startTimeOption + '<option value="' + hour + ':30">' + hour + ':30</option>';
                    }
                    if (hour + ":00" == aData[2]) {
                        endTimeOption = endTimeOption + '<option value="' + hour + ':00" selected>' + hour + ':00</option>';
                    } else {
                        endTimeOption = endTimeOption + '<option value="' + hour + ':00">' + hour + ':00</option>';
                    }
                    if (hour + ":30" == aData[2]) {
                        endTimeOption = endTimeOption + '<option value="' + hour + ':30" selected>' + hour + ':30</option>';
                    } else {
                        endTimeOption = endTimeOption + '<option value="' + hour + ':30">' + hour + ':30</option>';
                    }
                }
                jqTds[0].innerHTML = option;
                // jqTds[0].innerHTML = '<input type="text" class="form-control small" value="' + aData[0] + '">';
                jqTds[1].innerHTML = '<select class="form-control small ">' + startTimeOption + '</select>';
                jqTds[2].innerHTML = '<select class="form-control small ">' + endTimeOption + '</select>';
                jqTds[3].innerHTML = '';
                if (type == 2) {
                    jqTds[4].innerHTML = '<a class="edit" href="#" data-mode="new" >Save</a>&nbsp;<a class="cancel" data-mode="new" href="#">Cancel</a>';
                } else {
                    clickEdit = true;
                    jqTds[4].innerHTML = '<a class="edit" href="#">Save</a>&nbsp;<a class="cancel" href="#">Cancel</a>';
                }
            }

            function saveRow(oTable, nRow, type) {
                if (type == "edit") {
                    var jqInputs = $('select', nRow);
                    //  oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                    oTable.fnUpdate(jqInputs[0].value, nRow, 1, false);
                    oTable.fnUpdate(jqInputs[1].value, nRow, 2, false);
                    oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 3, false);
                    oTable.fnUpdate('<a class="delete" href="">Delete</a>', nRow, 4, false);
                } else if (type == "new") {
                    var jqInputs = $('select', nRow);
                    oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                    oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
                    oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
                    oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 3, false);
                    oTable.fnUpdate('<a class="delete" href="">Delete</a>', nRow, 4, false);
                }
                oTable.fnDraw();
            }

            function cancelEditRow(oTable, nRow) {
                var jqInputs = $('input', nRow);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
                oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 4, false);
                oTable.fnDraw();
            }

            var oTable = $('#editable-sample').dataTable({
                "aLengthMenu": [
                    [15, 25, 35, -1],
                    [15, 25, 35, "All"] // change per page values here
                ],
                // set the initial value
                "iDisplayLength": 15,
                "sDom": "<'row'<'col-lg-6'l><'col-lg-6'f>r>t<'row'<'col-lg-6'i><'col-lg-6'p>>",
                "sPaginationType": "bootstrap",
                "oLanguage": {
                    "sLengthMenu": "_MENU_ records per page",
                    "oPaginate": {
                        "sPrevious": "Prev",
                        "sNext": "Next"
                    }
                },
                "aoColumnDefs": [
                    {
                        'bSortable': false,
                        'aTargets': [0]
                    }
                ]
            });

            jQuery('#editable-sample_wrapper .dataTables_filter input').addClass("form-control medium"); // modify table search input
            jQuery('#editable-sample_wrapper .dataTables_length select').addClass("form-control xsmall"); // modify table per page dropdown

            var nEditing = null;

            $('#editable-sample_new').click(function (e) {
                e.preventDefault();
                if (clickedAddNew == true) {
                    toastr["error"]("please save or cancel first");
                    return;
                }
                if (clickEdit == true) {
                    toastr["error"]("please save or cancel first");
                    return;
                }
                clickedAddNew = true;
                var aiNew = oTable.fnAddData(['', '', '',
                    '<a class="edit" href="#">Edit</a>', '<a class="cancel" data-mode="new" href="#">Cancel</a>'
                ]);
                var nRow = oTable.fnGetNodes(aiNew[0]);
                editRow(oTable, nRow, 2);
                nEditing = nRow;

            });

            $('#editable-sample a.delete').live('click', function (e) {
                e.preventDefault();

                if (confirm("Are you sure to delete this row  ?") == false) {
                    return;
                }
                var nRow = $(this).parents('tr')[0];
                var aData = oTable.fnGetData(nRow);
                oTable.fnDeleteRow(nRow);
                var start = aData[1];
                var end = aData[2];
                var openhour = "";
                openhour = openhour + start;
                openhour = openhour + "," + end;
                AjaxSubmitUtil.ajaxSubmit(ctx + "/profile/delete", {"restaurantId": restaurantId, "date": aData[0], "openhour": openhour }, "json", function (data) {
                    if (data.code == 0) {
                        toastr["success"]("success");
                        //    window.location.href = ctx + "/profile?id="+restaurantId;
                    } else {
                        toastr["error"](data.message);
                        return;
                    }
                });
            });

            $('#editable-sample a.cancel').live('click', function (e) {
                e.preventDefault();
                if ($(this).attr("data-mode") == "new") {
                    var nRow = $(this).parents('tr')[0];
                    oTable.fnDeleteRow(nRow);
                } else {
                    restoreRow(oTable, nEditing);
                }
                nEditing = null;
                beforeEditDayOfWeek = "";
                beforeEditStartTime = "";
                beforeEditEndTime = "";
                clickEdit = false;
                clickedAddNew = false;
            });

            $('#editable-sample a.edit').live('click', function (e) {
                e.preventDefault();

                /* Get the row as a parent of the link that was clicked on */
                var nRow = $(this).parents('tr')[0];
                var aData = oTable.fnGetData(nRow);
                var jqInputs = $('select', nRow);

                if (nEditing != null && nEditing != nRow) {
                    /* Currently editing - but not this row - restore the old before continuing to edit mode */
                    if (clickedAddNew == true) {
                        toastr["error"]("please save or cancel first");
                        return;
                    }
                    if (clickEdit == true) {
                        toastr["error"]("please save or cancel first");
                        return;
                    }
                    restoreRow(oTable, nEditing);
                    editRow(oTable, nRow);
                    nEditing = nRow;

                } else if (nEditing == nRow && this.innerHTML == "Save") {
                    /* Editing this row and want to save it */
                    if ($(this).attr("data-mode") == "new") {
                        saveRow(oTable, nEditing, "new");
                        clickEdit = false;
                        clickedAddNew = false;
                        var date =jqInputs[0].value;
                        var start = jqInputs[1].value;
                        var end = jqInputs[2].value;
                        var openhour = "";
                        openhour = openhour + start;
                        openhour = openhour + "," + end;
                        AjaxSubmitUtil.ajaxSubmit(ctx + "/profile/openhour", {"restaurantId": restaurantId, "date": date, "openHour": openhour}, "json", function (data) {
                            if (data.code == 0) {
                                toastr["success"]("success");
                            } else {
                                toastr["error"](data.message);
                                return;
                            }
                        });
                        return ;
                    } else {
                        saveRow(oTable, nEditing, "edit");
                        nEditing = null;
                        var date = aData[0];
                        var start = jqInputs[0].value;
                        var end = jqInputs[1].value;
                        var openhour = "";
                        openhour = openhour + start;
                        openhour = openhour + "," + end;
                        clickEdit = false;
                        clickedAddNew = false;
                        var timeString = openHourJson[beforeEditDayOfWeek];
                        timeString = timeString.replace(beforeEditStartTime+"to"+beforeEditEndTime,start+"to"+end);
                        AjaxSubmitUtil.ajaxSubmit(ctx + "/profile/openhour/edit", {"restaurantId": restaurantId, "date": date, "timeString": timeString}, "json", function (data) {
                            if (data.code == 0) {
                                toastr["success"]("success");
                            } else {
                                toastr["error"](data.message);
                                return;
                            }
                        });
                        return ;
                    }
                } else {
                    if (clickedAddNew == true) {
                        toastr["error"]("please save or cancel first");
                        return;
                    }
                    /* No edit in progress - let's start one */
                    editRow(oTable, nRow, 3);
                    nEditing = nRow;
                }

            });
        }

    };

}();