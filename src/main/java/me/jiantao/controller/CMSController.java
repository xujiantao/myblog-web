package me.jiantao.controller;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import me.jiantao.common.PageResult;
import me.jiantao.common.Result;
import me.jiantao.po.Article;
import me.jiantao.service.IArticleService;
import me.jiantao.util.ServletUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 博客后台
 * @author xujiantao
 *
 */
@Controller
@RequestMapping("/cms")
public class CMSController {
	
	@Resource
	private IArticleService iArticleService;
	
	@RequestMapping("/articleList")
	public ModelAndView articleList(@RequestParam(value="pageNo",defaultValue="1")int pageNo) {
		ModelAndView mv = new ModelAndView("cms/article-list");
		mv.addObject("pageNo", pageNo);
		return mv;
	}
	
	@RequestMapping("/getArticleList")
	@ResponseBody
	public Map<String,Object> getArticleList(Article article,PageResult<Article> pr){
		Map<String,Object> result = new HashMap<String,Object>();
		iArticleService.getArticleByPage(null, pr);
		result.put("rowCount", pr.getRowsCount());
		result.put("rows", pr.getList());
		result.put("pageCount", pr.getPageCount());
		result.put("pageNo", pr.getPageNo());
		return result;
	}
	
	@RequestMapping("/toUpdateArticle")
	public ModelAndView toUpdateArticle(int id){
		ModelAndView mv = new ModelAndView("cms/article-update");
		Article article = iArticleService.getArticleById(id);
		if(article != null){
			mv.addObject("article", article);
		}else{
			ServletUtil.forward404(mv);
		}
		return mv;
	}
	
	@RequestMapping("/updateArticle")
	@ResponseBody
	public Result updateArticle(Article article){
		try {
			iArticleService.updateArticle(article);
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}
	
	@RequestMapping("/setTop")
	@ResponseBody
	public Result setTop(int id, boolean isExecuteOrCancel){
		try {
			if(isExecuteOrCancel){
				iArticleService.executeSetTop(id);
			}else{
				iArticleService.cancelSetTop(id);
			}
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}
	
	@RequestMapping("/recommend")
	@ResponseBody
	public Result recommend(int id, boolean isExecuteOrCancel){
		try {
			if(isExecuteOrCancel){
				iArticleService.executeRecommend(id);
			}else{
				iArticleService.executeRecommend(id);
			}
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}
	
	@RequestMapping("/toAddArticle")
	public ModelAndView toAddArticle(){
		ModelAndView mv = new ModelAndView("cms/article-add");
		return mv;
	}
	
	@RequestMapping("/addArticle")
	@ResponseBody
	public Result addArticle(Article article){
		try {
			iArticleService.saveArticle(article);
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}
	
	@RequestMapping("/deleteArticle")
	@ResponseBody
	public Result deleteArticle(int id){
		try {
			iArticleService.deleteArticle(id);
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}
	
	@RequestMapping("/addAllArticleIndex")
	@ResponseBody
	public Result addAllArticleIndex(){
		try {
			iArticleService.addAllArticleIndex();
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}
	
	@RequestMapping("/deleteAllArticleIndex")
	@ResponseBody
	public Result deleteAllArticleIndex(){
		try {
			iArticleService.deleteAllArticleIndex();
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.fail(e.getMessage());
		}
	}
	
}
