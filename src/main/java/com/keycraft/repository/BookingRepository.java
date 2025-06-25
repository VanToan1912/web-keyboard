package com.keycraft.repository; // Thay đổi package cho phù hợp

import com.keycraft.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    // Spring Data JPA sẽ tự động tạo các method CRUD cơ bản (save, findById, findAll, delete, ...)
    // Bạn có thể thêm các method truy vấn tùy chỉnh ở đây nếu cần.
    // Ví dụ: tìm các booking theo email của khách hàng
     List<Booking> findByCustomerEmail(String email);
}