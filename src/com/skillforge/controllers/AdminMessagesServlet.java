package com.skillforge.controllers;

import com.skillforge.model.ContactMessage;
import com.skillforge.service.ContactService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Serves the admin page that lists inquiries submitted through the public
 * Contact page. The page lets the admin mark messages as handled once the
 * user has been replied to.
 */
@WebServlet("/admin/messages")
public class AdminMessagesServlet extends HttpServlet {

    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("handle".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                contactService.markHandled(id);
                resp.sendRedirect(req.getContextPath() + "/admin/messages");
                return;
            }

            List<ContactMessage> messages = contactService.getAll();
            req.setAttribute("messages", messages);
            req.setAttribute("pageTitle", "Contact Messages");
            req.setAttribute("activePage", "messages");
            req.getRequestDispatcher("/WEB-INF/pages/admin/messages.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
