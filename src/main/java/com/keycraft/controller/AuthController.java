package com.keycraft.controller;

import com.keycraft.model.User;
import com.keycraft.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.mail.MessagingException;
import java.util.Optional;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @GetMapping("/signup")
    public String showSignupPage() {
        return "auth/signup";
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "auth/login";
    }

    @PostMapping("/signup")
    public String signup(@RequestParam String email,
                         @RequestParam String password,
                         @RequestParam String firstName,
                         @RequestParam String lastName,
                         @RequestParam(defaultValue = "CUSTOMER") String role,
                         RedirectAttributes redirectAttributes) {
        try {
            User.UserRole userRole = "ADMIN".equalsIgnoreCase(role) ? User.UserRole.ADMIN : User.UserRole.CUSTOMER;
            authService.registerUser(email, password, firstName, lastName, userRole);
            redirectAttributes.addFlashAttribute("email", email);
            redirectAttributes.addFlashAttribute("success", "Account created successfully! Please check your email for the verification code.");
            return "redirect:/auth/verify-code";
        } catch (MessagingException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to send verification email: " + e.getMessage());
            return "redirect:/signup";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Registration failed: " + e.getMessage());
            return "redirect:/signup";
        }
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        RedirectAttributes redirectAttributes) {
        try {
            Optional<User> userOpt = authService.authenticateUser(email, password);
            if (userOpt.isPresent()) {
                return User.UserRole.ADMIN.equals(userOpt.get().getRole()) ? "redirect:/dashboard" : "redirect:/";
            } else {
                redirectAttributes.addFlashAttribute("error", "Invalid email or password");
                return "redirect:/login";
            }
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/login";
        }
    }

    @GetMapping("/logout")
    public String logout() {
        return "redirect:/login?logout=true";
    }

    @GetMapping("/verify-code")
    public String showVerifyCodePage(@ModelAttribute("email") String email, RedirectAttributes redirectAttributes) {
        if (email == null || email.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "No email provided for verification.");
            return "redirect:/signup";
        }
        return "auth/verify-code";
    }

    @PostMapping("/verify-code")
    public String verifyCode(@RequestParam String code, @RequestParam String email, RedirectAttributes redirectAttributes) {
        boolean verified = authService.verifyUser(code);
        if (verified) {
            redirectAttributes.addFlashAttribute("success", "Email verified successfully! You can now log in.");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid verification code.");
            redirectAttributes.addFlashAttribute("email", email);
            return "redirect:/auth/verify-code";
        }
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String requestPasswordReset(@RequestParam String email, RedirectAttributes redirectAttributes) {
        try {
            authService.requestPasswordReset(email);
            redirectAttributes.addFlashAttribute("email", email);
            redirectAttributes.addFlashAttribute("success", "A reset code has been sent to your email.");
            return "redirect:/auth/verify-reset-code";
        } catch (MessagingException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to send reset code: " + e.getMessage());
            return "redirect:/auth/forgot-password";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/auth/forgot-password";
        }
    }

    @GetMapping("/verify-reset-code")
    public String showVerifyResetCodePage(@ModelAttribute("email") String email, RedirectAttributes redirectAttributes) {
        if (email == null || email.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "No email provided for password reset.");
            return "redirect:/auth/forgot-password";
        }
        return "auth/verify-reset-code";
    }

    @PostMapping("/verify-reset-code")
    public String verifyResetCode(@RequestParam String code, @RequestParam String email, RedirectAttributes redirectAttributes) {
        boolean verified = authService.verifyResetCode(code);
        if (verified) {
            redirectAttributes.addFlashAttribute("email", email);
            return "redirect:/auth/reset-password";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid reset code.");
            redirectAttributes.addFlashAttribute("email", email);
            return "redirect:/auth/verify-reset-code";
        }
    }

    @GetMapping("/reset-password")
    public String showResetPasswordPage(@ModelAttribute("email") String email, RedirectAttributes redirectAttributes) {
        if (email == null || email.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "No email provided for password reset.");
            return "redirect:/auth/forgot-password";
        }
        return "auth/reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String email, @RequestParam String password, RedirectAttributes redirectAttributes) {
        try {
            authService.resetPassword(email, password);
            redirectAttributes.addFlashAttribute("success", "Password reset successfully! You can now log in.");
            return "redirect:/login";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            redirectAttributes.addFlashAttribute("email", email);
            return "redirect:/auth/reset-password";
        }
    }
}