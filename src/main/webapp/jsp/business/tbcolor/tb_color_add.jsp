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
                                           添加颜色表
         </h4>
      </div>
      <div class="modal-body">
           <form class="form-horizontal" action="${ctx}/tbcolor/tbColorController/edit.do" role="form" name="Form" id="addForm" method="post">
           	 <input type="hidden" name="F_COLOR_UID" id="F_COLOR_UID" value="${pd.F_COLOR_UID}"/>
		  
		 
					       <div class="form-group">
						          <label class="col-sm-2 control-label">商品表UID:</label>
						          <div class="col-sm-10">  
						             <input type="text" class="form-control" id="F_PRODUCT_ID"  name="F_PRODUCT_ID"  value="${pd.F_PRODUCT_ID}"  placeholder="请填写商品表UID" title="商品表UID">
						          </div>  
						       </div>
					       <div class="form-group">
						          <label class="col-sm-2 control-label">颜色名:</label>
						          <div class="col-sm-10">  
						             <input type="text" class="form-control" id="F_COLOR_LABEL"  name="F_COLOR_LABEL"  value="${pd.F_COLOR_LABEL}"  placeholder="请填写颜色名" title="颜色名">
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
				<!--  <div class="col-sm-9">
					<span style="margin:4px auto;" class="btn  btn-white btn-default btn-round " onclick="selectFile(this);" file_type="10901" >
						<i class="ace-icon fa fa-cloud-upload bigger-100"></i>
							附件上传
					</span>
						<form class="form-inline"  id="queryForm1" width="100%"
					   role="form" style="border:solid 1px #ddd;height:50px;line-height:50px;vertical-align:middle;"></form>
					<table  role="presentation" class="table table-striped">
						<tbody showType="width:120px;height:120px;quanxian:true;heightss:160px;heights:40px;del:true;attr:multi;preview:false" class="files showFileTab" data-toggle="modal-gallery" data-target="#modal-gallery"  file_type="10901"></tbody>
					</table>
				</div>-->
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
		 
	   
    </form>
    
      <div class="row">
		      <label class="col-sm-2 control-label">图片:</label>
		       <div class="col-sm-9"  id="pictures">
		          
		      </div>
		 </div> 
      </div>
      
      <!-- --------------------------footer----------------------------------- -->
      
      <div class="modal-footer">
         <button type="button" class="btn btn-default" id="editClose"
            data-dismiss="modal">关闭
         </button>
         <button type="button" class="btn btn-primary" onclick="save()">
            提交更改
         </button>
      </div>
      
      
   </div><!-- /.modal-content -->
</div><!-- /.modal -->
 
 
 </div>
 
 
 <script type="text/javascript">
	 var form;
	 $(function(){ 
		 form = FormValid.validbyFormId("#addForm"); 
	 });
  
	  $("#CREATE_DATE").datepicker({
	        format: 'yyyy-mm-dd',
		    language: "zh-CN",
		    autoclose: true
     });
     
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
	
	//保存
	function save(){
		  
		if(form.check()){
			$.ajax({
				url : "${ctx}/tbcolor/tbColorController/save.do",
				data : $("#addForm").serialize(),
				cache : false,
				async :	false,
				dataType : "json",  
				type : 'post',
				success : function(response) {
					 console.info(typeof response);
					 if(!response.iserror){
						xAlert("信息提示","上传成功",1);
						$("#editClose").click();
						$("#INDEX_Form").submit();
					} 
				}
			});  
		} 
	}
	 
 
 </script>
