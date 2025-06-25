package com.keycraft.controller;

import com.keycraft.model.Booking;
import com.keycraft.repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/bookings")
public class BookingRestController {

    @Autowired
    private BookingRepository bookingRepository; // Sử dụng trực tiếp repository giống OrderRestController

    /**
     * API cập nhật trạng thái và mã vận đơn cho một Pre-Order.
     * Nhận trực tiếp một đối tượng Booking từ request body.
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateBooking(@PathVariable Long id, @RequestBody Booking bookingInput) {

        // 1. Tìm đơn booking gốc trong CSDL
        Optional<Booking> optionalBooking = bookingRepository.findById(id);
        if (optionalBooking.isEmpty()) {
            return ResponseEntity.notFound().build(); // Báo lỗi nếu không tìm thấy
        }

        Booking bookingToUpdate = optionalBooking.get();

        // 2. Chỉ cập nhật những trường được phép từ bookingInput
        if (bookingInput.getStatus() != null) {
            bookingToUpdate.setStatus(bookingInput.getStatus());

            // Logic xử lý mã vận đơn tương tự như Order
            switch (bookingInput.getStatus()) {
                case SHIPPED:
                case DELIVERED:
                    // Chỉ cập nhật tracking code nếu nó được cung cấp
                    if (bookingInput.getTrackingCode() != null) {
                        bookingToUpdate.setTrackingCode(bookingInput.getTrackingCode());
                    }
                    break;
                case PENDING:
                case CONFIRMED:
                case CANCELLED:
                    // Xóa tracking code khi ở các trạng thái này
                    bookingToUpdate.setTrackingCode(null);
                    break;
                default:
                    // Giữ nguyên với các trường hợp khác
                    break;
            }
        }

        // 3. Entity Booking của bạn đã có @PreUpdate nên không cần setUpdatedAt thủ công

        // 4. Lưu lại booking đã được cập nhật
        bookingRepository.save(bookingToUpdate);

        return ResponseEntity.ok().build();
    }

    /**
     * API để xóa một Pre-Order
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBooking(@PathVariable Long id) {
        if (!bookingRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        bookingRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
}