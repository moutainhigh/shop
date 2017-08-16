var form; 
$(function(){ 
	 form = FormValid.validbyFormId("#editForm"); 
	 init(); 
	  $(".CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
     });
 });
 
 function init(){ 
		var data1={F_USER_ID:$("#F_USER_ID").val()};
		$.ajax({
			url : ctx+"/tbuser/tbUserController/goEdit.do",
			data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response);
				//var resultobj = defaultJson.dealResultJson(response.msg);
				var product = response;
				setValue(product);
			}
		});  
	}
   
	
	function setValue(obj){  
		
			     $("#F_USER_ID").val(obj.F_USER_ID); 
			     $("#F_UserName").val(obj.F_UserName); 
			     $("#F_Sex").val(obj.F_Sex); 
			     $("#F_Email").val(obj.F_Email); 
			     $("#F_Mobile").val(obj.F_Mobile); 
			     $("#F_Password").val(obj.F_Password); 
			     $("#F_RealPassword").val(obj.F_RealPassword); 
			     $("#F_visits").val(obj.F_visits);
    }
	
	function getPicFile(table,table_uid_value){
		$.ajax({
			url : ctx+"/tbPicturesController/getPicture.do?TABLE="+table+"&TABLE_UID_VALUE="+table_uid_value,
			//data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				console.info(response);
				//var resultobj = defaultJson.dealResultJson(response.msg);
				$("#pictures").empty();
				response.forEach(function(ele,index){
					$("#pictures")
					.append($('<div class="col-sm-4" id="'+ele.PICTURES_ID+'"><img src="<%=rootFile%>/'+ele.PATH+'"  width="100%" height="180px"><p><button class="btn btn-default"  onclick="deletePic(\''+ele.PICTURES_ID+'\',\''+table+'\',\''+table_uid_value+'\')">x</button></p></div>')); 
					$("#editForm").append($('<input type="hidden" name="PICTURES_ID" id="'+ele.PICTURES_ID+'_input"  value="'+ele.PICTURES_ID+'"/>'));
				});
				
			}
		});  
	}
	
	function deletePic(PICTURES_ID,table,table_uid_value){
		
		$.ajax({
			url : ctx+"/tbPicturesController/delete.do?PICTURES_ID="+PICTURES_ID,
			//data : data1,
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				if(!response.iserror){
					if(table_uid_value!=''&&table_uid_value!='undefined'){
						//getPicFile(table,table_uid_value);
					}else{
						
					} 
					var pic = "#"+PICTURES_ID; 
					$(pic).remove(); 
					//<input type="hidden" name="PICTURES_ID" id="PICTURES_ID" />
					var p_input = "#"+PICTURES_ID+"_input";
					console.info($(p_input));
					//$("#editForm").remove($(p_input));
					$(p_input).remove();
					
				} 
				
			}
		});  
	}
	
	//update
	function update(){ 
		form = FormValid.validbyFormId("#editForm");  
		if(form.check()&&!$("input").hasClass("Validform_error")){
			$.ajax({
				url : ctx+"/tbuser/tbUserController/edit.do",
				data : $("#editForm").serialize(),
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) {
					 console.info(typeof response);
					 if(!response.iserror){ 
						$("#editClose").click();
						reload();
					} 
				}
			});  
		}
	}