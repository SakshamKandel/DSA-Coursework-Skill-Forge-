package com.skillforge.controllers;

import com.skillforge.model.User;
import com.skillforge.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Handles user login.
 * GET shows the login form, POST validates the credentials and sets up the
 * session attributes that the rest of the application relies on.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // If the user is already signed in send them to the right dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            String role = (String) session.getAttribute("role");
            resp.sendRedirect(req.getContextPath() + ("admin".equals(role) ? "/admin" : "/student"));
            return;
        }

        // Forward any error or success messages passed in the query string
        String error   = req.getParameter("error");
        String success = req.getParameter("success");
        if (error != null)   req.setAttribute("error", error);
        if (success != null) req.setAttribute("success", success);

        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            User user = userService.authenticate(email, password);
            HttpSession session = req.getSession(true);
            session.setAttribute("userId",    user.getId());
            session.setAttribute("userName",  user.getFullName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("hasPhoto",  (user.getProfilePhoto() != null && user.getProfilePhoto().length > 0));
            session.setAttribute("role",      user.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 minute idle timeout

            resp.sendRedirect(req.getContextPath() +
                ("admin".equals(user.getRole()) ? "/admin" : "/student"));

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        }
    }
}
