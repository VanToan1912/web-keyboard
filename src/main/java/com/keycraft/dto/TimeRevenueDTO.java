package com.keycraft.dto;

import java.math.BigDecimal;

public class TimeRevenueDTO {
    private String period;
    private BigDecimal revenue;

    public TimeRevenueDTO() {}

    public TimeRevenueDTO(String period, BigDecimal revenue) {
        this.period = period;
        this.revenue = revenue;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue;
    }
}
