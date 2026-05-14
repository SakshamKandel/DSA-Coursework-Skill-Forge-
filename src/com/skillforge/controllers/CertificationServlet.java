package com.skillforge.controllers;

import com.skillforge.model.Certification;
import com.skillforge.service.QuizService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Displays the certificate of completion for a given quiz attempt.
 * If no certificate exists for the attempt the user is sent back to their courses.
 */
@WebServlet("/student/certification")
public class CertificationServlet extends HttpServlet {

    private final QuizService quizService = new QuizService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String attemptIdStr = req.getParameter("attemptId");
        if (attemptIdStr == null || attemptIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/student/courses");
            return;
        }

        try {
            int attemptId = Integer.parseInt(attemptIdStr);
            Certification cert = quizService.getCertificationByAttempt(attemptId);

            if (cert == null) {
                resp.sendRedirect(req.getContextPath() + "/student/courses");
                return;
            }

            req.setAttribute("cert", cert);
            req.setAttribute("pageTitle", "Certificate of Completion");
            req.getRequestDispatcher("/WEB-INF/pages/student/certification.jsp").forward(req, resp);

        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
