package com.skillforge.controllers;

import com.skillforge.model.User;
import com.skillforge.service.UserService;
import com.skillforge.util.InputValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Handles new student registration.
 * Validates every field, ensures the email and phone number are not already
 * in use, and stores the password in encrypted form before redirecting the
 * user back to the login page.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String email    = req.getParameter("email");
        String phone    = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirm");

        try {
            // Field level validation
            if (!InputValidator.isValidName(fullName))
                throw new Exception("Name must be 2-100 letters/spaces.");
            if (!InputValidator.isValidEmail(email))
                throw new Exception("Invalid email format.");
            if (!InputValidator.isValidPhone(phone))
                throw new Exception("Phone must be exactly 10 digits.");
            if (!InputValidator.isValidPassword(password))
                throw new Exception("Password must be at least 6 characters.");
            if (!password.equals(confirm))
                throw new Exception("Passwords do not match.");

            // Duplicate account checks
            if (userService.emailTaken(email))
                throw new Exception("Email is already registered.");
            if (userService.phoneTaken(phone))
                throw new Exception("Phone number is already registered.");

            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(password); // The service encrypts it before saving

            userService.register(user);

            resp.sendRedirect(req.getContextPath() + "/login?success=Registration+successful.+Please+login.");

        } catch (Exception e) {
            // Send the user back to the form with the entered values so they
            // do not have to retype everything when a validation rule fails
            req.setAttribute("error", e.getMessage());
            req.setAttribute("fullName", fullName);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
        }
    }
}
