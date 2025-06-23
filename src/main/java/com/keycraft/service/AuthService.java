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
        String verificationCode = generateVerificationCode(); // Generate 6-digit code
        user.setVerificationToken(verificationCode);

        User savedUser = userRepository.save(user);
        emailService.sendVerificationEmail(email, verificationCode); // Send code via email

        return savedUser;
    }

    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // Generate 6-digit code (100000-999999)
        return String.valueOf(code);
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
                user.setVerificationToken(null); // Clear token after verification
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
}
