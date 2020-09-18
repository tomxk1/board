<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>join</title>
</head>
<script>
$j(document).ready(function(){
	function byteCheck(el){
	    var codeByte = 0;
	    for (var i = 0; i < el.val().length; i++) {
	        var oneChar = escape(el.val().charAt(i));
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
	
	$j("#adress").keydown(function(){
		var adress = $j("#adress");
		if(Number(byteCheck(adress)) > 149){
			alert("adress max 150bytes");
			adress.val(cutByLen(String(adress.val()), 149));
		}
	});
	
	$j("#company").keydown(function(){
		var company = $j("#company");
		if(Number(byteCheck(company)) > 59){
			alert("company max 60bytes");
			company.val(cutByLen(String(company.val()), 59));
		}
	});
	
	$j("#submit").on("click", function(){
		if($j("#userId").val() == ""){
			alert("no text id");
			$j("#userId").focus();
		}
		else if($j("#userId").val() != ""){
			alert("checkId first");
		}
	});
	
	$j("#userId").keyup(function(){
		var userId = $j("#userId").val();
		var noKoreanExp = /^[a-zA-Z0-9]+$/;
		var userId2 = $j("#userId");
		if(!noKoreanExp.test(userId) && userId != ""){
			alert("no korean");
			$j("#userId").val($j("#userId").val().replace(/[^A-Za-z0-9_\`\~\!\@\#\$\%\^\&\*\(\)\-\=\+\\\{\}\[\]\'\"\;\:\<\,\>\.\?\/\s]/gm, ""));
		}
		else if(Number(byteCheck(userId2)) > 15){
			alert("userId max 15bytes");
			userId2.val(cutByLen(String(userId2.val()), 15));
		}
	});
	
	$j("#userName").keyup(function(){
		var userName = $j("#userName");
		var koreanExp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
		if(koreanExp.test($j("#userName").val()) && $j("#userName").val() != ""){
			alert("only korean");
			$j("#userName").val($j("#userName").val().replace(/[A-Za-z0-9_\`\~\!\@\#\$\%\^\&\*\(\)\-\=\+\\\{\}\[\]\'\"\;\:\<\,\>\.\?\/\s]/gm, ""));
		}
		else if(Number(byteCheck(userName)) > 11){
			alert("userName max 15bytes");
			userName.val(cutByLen(String(userName.val()), 11));
		}
	});
	
	$j("#pwCheck").keyup(function(){ // 비밀번호와 비밀번호 확인 입력후 비교 출력
		var pw1 = $j("#userPw").val();
		var pw2 = $j("#pwCheck").val();
		
			if(pw1 != "" && pw2 != ""){
				
				if(pw1 == pw2){
					$j("#pwCheckMsg").html("ok");
				}
				
				else if(pw1 != pw2){
					$j("#pwCheckMsg").html("not ok");
				}
			}
			else{
				$j("#pwCheckMsg").html("");
			}
	});
	$j("#userPw").keyup(function(){
		var pw1 = $j("#userPw").val();
		var pw2 = $j("#pwCheck").val();
		
			if(pw1 != "" || pw2 != ""){
				
				if(pw1 == pw2){
					$j("#pwCheckMsg").html("ok");
				}
				
				else if(pw1 != pw2){
					$j("#pwCheckMsg").html("not ok");
				}
				
			}
			
	});
	
	$j("#postNo").keyup(function(){//주소1 3자리이상일때 - 추가
		var no = /^[0-9.;\-]{0,7}$/;
		///^[0-9]{3}-[0-9]{3}$/
		if(!no.test($j("#postNo").val()) && $j("#postNo").val() != ""){
			alert("XXX-XXX, only no");
			$j("#postNo").val($j("#postNo").val().replace(/[^0-9|-]/gm, ""));
		}	
		if($j("#postNo").val().length == 6){
			$j("#postNo").val(String($j("#postNo").val()).slice(0,3)+"-"+String($j("#postNo").val()).slice(3,6));
		}
		
	});
	
	$j("#phoneNo2").keyup(function(){//전화번호 숫자 4개 입력시 다음으로 넘어감
		var no = /^[0-9]+$/;
		if(!no.test($j("#phoneNo2").val()) && $j("#phoneNo2").val() != ""){
			alert("only no");
			$j("#phoneNo2").val($j("#phoneNo2").val().replace(/[^0-9]/gm, ""));
		}	
		else if($j("#phoneNo2").val().length >= 4){
			$j("#phoneNo2").next().focus();
		}
	});
	
	$j("#phoneNo3").keyup(function(){//전화번호 숫자 4개 입력시 다음으로 넘어감
		var no = /^[0-9]+$/;
		if(!no.test($j("#phoneNo3").val()) && $j("#phoneNo3").val() != ""){
			alert("only no");
			$j("#phoneNo3").val($j("#phoneNo3").val().replace(/[^0-9]/gm, ""));
		}
		else if($j("#phoneNo3").val().length >= 4){
			$j("#postNo").focus();
		}
	});
	
		$j("#checkId").on("click", function(){
			var $frm = $j('#userId');
			var param = $frm.serialize();
			console.log(param);
			
			$j.ajax({
				url : "/board/idAction.do",
				dataType: "json",
				type: "POST",
				data : param,
				
				success : function(data, textStatus, jqXHR)
				{	

					
					if(data == 0 && $j("#userId").val() != ""){
					alert("u can use");
					$j("#userId").attr("readonly", true);
					$j("#userPw").focus();
					$j("#submit").unbind('click');
					$j("#submit").on("click",function(){
						var pwExp = $j("#userPw").val();
						var postNoExp = /^\d{3}-\d{3}$/;
						
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
				      if($j("#userPw").val() != $j("#pwCheck").val()){
				    	  alert("check pw");
				    	  $j("#pwCheck").focus();
				    	  return false;
				      }
				      if(pwExp.length > 12 || pwExp.length < 6){
				    	  alert("pw 6 ~ 12");
				    	  $j("#userPw").focus();
				    	  return false;
				      }
				      if($j("#userName").val() == ""){
				    	  alert("no name");
				    	  $j("#userName").focus();
				    	  return false;
				      }
				      if($j("#phoneNo2").val() == "" ){
				    	  alert("no phoneNo2");
				    	  $j("#phoneNo2").focus();
				    	  return false;
				      }
				      if($j("#phoneNo3").val() == ""){
				    	  alert("no phoneNo3");
				    	  $j("#phoneNo3").focus();
				    	  return false;
				      }
				      if($j("#phoneNo2").val().length != 4){
				    	  alert("phone 010-XXXX-XXXX");
				    	  $j("#phoneNo2").focus();
				    	  return false;
				      }
				      if($j("#phoneNo3").val().length != 4){
				    	  alert("phone 010-XXXX-XXXX");
				    	  $j("#phoneNo3").focus();
				    	  return false;
				      }
				      if(!postNoExp.test($j("#postNo").val()) && $j("#postNo").val() != ""){
				    	  alert("postNo XXX-XXX");
				    	  $j("#postNo").focus();
				    	  return false;
				      }
				      
				      else{
							var $frm = $j('.userJoin :input');
							var param = $frm.serialize();
							console.log(param);
							
							$j.ajax({
							    url : "/board/joinAction.do",
							    dataType: "json",
							    type: "POST",
							    data : param,
							    success: function(data, textStatus, jqXHR)
							    {
									alert("success");
									
									alert("message:"+data.success);
									
									location.href = "/board/boardList.do";
							    },
							    error: function (jqXHR, textStatus, errorThrown)
							    {
							    	alert("fail");
							    }
							});
				    	  return true;
				      }
				  });
					//중복검사후 끝
				}//if끝
				else{
					if($j("#userId").val() == ""){
						alert("write id");
						$j("#userId").focus();
					}
					else{
						alert("u can't use")
						
					}
				}
				},
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("fail");
			    }
			
			});
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
			<form class="userJoin">
				<table id="boardTable" border = "1">
					<tr>
						<td width="120" align="center">
							Id
						</td>
						<td width="300" align="left">
							<input id="userId" maxlength="15" class="userJoin" name="userId">
							<input type="button" id="checkId" onclick="checkId()" value="idCheck">
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
							pw
						</td>
						<td class="pwCheckMsg" width="300" align="left">
							<input type="password" maxlength="12" class="userJoin" id="userPw" name="userPw">
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
							pw check
						</td>
						<td class="pwCheckMsg" width="300" align="left">
							<input type="password" maxlength="12" id="pwCheck" name=""><div id="pwCheckMsg"></div>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
							name
						</td>
						<td width="300" align="left">
							<input id="userName" class="userJoin"  name="userName">
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
							phone
						</td>
						<td width="300" align="left">
							<select name="userPhone1">
								<c:forEach items="${phoneNoList}" var="list">
									<option id="phoneNo1" class="userJoin"   value="${list.codeName }">${list.codeName }
								</c:forEach>
							</select>
							 - <input id="phoneNo2" class="userJoin" name="userPhone2" maxlength="4" style="width:40px;">
							 - <input id="phoneNo3" class="userJoin" name="userPhone3" maxlength="4" style="width:40px;">
						</td>
						
					</tr>
					<tr>
						<td width="120" align="center">
							postNo
						</td>
						<td width="300" align="left">
							<div id="postNo-">
								<input id="postNo" maxlength="6" class="userJoin" name="userAddr1">
							</div>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
							address
						</td>
						<td width="300" align="left">
							<input maxlength="150" id="adress" class="userJoin" name="userAddr2">
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
							company
						</td>
						<td width="300" align="left">
							<input maxlength="60" id="company" class="userJoin" name="userCompany">
						</td>
					</tr>
				</table>
				<input type="button" id="submit" value="join">
			</form>
		</td>
	</tr>
	<tr>
		<td align="right">
			
				<input type="hidden" name="boardType" class="ch" value="">
					
				
		</td>
	</tr>
</table>	
</body>
</html>