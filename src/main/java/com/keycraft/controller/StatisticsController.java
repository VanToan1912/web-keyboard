package com.keycraft.controller;

import com.keycraft.dto.CategoryRevenueDTO;
import com.keycraft.dto.TimeRevenueDTO;
import com.keycraft.service.StatisticsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/statistics")
public class StatisticsController {

    @Autowired
    private StatisticsService statisticsService;

    /**
     * GET /api/statistics/revenue-by-period
     * @param format  (e.g. "%Y-%m-%d") — định dạng nhóm ngày/tháng/năm
     * @param month   tháng (1–12)
     * @param year    năm (ví dụ 2025)
     */
    // Doanh thu theo ngày/tháng/năm
    @GetMapping("/revenue-by-period")
    public ResponseEntity<?> revenueByPeriod(
            @RequestParam String format,
            @RequestParam(required = false) Integer month,
            @RequestParam(required = false) Integer year
    ) {
        int safeMonth = month == null ? 0 : month;
        int safeYear = year == null ? 0 : year;
        return ResponseEntity.ok(statisticsService.getRevenueByPeriod(format, safeMonth, safeYear));
    }

    // Doanh thu theo danh mục trong 1 tháng
    @GetMapping("/revenue-by-category")
    public List<Map<String, Object>> getRevenueByCategory(
            @RequestParam Integer month,
            @RequestParam Integer year
    ) {
        return statisticsService.getRevenueByCategory(month, year);
    }
}
