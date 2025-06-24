package com.keycraft.service;

import com.keycraft.dto.TimeRevenueDTO;
import com.keycraft.dto.CategoryRevenueDTO;
import com.keycraft.repository.OrderRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class StatisticsService {

    @Autowired
    private OrderRepository orderRepository;

    public List<Map<String, Object>> getRevenueByPeriod(String format, int month, int year) {
        List<Object[]> result = orderRepository.getRevenueByPeriod(format, month, year);
        List<Map<String, Object>> data = new ArrayList<>();
        for (Object[] row : result) {
            Map<String, Object> entry = new HashMap<>();
            entry.put("timeLabel", row[0]);
            entry.put("revenue", row[1]);
            data.add(entry);
        }
        return data;
    }

    public List<Map<String, Object>> getRevenueByCategory(int month, int year) {
        List<Object[]> result = orderRepository.getRevenueByCategory(month, year);
        List<Map<String, Object>> data = new ArrayList<>();
        for (Object[] row : result) {
            Map<String, Object> entry = new HashMap<>();
            entry.put("categoryName", row[0]);
            entry.put("revenue", row[1]);
            data.add(entry);
        }
        return data;
    }
}
