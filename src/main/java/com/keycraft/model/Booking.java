package com.keycraft.model; // Thay đổi package cho phù hợp

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity // Đánh dấu đây là một Entity, sẽ được ánh xạ tới một bảng trong CSDL
@Table(name = "bookings") // Tùy chỉnh tên của bảng trong CSDL (tên là "bookings")
public class Booking {

    @Id // Đánh dấu đây là khóa chính (Primary Key)
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Tự động tăng giá trị ID
    private Long id;

    @Column(name = "customer_name", nullable = false, length = 100) // Cột "customer_name", không được null, dài tối đa 100 ký tự
    private String customerName;

    @Column(name = "customer_email", nullable = false, length = 100)
    private String customerEmail;

    @Column(name = "customer_phone", nullable = false, length = 20)
    private String customerPhone;

    @Column(name = "service_name", nullable = false) // Tên dịch vụ hoặc sản phẩm được đặt
    private String serviceName;

    @Column(name = "booking_date", nullable = false) // Ngày giờ đặt chỗ
    private LocalDateTime bookingDate;

    @Column(name = "quantity") // Số lượng người hoặc sản phẩm
    private int quantity = 1; // Giá trị mặc định là 1

    @Enumerated(EnumType.STRING) // Lưu trạng thái dưới dạng chuỗi (PENDING, CONFIRMED, ...) thay vì số (0, 1, ...)
    @Column(name = "status", nullable = false, length = 20)
    private BookingStatus status;

    @Column(name = "notes", columnDefinition = "TEXT") // Dùng kiểu TEXT cho ghi chú dài
    private String notes;

    @Column(name = "created_at", updatable = false) // Cột này không được cập nhật sau khi đã tạo
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    @Column(name = "tracking_code", length = 100)
    private String trackingCode;

    // === THÊM GETTER VÀ SETTER CHO NÓ ===
    public String getTrackingCode() {
        return trackingCode;
    }

    public void setTrackingCode(String trackingCode) {
        this.trackingCode = trackingCode;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public LocalDateTime getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(LocalDateTime bookingDate) {
        this.bookingDate = bookingDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BookingStatus getStatus() {
        return status;
    }

    public void setStatus(BookingStatus status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    // Thêm method này vào trong class Booking.java
    public java.util.Date getCreatedAtAsDate() {
        if (this.createdAt == null) {
            return null;
        }
        return java.sql.Timestamp.valueOf(this.createdAt);
    }
    public enum BookingStatus {
        PENDING, CONFIRMED, SHIPPED, DELIVERED, CANCELLED
    }
    // Bạn cũng có thể tạo các method tương tự cho các trường ngày tháng khác nếu cần
// public java.util.Date getUpdatedAtAsDate() { ... }
// public java.util.Date getBookingDateAsDate() { ... }
    // == Lifecycle Callbacks ==
    // Method này sẽ được gọi tự động TRƯỚC KHI entity được lưu lần đầu
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) {
            status = BookingStatus.PENDING; // Gán trạng thái mặc định là PENDING
        }
    }

    // Method này sẽ được gọi tự động TRƯỚC KHI entity được cập nhật
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}