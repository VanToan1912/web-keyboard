package com.keycraft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendVerificationEmail(String to, String verificationCode) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setTo(to);
        helper.setSubject("KeyCraft - Verify Your Email");
        helper.setText(
                "<h2>Welcome to KeyCraft!</h2>" +
                        "<p>Please use the following code to verify your email:</p>" +
                        "<h3>" + verificationCode + "</h3>" +
                        "<p>Enter this code on the verification page to activate your account.</p>" +
                        "<p>This code is valid for 24 hours.</p>", true
        );

        mailSender.send(message);
    }

    public void sendPasswordResetEmail(String to, String resetCode) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setTo(to);
        helper.setSubject("KeyCraft - Đặt lại mật khẩu");
        helper.setText(
                "<h2>KeyCraft Password Reset</h2>" +
                        "<p>Bạn đã yêu cầu đặt lại mật khẩu. Vui lòng sử dụng mã sau để xác minh:</p>" +
                        "<h3>" + resetCode + "</h3>" +
                        "<p>Nhập mã này trên trang đặt lại mật khẩu để tiếp tục.</p>" +
                        "<p>Mã này có hiệu lực trong 24 giờ.</p>", true
        );

        mailSender.send(message);
    }
}
