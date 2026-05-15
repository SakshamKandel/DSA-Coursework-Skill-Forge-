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
 * Displays the pass or fail page for a quiz attempt.
 * When a certificate has been issued for the attempt the page also shows a
 * link that lets the student view and print the certificate.
 */
@WebServlet("/student/quiz/result")
public class QuizResultServlet extends HttpServlet {

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
            // Look up the certificate for this attempt, which is null when the student failed
            Certification cert = quizService.getCertificationByAttempt(attemptId);

            req.setAttribute("cert", cert);
            req.setAttribute("attemptId", attemptId);
            req.setAttribute("pageTitle", "Quiz Results");
            req.getRequestDispatcher("/WEB-INF/pages/student/quiz-result.jsp").forward(req, resp);

        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
