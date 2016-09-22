package me.jiantao.controller;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import me.jiantao.common.PageResult;
import me.jiantao.po.Article;
import me.jiantao.search.IArticleSearchService;
import me.jiantao.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/search")
public class SearchController {
	
	@Resource
	private IArticleSearchService iArticleSearchService;

	
	@RequestMapping("/result")
	public ModelAndView articleList(@RequestParam(defaultValue = "") String keyword){
		ModelAndView mv = new ModelAndView("search/search-list");
		mv.addObject("keyword", keyword);
		return mv;
	}
	
	@RequestMapping("/searchArticle")
	@ResponseBody
	public Map<String,Object> searchArticle(String keyword, PageResult<Article> pr){
		long startTime = System.currentTimeMillis();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			iArticleSearchService.getArticleByPage(keyword, pr);
			map.put("status", 1);
			map.put("pr", pr);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("status", 0);
			map.put("msg", e.getMessage());
		}
		long ms = System.currentTimeMillis() - startTime;
		map.put("ms", ms); //查询用时
		map.put("keyword", StringUtil.escape(keyword)); //转义后的关键字
		return map;
	}
}
