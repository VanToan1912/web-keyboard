package com.keycraft.controller;

import com.keycraft.model.Order;
import com.keycraft.model.Product;
import com.keycraft.model.User;
import com.keycraft.repository.OrderRepository;
import com.keycraft.repository.UserRepository;
import com.keycraft.service.CartService;
import com.keycraft.service.OrderService;
import com.keycraft.service.ProductService;
import com.keycraft.service.ServiceBookingService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CartService cartService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private ServiceBookingService serviceBookingService;
    @Autowired
    private OrderRepository orderRepository;
    @GetMapping("/")
    public String homeRedirect() {
        return "redirect:/index";
    }

    @GetMapping("/index")
    public String index(Model model) {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        User user = null;

        if (auth != null && auth.isAuthenticated() && !auth.getPrincipal().equals("anonymousUser")) {
            String email = auth.getName();
            user = userRepository.findByEmail(email).orElse(null);
        }

        if (user != null) {
            model.addAttribute("currentUser", user);
            model.addAttribute("cartItemCount", cartService.getCartItemCount(user));
        } else {
            model.addAttribute("cartItemCount", 0L);
        }

        model.addAttribute("featuredProducts", productService.getFeaturedProducts());
        model.addAttribute("newProducts", productService.getNewProducts());
        model.addAttribute("suggestedProducts", productService.getSuggestedProducts());

        return "index";
    }

    @GetMapping("/products")
    public String products(Model model) {
        var auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
            return "redirect:/login";
        }

        String email = auth.getName();
        User currentUser = userRepository.findByEmail(email).orElse(null);

        if (currentUser != null) {
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("cartItemCount", cartService.getCartItemCount(currentUser));
        }

        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);

        return "products";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        var auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth == null || !auth.isAuthenticated() || auth.getPrincipal().equals("anonymousUser")) {
            return "redirect:/login?error=access_denied";
        }

        String email = auth.getName();
        User user = userRepository.findByEmail(email).orElse(null);
        List<Object[]> revenueByDay = orderRepository.getRevenueByPeriod(
        	    "%Y-%m-%d",
        	    LocalDate.now().getMonthValue(),
        	    LocalDate.now().getYear()
        	);        
        List<Object[]> revenueByCategory = orderRepository.getRevenueByCategory(LocalDate.now().getMonthValue(), LocalDate.now().getYear());
        if (user == null || !User.UserRole.ADMIN.equals(user.getRole())) {
            return "redirect:/login?error=access_denied";
        }

        model.addAttribute("currentUser", user);
        model.addAttribute("products", productService.getAllProducts());
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("orders", orderService.getAllOrders());
        model.addAttribute("orderStatuses", Order.OrderStatus.values());
        model.addAttribute("services", serviceBookingService.findAll());

        model.addAttribute("revenueByDay", revenueByDay);
        model.addAttribute("revenueByCategory", revenueByCategory);
        model.addAttribute("currentMonth", LocalDate.now().getMonthValue());
        model.addAttribute("currentYear", LocalDate.now().getYear());



        // TODO: add orderService.getAllOrders() if you have
        // model.addAttribute("orders", orderService.getAllOrders());

        // TODO: add serviceBookingService.getAllBookings() if needed
        // model.addAttribute("services", serviceBookingService.getAll());

        return "dashboard";
    }

    @GetMapping("/login")
    public String login(HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            return "redirect:/";
        }
        return "auth/login";
    }

    @GetMapping("/signup")
    public String signup(HttpSession session) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            return "redirect:/";
        }
        return "auth/signup";
    }
}
