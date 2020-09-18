<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>chat</title>
</head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$j(document).ready(function(){
	
   	    $j("#chatClear").on("click", function(){
   	    	$j("#tBody").empty();
   	    });
    	    
    	   $j("#chatSubmit").on("click", function(){
    		   var $frm = $j(".chatFrm ");
    		   var param = $frm.serialize();
    		   console.log(param);
    		   $j.ajax({
    			  url : "/board/chatAction.do",
    			  dataType: "json",
    			  type: "POST",
    			  data: param,
    			  success: function(data, textStatus, jqXHR)
	    		  {
    				  $j("#tBody").append("<p id='chatText'>"+data.userId+":"+data.chat+"</p>");
    			  },
    			  error: function(jqXHR, textStatus, errorThrown)
    			  {
    					alert("error+"+errorThrown);
    			  }
    		   });
    	   });
    	   
    	   var submit = document.querySelector("#submit");
    	   var reset = document.querySelector("#reset");
    	   var userNumInput = document.querySelector("#userNumIn");
    	   var randomNum = Math.floor(Math.random()*100)+1;
    	   var tNumBody = document.querySelector("#tNumBody");
    	   var tNumBody2 = document.querySelector("#tNumBody2");
   		   var submitCount = 0;
    	   
    	   function checkNum(){
    		   var userNumIn = Number(userNumInput.value);
    		   
    		   tNumBody.append(userNumIn+" ");
    		   
    		   submitCount += 1;
    		   
    		   if(userNumIn == randomNum){
    			   $j("#tNumBody2").empty();
    		       tNumBody2.append("correct");
    		       setGameOver();
    		   }
    		   
    		   else if(userNumIn > randomNum){
    			   $j("#tNumBody2").empty();
    			   tNumBody2.append("number is too big");
    		   }
    		   
    		   else if(userNumIn < randomNum){
    			   $j("#tNumBody2").empty();
    			   tNumBody2.append("number is too low");
    		   }
    		   
    		   if(submitCount == 10 && userNumIn != randomNum){
    			   $j("#tNumBody2").empty();
    			   tNumBody2.append("game over");
    			   setGameOver();
    		   }
    	   }
    	   
    	   submit.addEventListener('click', checkNum);
    	   reset.addEventListener('click', resetGame);
    	   
    	   function setGameOver(){
    		   submit.disabled = true;
    		   userNumIn.disabled = true;
    	   }
    	   
    	   function resetGame(){
    		   $j("#tNumBody2").empty();
    		   $j("#tNumBody").empty();
    		   submitCount = 0;
    		   submit.disabled = false;
    		   userNumIn.disabled = false;
    		   randomNum = Math.floor(Math.random()*100)+1;
    	   }
    	   
});


</script>
<body>
<table  align="center">
		<a href ="/board/boardList.do">메인</a>
		<p>접속 아이디 : ${userInfo.userId }</p>
		<tbody id="tBody">
			
		</tbody>
	<tr id="trBody">
		<td>
			<form>
				<input type="text" class="chatFrm" id="chat" name="chat">
				<input class="chatFrm" type="hidden" id="userId" name="userId" value="${userInfo.userId }">
				<input id="chatSubmit" type="button" value="전송">
				<input id="chatClear" type="button" value="채팅창 비우기">
			</form>
		</td>
	</tr>
	
	
</table>	
<table align="center">
	<p>랜덤 숫자 맞추기</p>
	<tbody id="tNumBody">
	</tbody>
	<tbody id="tNumBody2">
	</tbody>
	<tr>
		<td id="numTd">
			<input id="userNumIn"/>
			<input type="button" id="submit" value="submit"/>
			<input type="button" id="reset" value="reset"/>
		</td>
	</tr>
</table>
</body>
</html>