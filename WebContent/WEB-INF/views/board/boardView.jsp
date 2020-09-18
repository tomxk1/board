<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">
			
				$j(document).ready(function(){
			
					$j("#submit").on("click",function(){
						var $frm = $j('.boardDelete :input');
						var param = $frm.serialize();
						console.log(param);
						$j.ajax({
						    url : "/board/boardDeleteAction.do",
						    dataType: "json",
						    type: "POST",
						    data : param,
						    success: function(data, textStatus, jqXHR)
						    {
								alert("삭제완료");
								
								alert("메세지:"+data.success);
								
								location.href = "/board/boardList.do";
						    },
						    error: function (jqXHR, textStatus, errorThrown)
						    {
						    	alert("실패");
						    	
						    }
						});
					});
				});
			
			</script>
<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
						<c:forEach items="${creatorName}" var="list">
							<c:if test="${board.creator ==  list.userId}">
								${list.userName }
							</c:if>
						</c:forEach>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<form class="boardDelete">
				<input name="boardNum" type="hidden" size="0" value="${board.boardNum}">
				<input name="boardType" type="hidden" size="0" value="${board.boardType}"> 
				<input id="submit" type="button" value="삭제">
			</form>
			
			<a id="boardUpdate" href="/board/${board.boardType}/${board.boardNum}/boardUpdate.do">수정</a>
		</td>
		<td align="right">
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
</table>	
</body>
</html>