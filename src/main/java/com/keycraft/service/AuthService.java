package com.keycraft.service;

import com.keycraft.model.User;
import com.keycraft.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import java.util.Optional;
import java.util.Random;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    public User registerUser(String email, String password, String firstName, String lastName, User.UserRole role) throws MessagingException {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("User with this email already exists");
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(password));
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setRole(role != null ? role : User.UserRole.CUSTOMER);
        String verificationCode = generateVerificationCode();
        user.setVerificationToken(verificationCode);

        User savedUser = userRepository.save(user);
        emailService.sendVerificationEmail(email, verificationCode);
        return savedUser;
    }

    public Optional<User> authenticateUser(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (!user.isVerified()) {
                throw new RuntimeException("Email not verified. Please check your inbox for the verification code.");
            }
            if (passwordEncoder.matches(password, user.getPassword())) {
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }

    public boolean verifyUser(String token) {
        Optional<User> userOpt = userRepository.findByVerificationToken(token);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (!user.isVerified()) {
                user.setVerified(true);
                user.setVerificationToken(null);
                userRepository.save(user);
                return true;
            }
        }
        return false;
    }

    public User createAdminUser(String email, String password, String firstName, String lastName) throws MessagingException {
        return registerUser(email, password, firstName, lastName, User.UserRole.ADMIN);
    }

    public User getCurrentUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }

        String email = authentication.getName();
        return userRepository.findByEmail(email).orElse(null);
    }

    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

    public void requestPasswordReset(String email) throws MessagingException {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isEmpty()) {
            throw new RuntimeException("Email not found.");
        }
        User user = userOpt.get();
        String resetCode = generateVerificationCode();
        user.setVerificationToken(resetCode);
        userRepository.save(user);
        emailService.sendPasswordResetEmail(email, resetCode);
    }

    public boolean verifyResetCode(String code) {
        Optional<User> userOpt = userRepository.findByVerificationToken(code);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setVerificationToken(null);
            userRepository.save(user);
            return true;
        }
        return false;
    }

    public void resetPassword(String email, String newPassword) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (user.getVerificationToken() != null) {
                throw new RuntimeException("Reset code not verified.");
            }
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
        } else {
            throw new RuntimeException("Email not found.");
        }
    }

    public void updateUserProfile(Long userId, String firstName, String lastName, String profileImageUrl) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            if (profileImageUrl != null) {
                user.setProfileImageUrl(profileImageUrl);
            }
            userRepository.save(user);
        } else {
            throw new RuntimeException("User not found.");
        }
    }

    public void changePassword(String email, String currentPassword, String newPassword) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        if (userOpt.isEmpty()) {
            throw new RuntimeException("Email not found.");
        }

        User user = userOpt.get();
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw new RuntimeException("Mật khẩu hiện tại không đúng.");
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }
}