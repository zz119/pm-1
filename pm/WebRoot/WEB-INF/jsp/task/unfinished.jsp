<%@ page import="com.icker.pm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<table class="table table-striped table-hover">
	<tr>
		<th></th>
		<th></th>
		<th>#</th>
		<th>名称</th>
		<th>负责人</th>
		<th>进度</th>
		<th>截止时间</th>
		<th></th>
		<th></th>
	</tr>
	<c:forEach items="${tasks }" var="task">
		<tr>
			<td name="taskTD0" class="hide"><c:out value="${task.id }"></c:out></td>
			<td name="TD00"><label></label></td>
			<td name="taskTD1">
				<c:if test="${task.status=='0' }"><!-- 未完成 -->
					<input name="check" type="checkbox">
				</c:if>
				<c:if test="${task.status=='1' }"><!-- 完成 -->
					<input name="check" type="checkbox" checked="checked" disabled="disabled">
				</c:if>
				<c:if test="${task.status=='2' }"><!-- 延期 -->
					<input name="check" type="checkbox">
				</c:if>
			</td>
			<td name="taskTD2"><c:out value="${task.sequence }"></c:out></td>
			<td name="taskTD3"><c:if test="${task.priority ==1}">
					<span name="tName" class="label label-danger" data-container="body"
						data-toggle="popover" data-placement="right" title="细节描述"
						data-content="${task.description }" style="cursor: pointer;"><c:out
							value="${task.name }"></c:out></span>
				</c:if> <c:if test="${task.priority ==2}">
					<span name="tName" class="label label-warning"
						data-container="body" data-toggle="popover" data-placement="right"
						title="细节描述" data-content="${task.description }"
						style="cursor: pointer;"><c:out value="${task.name }"></c:out></span>
				</c:if> <c:if test="${task.priority ==3}">
					<span name="tName" class="label label-info" data-container="body"
						data-toggle="popover" data-placement="right" title="细节描述"
						data-content="${task.description }" style="cursor: pointer;"><c:out
							value="${task.name }"></c:out></span>
				</c:if> <script>
					$(function() {
						$("[data-toggle='popover']").popover().on(
								"mouseenter",
								function() {
									var _this = this;
									$(this).popover("show");
									$(this).siblings(".popover").on(
											"mouseleave", function() {
												$(_this).popover('hide');
											});
								}).on("mouseleave", function() {
							var _this = this;
							setTimeout(function() {
								if (!$(".popover:hover").length) {
									$(_this).popover("hide");
								}
							}, 100);
						});
					});
				</script></td>
			<td name="taskTD4"><c:out value="${task.performer }"></c:out></td>
			<td name="taskTD5" style="width: 150px;">
				<div class="progress" name="sliderBar">
					<div class="progress-bar progress-bar-striped active"
						role="progressbar" aria-valuenow="${task.progress }"
						aria-valuemin="0" aria-valuemax="100"
						style="width: ${task.progress }%">
						<c:out value="${task.progress }%"></c:out>
					</div>
				</div>
			</td>
			<td name="taskTD6"><c:out value="${task.endDate }"></c:out></td>
			<td name="taskTD7">
				<c:if test="${task.status=='0' }"><!-- 未完成 -->
					<button id="editTask" name='editTask' class="btn btn-link">
						<span class="glyphicon glyphicon glyphicon-edit"></span>
					</button>
					<button id="deleteTask" name="deleteTask" class="btn btn-link">
						<span class="glyphicon glyphicon-trash"></span>
					</button>
				</c:if>
				<c:if test="${task.status=='1' }"><!-- 完成 -->
				
					<button class="btn btn-link" disabled>
						<span class="glyphicon glyphicon glyphicon-edit"></span>
					</button>
					<button class="btn btn-link " disabled>
						<span class="glyphicon glyphicon-trash"></span>
					</button>
				</c:if>
				<c:if test="${task.status=='2' }"><!-- 延期 -->
					<button id="editTask" name='editTask' class="btn btn-link">
						<span class="glyphicon glyphicon glyphicon-edit"></span>
					</button>
					<button id="deleteTask" name="deleteTask" class="btn btn-link">
						<span class="glyphicon glyphicon-trash"></span>
					</button>
				</c:if>
			</td>
			<td name="taskTD8"></td>
			<td name="taskTD9" class="hide"><c:out
					value="${task.startDate }"></c:out></td>
			<td name="taskTD10" class="hide"><c:out
					value="${task.priority }"></c:out></td>
			<td name="taskTD11" class="hide"><c:out
					value="${task.progress }"></c:out></td>
			<td name="taskTD12" class="hide"><c:out
					value="${task.performerId }"></c:out></td>
			<td name="taskTD13" class="hide"><c:out
					value="${task.description }"></c:out></td>
		<tr>
	</c:forEach>
</table>
<script type="text/javascript">
	var date = new Date();
	$("td[name='taskTD6']").each(function(){
		var date2 = new Date($(this).text().trim());
		var time = (date2.getTime()-date.getTime())/60/60/1000/24;
		if(time<2 && time>0) {
			$(this).parent("tr").children("td[name='TD00']").children("label").addClass("label label-warning").text("即将到期");
		}
		if(time<0) {
			$(this).parent("tr").children("td[name='TD00']").children("label").addClass("label label-danger").text("延期");
		}
	});
	
	$("input[name='check']").change(
		function(e) {
			var taskId = $(this).parent("td").parent("tr").children(
					"td[name='taskTD0']").text().trim();
			var proId = $("#hiddenProId").val();
			/* 当前被选中 */
			if($(this)[0].checked) {
				$.ajax({
					url : "taskController/completeTask",
					data : "id=" + taskId + "&proId=" + proId,
					type : "post",
					dataType : "html",
					success : function(data) {
						$("#infoTable").empty();
						$("#infoTable").html(data);
					},
					error : function(data) {
						alert("error" + data);
					}
				});
			} else {	/* 当前被释放 */
				$.ajax({
					url : "taskController/releaseTask",
					data : "id=" + taskId + "&proId=" + proId,
					type : "post",
					dataType : "html",
					success : function(data) {
						$("#infoTable").empty();
						$("#infoTable").html(data);
					},
					error : function(data) {
						alert("error" + data);
					}
				});
			}
		});
	$("button[name='editTask']").click(
			function(e) {
				var taskId = $(this).parent("td").parent("tr").children(
						"td[name='taskTD0']").text().trim();
				var performerId = $(this).parent("td").parent("tr").children(
						"td[name='taskTD12']").text().trim();
				var name = $(this).parent("td").parent("tr").children(
						"td[name='taskTD3']").children("span").text().trim();
				var startDate = $(this).parent("td").parent("tr").children(
						"td[name='taskTD9']").text().trim();
				var endDate = $(this).parent("td").parent("tr").children(
						"td[name='taskTD6']").text().trim();
				var priority = $(this).parent("td").parent("tr").children(
						"td[name='taskTD10']").text().trim();
				var progress = $(this).parent("td").parent("tr").children(
						"td[name='taskTD11']").text().trim();
				var description = $(this).parent("td").parent("tr").children(
						"td[name='taskTD13']").text().trim();
				$("#editTaskModal").modal('show');
				$("#editTaskModal").find("#editTaskId").val(taskId);
				$("#editTaskModal").find("#editTaskName").val(name);
				$("#editTaskModal").find("#editUser").val(performerId);
				$("#editTaskModal").find("#editStartDate").val(startDate);
				$("#editTaskModal").find("#editEndDate").val(endDate);
				$("#editTaskModal").find("#editPriority").val(priority);
				$("#editTaskModal").find("#editTaskDesc").val(description);
				$("#editTaskModal").find("#editProgress").children("div").attr(
						"aria-valuenow", progress);
				$("#editTaskModal").find("#editProgress").children(
						"div[role='progressbar']").attr("aria-valuenow",
						progress).html(progress + "%");
				$("#editTaskModal").find("#editProgress").children(
						"div[role='progressbar']")
						.css("width", +progress + "%");
			});

	// 点击删除任务
	$("button[name='deleteTask']").click(
			function(e) {
				var taskId = $(this).parent("td").parent("tr").children(
						"td[name='taskTD0']").text().trim();
				$("#deleteModal").modal('show');
				$("#task_id_hidden").val(taskId);
			});
</script>