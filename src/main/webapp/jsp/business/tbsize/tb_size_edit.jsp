<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/jsp/commons/taglib.jsp"%>


<%@ include file="/jsp/commons/edit.jspf"%>

 <%
String rootFile = request.getScheme()+"://"+request.getServerName()+":8088/file";
String rootFileApp = request.getScheme()+"://"+request.getServerName()+":8088/app"; 

%>


<div class="container">
<div class="modal-dialog"  tabindex="-1" role="dialog" style="width:80%">
   <div class="modal-content">
      <div class="modal-header">
         <button type="button" class="close"
            data-dismiss="modal" aria-hidden="true">
               &times;
         </button>
         <h4 class="modal-title" id="myModalLabel">
                                             编辑尺寸表
         </h4>
      </div>
      <div class="modal-body">
             <form class="form-horizontal" action="${ctx}/tbsize/tbSizeController/edit.do" role="form" name="Form" id="editForm" method="post">
           	 <input type="hidden" name="F_SIZE_UID" id="F_SIZE_UID" value="${pd.F_SIZE_UID}"/>
		  
		     
		
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品表UID:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_PRODUCT_ID"  name="F_PRODUCT_ID"  value="${pd.F_PRODUCT_ID}"  placeholder="请填写商品表UID" title="商品表UID">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">尺寸名:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_SIZE_LABEL"  name="F_SIZE_LABEL"  value="${pd.F_SIZE_LABEL}"  placeholder="请填写尺寸名" title="尺寸名">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">序号:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_XUHAO"  name="F_XUHAO"  value="${pd.F_XUHAO}"  placeholder="请填写序号" title="序号">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">状态:</label>
						          <div class="col-sm-10">  
						              <input type="text" class="form-control" id="F_STATUS"  name="F_STATUS"  value="${pd.F_STATUS}"  placeholder="请填写状态" title="状态">
						          </div>  
						       </div>
						 
	       
 
			
	   
	    <div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1">
				           图片上传&nbsp;
				</label> 
			 
				<div class="col-sm-9">
				     <div id="wrapper">
							<div id="container"> 
								<div id="uploader">
									<div class="queueList">
										<div id="dndArea" class="placeholder">
											<div id="filePicker"></div>
											<p>或将照片拖到这里，单次最多可选300张</p>
										</div>
									</div>
									<div class="statusBar" style="display: none;">
										<div class="progress">
											<span class="text">0%</span> <span class="percentage"></span>
										</div>
										<div class="info"></div>
										<div class="btns">
											<div id="filePicker2"></div>
											<div class="uploadBtn">开始上传</div>
										</div>
									</div>
								</div>
							</div> 
						</div>
				 </div>
		 </div>
		  
		   <div class="form-group">
		      <label class="col-sm-2 control-label">图片:</label>
		       <div class="col-sm-9"  id="pictures"> 
		      </div>
		    </div> 
		    
    </form>
     
      </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button> 
         <button type="button" class="btn btn-primary" onclick="update()">
                                            保存
         </button>
      </div>
      
      
   </div><!-- /.modal-content -->
</div><!-- /.modal -->
 
 
 </div>
 
 
 <script type="text/javascript">
 
 $(function(){ 
	 init();
	 
	  $(".CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
     });
	 
	 
 });
 
 function init(){ 
		var data1={F_SIZE_UID:'${pd.F_SIZE_UID}'};
		$.ajax({
			url : "${ctx}/tbsize/tbSizeController/goEdit.do",
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
			     $("#F_SIZE_UID").val(obj.F_SIZE_UID); 
			     $("#F_PRODUCT_ID").val(obj.F_PRODUCT_ID); 
			     $("#F_SIZE_LABEL").val(obj.F_SIZE_LABEL); 
			     $("#F_XUHAO").val(obj.F_XUHAO); 
			     $("#F_STATUS").val(obj.F_STATUS); 
						 
		
		getPicFile("TB_SIZE",obj.F_SIZE_UID);
    }
	
	function getPicFile(table,table_uid_value){
		$.ajax({
			url : "${ctx}/tbPicturesController/getPicture.do?TABLE="+table+"&TABLE_UID_VALUE="+table_uid_value,
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
			url : "${ctx}/tbPicturesController/delete.do?PICTURES_ID="+PICTURES_ID,
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
		 
		$.ajax({
			url : "${ctx}/tbsize/tbSizeController/edit.do",
			data : $("#editForm").serialize(),
			cache : false,
			async :	false,
			dataType : "json",  
			type : 'post',
			success : function(response) {
				 console.info(typeof response);
				 if(!response.iserror){
					alert("上传成功");
					$("#editClose").click();
					$("#INDEX_Form").submit();
				} 
			}
		});  
		 
	}
	 
 
 </script>
