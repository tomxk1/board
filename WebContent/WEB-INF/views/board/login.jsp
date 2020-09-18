<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
</head>
<script>

$j(document).ready(function(){
	function byteCheck(el){
	    var codeByte = 0;
	    for (var idx = 0; idx < el.val().length; idx++) {
	        var oneChar = escape(el.val().charAt(idx));
	        if ( oneChar.length == 1 ) {
	            codeByte ++;
	        } else if (oneChar.indexOf("%u") != -1) {
	            codeByte += 2;
	        } else if (oneChar.indexOf("%") != -1) {
	            codeByte ++;
	        }
	    }
	    return codeByte;
	}
	
	function cutByLen(str, maxByte) {
		for(b=i=0;c=str.charCodeAt(i);) {
			b+=c>>7?2:1;
		if (b > maxByte)
			break;
			i++;
		}
		return str.substring(0,i);
		}
	
		$j("#userId").keyup(function(){
			var userId = $j("#userId").val();
			var noKoreanExp = /^[a-zA-Z0-9]+$/;
			if(!noKoreanExp.test(userId) && userId != ""){
				alert("no korean");
				$j("#userId").val($j("#userId").val().replace(/[^A-Za-z0-9_\`\~\!\@\#\$\%\^\&\*\(\)\-\=\+\\\{\}\[\]\'\"\;\:\<\,\>\.\?\/\s]/gm, ""));
			}
			
		});
		
		$j("#submit").on("click",function(){
			
			var pwExp = $j("#userPw").val();
			
		  if($j("#userId").val() == ""){
	    	  alert("not id");
	    	  $j("#userId").focus();
	    	  return false;
	     	 }
	      if($j("#userPw").val() == ""){
	    	  alert("not pw");
	    	  $j("#userPw").focus();
	    	  return false;
	    	  }
	   	  if($j("#userPw").val().length < 6 || $j("#userPw").val().length > 12 ){
	    	  alert("pw 6 ~ 12");
	    	  $j("#userPw").focus();
	    	  return false;
	   	 	 }
	   	 
	      
	      else{
				var $frm = $j('.userLogin :input');
				var param = $frm.serialize();
				console.log(param);
				
				$j.ajax({
				    url : "/board/loginAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
				    	if(data.success == undefined){
							
							if(data.id == "id fail"){
								alert("not exist id");								
								$j("#userId").val("");
								$j("#userPw").val("");
								$j("#userId").focus();
							}
							else{
								alert("wrong password")
								$j("#userPw").val("");
								$j("#userPw").focus();
							}
				    	}
				    	else{
							alert("success");
							location.href = "/board/boardList.do";
				    	}
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("error");
				    }
				});
	    	  return true;
	      }
	  });
 });
</script>
<body>
<table  align="center">
	<tr>
		<td align="left">
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
	<tr>
		<td>
			<form class="userLogin">
				<table id="boardTable" border = "1">
					<tr>
						<td width="120" align="center">
							Id
						</td>
						<td width="200" align="left">
							<input maxlength="15" id="userId" class="userLogin" name="userId">
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
							pw
						</td>
						<td width="200" align="left">
							<input maxlength="12" type="password" id="userPw" class="userLogin" name="userPw">
						</td>
					</tr>
				</table>
				<a  id="submit">login</a>
			</form>
		</td>
	</tr>
	
</table>	
</body>
</html>