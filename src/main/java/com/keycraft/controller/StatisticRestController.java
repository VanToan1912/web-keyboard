package com.keycraft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.keycraft.dto.CategoryRevenueDTO;
import com.keycraft.service.OrderService;

@RestController
@RequestMapping("/api/statistics")
public class StatisticRestController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/category-revenue")
    public List<CategoryRevenueDTO> getPieChartData(@RequestParam int month, @RequestParam int year) {
        return orderService.getCategoryRevenue(month, year);
    }
}
