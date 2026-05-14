package com.skillforge.controllers;

import com.skillforge.model.ContactMessage;
import com.skillforge.service.ContactService;
import com.skillforge.util.InputValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Serves the public Contact page.
 * GET displays the support details and the inquiry form.
 * POST validates the form, stores the message and shows a confirmation.
 * An admin who hits this page is sent to the admin Messages inbox instead.
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admins manage inquiries from the Messages page, not the public form
        if (isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/messages");
            return;
        }

        req.setAttribute("pageTitle", "Contact Us");
        req.setAttribute("activePage", "contact");
        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admins should never submit through the public form
        if (isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/messages");
            return;
        }

        req.setAttribute("pageTitle", "Contact Us");
        req.setAttribute("activePage", "contact");

        String fullName = req.getParameter("fullName");
        String email    = req.getParameter("email");
        String subject  = req.getParameter("subject");
        String message  = req.getParameter("message");

        try {
            // Validate every field before saving the message
            if (!InputValidator.isValidName(fullName))
                throw new Exception("Name must be 2-100 letters/spaces.");
            if (!InputValidator.isValidEmail(email))
                throw new Exception("Invalid email format.");
            if (InputValidator.isBlank(subject) || subject.length() > 200)
                throw new Exception("Subject is required (max 200 characters).");
            if (InputValidator.isBlank(message))
                throw new Exception("Message cannot be empty.");
            if (message.length() > 4000)
                throw new Exception("Message is too long (max 4000 characters).");

            ContactMessage msg = new ContactMessage();
            msg.setFullName(fullName.trim());
            msg.setEmail(email.trim());
            msg.setSubject(subject.trim());
            msg.setMessage(message.trim());

            contactService.saveMessage(msg);

            req.setAttribute("success",
                "Thank you for reaching out. Our team will get back to you within 24 hours.");

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            // Send the user back to the form with the entered values intact
            req.setAttribute("fullName", fullName);
            req.setAttribute("email", email);
            req.setAttribute("subject", subject);
            req.setAttribute("message", message);
        }

        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
    }

    /**
     * Returns true when the current session belongs to an admin user.
     */
    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null && "admin".equals(session.getAttribute("role"));
    }
}
