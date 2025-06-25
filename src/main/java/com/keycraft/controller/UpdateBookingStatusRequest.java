package com.keycraft.controller;

public class UpdateBookingStatusRequest {
    private String status;
    private String trackingCode; // Thêm trường này

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Thêm getter/setter cho trackingCode
    public String getTrackingCode() {
        return trackingCode;
    }

    public void setTrackingCode(String trackingCode) {
        this.trackingCode = trackingCode;
    }
}