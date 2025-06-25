package com.keycraft.controller;

import com.keycraft.model.Booking;
import com.keycraft.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class BookingController {

    @Autowired
    private BookingService bookingService;

    /**
     * Method này xử lý yêu cầu GET để hiển thị trang form đặt pre-order.
     * URL được đổi thành "/pre-order" cho rõ nghĩa hơn.
     * @param model Dùng để truyền dữ liệu từ Controller sang View.
     * @return Tên của file view để hiển thị.
     */
    @GetMapping("/booking")
    public String showPreOrderForm(Model model) {
        // Tạo một đối tượng Booking rỗng và gửi nó tới view.
        // Điều này cần thiết để Spring Form hoặc Thymeleaf có thể binding dữ liệu.
        model.addAttribute("booking", new Booking());
        // Trả về tên file view (ví dụ: pre-order-form.jsp)
        return "booking";
    }

    /**
     * Method này xử lý yêu cầu POST khi người dùng nhấn nút submit trên form.
     * URL phải khớp với thuộc tính 'action' của thẻ <form>.
     * @param booking Đối tượng được Spring tự động tạo và điền dữ liệu từ form.
     * @param redirectAttributes Dùng để gửi thông báo sau khi chuyển hướng (redirect).
     * @return Chuyển hướng về trang form pre-order.
     */
    @PostMapping("/booking/submit")
    public String handlePreOrderSubmit(@ModelAttribute("booking") Booking booking, RedirectAttributes redirectAttributes) {
        try {
            // Lưu đối tượng booking và lấy lại đối tượng đã được lưu (có chứa ID)
            Booking savedBooking = bookingService.savePreOrder(booking);

            // Chuyển hướng đến trang xác nhận với ID của đơn hàng
            return "redirect:/booking/confirmation/" + savedBooking.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đã có lỗi xảy ra, vui lòng thử lại.");
            e.printStackTrace();
            return "redirect:/booking";
        }
    }
    @GetMapping("/booking/confirmation/{bookingId}")
    public String showConfirmationPage(@PathVariable("bookingId") Long bookingId, Model model, RedirectAttributes redirectAttributes) {
        try {
            // Tìm kiếm đơn hàng theo ID (bạn cần thêm method này vào Service và Repository)
            Booking booking = bookingService.findBookingById(bookingId)
                    .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy đơn hàng với ID: " + bookingId));

            model.addAttribute("booking", booking);
            return "booking_form"; // <-- ĐÃ SỬA
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể tìm thấy thông tin đơn hàng.");
            // LỖI Ở ĐÂY: Phải redirect về trang form là /booking
            return "redirect:/booking";
        }
    }
    @PostMapping("/{id}/confirm")
    public ResponseEntity<?> confirmBooking(@PathVariable("id") Long id) {
        try {
            bookingService.confirmBooking(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBooking(@PathVariable("id") Long id) {
        try {
            bookingService.deleteBooking(id);
            return ResponseEntity.ok().build(); // Trả về 200 OK
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
    @PutMapping("/{id}/status")
    public ResponseEntity<?> updateBookingStatus(@PathVariable Long id, @RequestBody UpdateBookingStatusRequest request) {
        try {
            // Đây là lời gọi hàm đúng, không phải khai báo
            bookingService.updateBookingStatus(id, request.getStatus(), request.getTrackingCode());
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}