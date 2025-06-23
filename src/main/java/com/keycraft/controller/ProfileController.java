package com.keycraft.controller;

import com.keycraft.model.User;
import com.keycraft.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class ProfileController {

    @Autowired
    private AuthService authService;

    @GetMapping("/profile")
    public String showProfilePage(Authentication authentication, Model model) {
        User user = authService.getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(
            Authentication authentication,
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam("profileImage") MultipartFile profileImage,
            RedirectAttributes redirectAttributes) {
        User user = authService.getCurrentUser(authentication);
        if (user == null) {
            return "redirect:/login";
        }

        try {
            String profileImageUrl = null;
            if (!profileImage.isEmpty()) {
                String uploadDir = "src/main/webapp/uploads/profile/";
                String fileName = user.getId() + "_" + profileImage.getOriginalFilename();
                Path filePath = Paths.get(uploadDir + fileName);
                Files.createDirectories(filePath.getParent());
                Files.write(filePath, profileImage.getBytes());
                profileImageUrl = "/uploads/profile/" + fileName;
            }

            authService.updateUserProfile(user.getId(), firstName, lastName, profileImageUrl);
            redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin thành công!");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi tải lên ảnh: " + e.getMessage());
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/profile";
    }
}