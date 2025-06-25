package com.keycraft.service;

import com.keycraft.model.Booking;
import com.keycraft.repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List; // Thêm import này
import java.util.Optional;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    public Booking savePreOrder(Booking booking) {
        if (booking.getBookingDate() == null) {
            booking.setBookingDate(LocalDateTime.now());
        }
        return bookingRepository.save(booking);
    }

    public Optional<Booking> findBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    // === THÊM METHOD NÀY VÀO ===
    /**
     * Lấy tất cả các đơn booking từ CSDL.
     * @return một danh sách các Booking.
     */
    public List<Booking> findAll() {
        // Gọi đến method findAll() đã có sẵn của JpaRepository
        return bookingRepository.findAll();
    }
    public void confirmBooking(Long id) {
        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + id));

        // Cập nhật trạng thái
        booking.setStatus(Booking.BookingStatus.CONFIRMED);

        // Lưu lại
        bookingRepository.save(booking);
    }
    public void deleteBooking(Long id) {
        // Kiểm tra xem booking có tồn tại không trước khi xóa
        if (!bookingRepository.existsById(id)) {
            throw new RuntimeException("Booking not found with id: " + id);
        }
        bookingRepository.deleteById(id);
    }
    public Booking updateBookingStatus(Long bookingId, String newStatus, String trackingCode) {
        // Tìm booking trong CSDL
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found with id: " + bookingId));

        // Cập nhật trạng thái
        booking.setStatus(Booking.BookingStatus.valueOf(newStatus.toUpperCase()));

        // Cập nhật mã vận đơn
        booking.setTrackingCode(trackingCode);

        // Lưu lại các thay đổi và trả về
        return bookingRepository.save(booking);
    }
}