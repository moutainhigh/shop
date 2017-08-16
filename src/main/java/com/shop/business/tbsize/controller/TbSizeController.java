package com.shop.business.tbsize.controller; 
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lanbao.controller.BaseController;
import com.lanbao.base.Page;
import com.lanbao.utils.AppUtil;
import com.lanbao.utils.ObjectExcelView;
import com.lanbao.utils.Const;
import com.lanbao.base.PageData;
import com.lanbao.utils.Tools;

import com.lanbao.base.ResultAction;
import com.shop.business.pictures.service.PicturesService;
import com.shop.business.standard.service.StandardService;
import com.shop.business.tbsize.service.TbSizeService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject; 

/** 
 *  TbSizeController
 * 
 */
@Controller
@RequestMapping(value="/tbsize/tbSizeController")
public class TbSizeController extends BaseController {
	
	String menuUrl = "tbsize/tbSizeController/list.do";  
	
	@Resource(name="tbSizeService")
	private TbSizeService tbSizeService;
	
	@Resource(name="picturesService")
	private PicturesService picturesService;
	 
	 
	/**
	 * save
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public ResultAction save() throws Exception{
		logBefore(logger, "TbSizeController");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();     
		int F_SIZE_UID = tbSizeService.save(pd);
		
		HttpServletRequest request = this.getRequest();
		String[] PICTURES_IDs = request.getParameterValues("PICTURES_ID");
		if(!"".equals(PICTURES_IDs)){
			for(int i=0;i<PICTURES_IDs.length;i++){
				//存图片
				pd.put("PICTURES_ID", PICTURES_IDs[i]);
				PageData picture = picturesService.findById(pd); 
				picture.put("TABLE_NAME", "TB_SIZE");			 
				picture.put("TABLE_UID_VALUE",F_SIZE_UID);						  
				picturesService.update(picture);
			} 
		}
		
	    com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	/**
	 * delete
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public ResultAction delete(){
		logBefore(logger, "TbSizeController");
		ResultAction ra = new ResultAction(); 
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			tbSizeService.delete(pd); 
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		ra.setIserror(false);
		return ra;
	}
	
	/**
	 * edit
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	public ResultAction edit(HttpServletRequest request) throws Exception{
	    ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData(); 
	    tbSizeService.edit(pd); 
	     String[] PICTURES_IDs = request.getParameterValues("PICTURES_ID");
		if(!"".equals(PICTURES_IDs)&&PICTURES_IDs!=null){
			for(int i=0;i<PICTURES_IDs.length;i++){
				//存图片
				pd.put("PICTURES_ID", PICTURES_IDs[i]);
				PageData picture = picturesService.findById(pd); 
				picture.put("TABLE_NAME", "TB_SIZE");			 
				picture.put("TABLE_UID_VALUE",pd.getString("F_SIZE_UID"));						  
				picturesService.update(picture);
			} 
		}
		
		com.lanbao.base.ResultAction ra = new com.lanbao.base.ResultAction();
		ra.setIserror(false);
		return ra;
	}
	
	 /**
	 * list
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "TbSizeController"); 
		ModelAndView mv = this.getModelAndView();
		try{
		 	mv.setViewName("business/tbsize/tb_size_index"); 
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
  
	/**
	 * dataList
	 */
	@RequestMapping(value="/dataList")
	@ResponseBody
	public Page dataList(){
		logBefore(logger, "TbSizeController");  
		Page page =  new Page(); 
		PageData pd = this.getPageData();
		List<PageData>	varList  = null;
		try{ 
			page.setPd(pd);  
			varList = tbSizeService.list(page);	 
			page.setData(varList);  
		} catch(Exception e){
			logger.error(e.toString(), e);
		} 
		return page;
	}
	
	/**
	 * goAdd
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){ 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("business/tbsize/tb_size_add");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * goEdit
	 */
	@RequestMapping(value="/goEdit")
	@ResponseBody
	public PageData goEdit(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = tbSizeService.findById(pd);	 
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return pd;
	}	
	
	@RequestMapping(value="/goEditView")
	public ModelAndView goEditView(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try { 
		    mv.setViewName("business/tbsize/tb_size_edit"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
    @RequestMapping(value="/goDetailView")
	public ModelAndView goDetailView(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try { 
		    mv.setViewName("business/tbsize/tb_size_detail"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	
	@RequestMapping(value="/goAddView")
	public ModelAndView goAddView(){ 
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {  
			mv.setViewName("business/tbsize/tb_size_add"); 
			mv.addObject("msg", "edit"); 
			mv.addObject("pd",pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	
	
	
	/**
	 * deleteAll
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() { 
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				tbSizeService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	} 
}
