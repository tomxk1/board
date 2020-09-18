<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$j(document).ready(function(){
    $j("#check-all").click(function(){
        if($j("#check-all").prop("checked")){
            $j("input[name=boardType]").prop("checked",true);
        }
        else{
            $j("input[name=boardType]").prop("checked",false);
        }
    });
    	  
    	   
    	    $j("#submit").on("click", function(){
    	    		//json방식	
				    var $frm = $j(".boardCheck :input");
			    	var param = $frm.serialize();
			    	
			        var boardList= [];
			    	var html = [];
			    	var html2 = [];
			    	var tBody = $j('#tBody');
			    	var totalCntTd = $j('#totalCntTd');
			    	
			    	console.log("값="+param);
		    	    $j.ajax({
		    	    	url : "/board/boardListAction.do",
		    	    	dataType: "json",
		    	    	type: "POST",
		    	    	data: param,
		    			success: function(data, textStatus, jqXHR)
		    			{
		    				tBody.empty();//비워준다
		    				totalCntTd.empty();//비워준다
		    				console.log(data.boardType);
		    				
		    				console.log(data+"123");
		    				tBody.html(data);
		    				
	    					//게시물 갯수
		    				totalCntTd.append("total : "+data.totalCntInt);
		    				
	    					boardList = data.boardList;
	    					boardTypeList = data.boardTypeList;
		   					for(i=0; i<boardList.length; i++){
		   						//alert("list"+boardList[i]);
		   						for(h=0; h<boardTypeList.length; h++){
									if(boardTypeList[h].codeId == boardList[i].boardType){	
				   						tBody.append(
			   								'<tr><td align="center">'+boardTypeList[h].codeName+'</td>'
			   								+'<td>'+boardList[i].boardNum+'</td>'
			   								+'<td><a href = /board/'+boardList[i].boardType+'/'
			   								+boardList[i].boardNum+'/boardView.do>'
			   								+boardList[i].boardTitle+'</a></td></tr>');
									}		   							
		   						}
		   					}
		    			},
		    			error: function(jqXHR, textStatus, errorThrown)
		    			{
		    				alert("error");
		    			}
		    	    });
 			});
}); 
</script>
<script>

/*
$j("#submit").on("click", function(){
	var tBody = $('#tBody');
	var totalCntTd = $('#totalCntTd');
	
    $j.ajax({
    	url : "/board/boardListHtml.do",
    	dataType: "html",
    	type: "GET",
		success: function(data, textStatus, jqXHR)
		{
			tBody.empty();//비워준다
			totalCntTd.empty();//비워준다
			
			console.log(data);
			tBody.html(data);
			
			//게시물 갯수
			totalCntTd.append("total : "+data.totalCntInt);
			
		},
		error: function(jqXHR, textStatus, errorThrown)
		{
			alert("error");
		}
    });
});


*/
    	    
</script>
<body>
<table  align="center">

		<tr>
			<td align="left">
				<c:if test="${userInfo == null}">			
					<a href="/board/login.do">login</a>
					<a href="/board/join.do">join</a>
				</c:if>
				<c:if test="${userInfo != null}">
					<p>유저이름 : ${userInfo.userName }</p>
				</c:if>
			</td>
			<td id="totalCntTd" align="right">
				total : ${totalCnt}
			</td>
		</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
					<tBody id="tBody">
						<c:forEach items="${boardList}" var="list">
							<tr id="trBody">
								<td align="center">
									<c:forEach items="${boardTypeList }" var="typeList">
										<c:if test="${list.boardType eq typeList.codeId}">
											${typeList.codeName }
										</c:if>
									</c:forEach>
								</td>
								<td>
									${list.boardNum}
								</td>
								<td>
									<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
								</td>
							</tr>
						</c:forEach>
					</tBody>
			</table>
		</td>
	</tr>
	
	<tr>
		<td align="left">
			<form class="boardCheck">
				<input type="hidden" name="boardType" class="ch" value="">
				<input id="check-all" type="checkbox" class="ch" >전체
				<c:forEach items="${boardTypeList}" var="list">
					<input type="checkbox" name="boardType" class="ch" value="${list.codeId}" >${list.codeName }
				</c:forEach>
				<input type="button" id="submit" value="조회">
			</form>
		</td>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
			<a href ="/board/chat.do">채팅하기</a>
			<c:if test="${userInfo != null }">
				<a href ="/board/logOut.do">로그아웃</a>
			</c:if>
		</td>
	</tr>
	
</table>	
	
</body>
</html>






