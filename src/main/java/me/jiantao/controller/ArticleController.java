package me.jiantao.controller;

import javax.annotation.Resource;
import me.jiantao.common.PageResult;
import me.jiantao.po.Article;
import me.jiantao.service.IArticleService;
import me.jiantao.util.ServletUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ArticleController {
	
	@Resource
	private IArticleService iArticleService;
	
	@RequestMapping("/article")
	public ModelAndView articleList(){
		ModelAndView mv = new ModelAndView("article/article-list");
		PageResult<Article> pr = new PageResult<Article>();
		pr.setPageSize(99999);
		pr.setSort(PageResult.SORT_DESC);
		iArticleService.getArticleByPage(null, pr);
		mv.addObject("pr", pr);
		return mv;
	}
	@RequestMapping("/article/{id}.html")
	public ModelAndView articleDetail(@PathVariable(value="id") int id){
		ModelAndView mv = new ModelAndView("article/article-detail");
		Article article = iArticleService.getArticleByIdAndAddVisitCount(id);
		if(article != null){
			mv.addObject("article", article);
		}else{
			ServletUtil.forward404(mv);
		}
		return mv;
	}
}
