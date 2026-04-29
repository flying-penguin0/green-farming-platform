package com.farmer.controller;

import com.farmer.config.PaginationUtils;
import com.farmer.service.TradeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;

@Controller
@RequestMapping("/admin/comments")
public class CommentController {

    @Resource
    private TradeService tradeService;

    @GetMapping
    public String index(String status, String keyword, Integer pageNum, Model model) {
        model.addAttribute("pageResult", PaginationUtils.paginate(tradeService.getAdminComments(status, keyword), pageNum, 8));
        model.addAttribute("status", status);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "comments");
        return "admin/comment-list";
    }

    @GetMapping("/status/{id}")
    public String updateStatus(@PathVariable("id") Long id, String status, RedirectAttributes redirectAttributes) {
        tradeService.updateCommentStatus(id, status);
        redirectAttributes.addFlashAttribute("successMsg", "评价状态更新成功");
        return "redirect:/admin/comments";
    }
}
