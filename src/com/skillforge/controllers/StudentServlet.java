package com.skillforge.controllers;

import com.skillforge.model.Enrollment;
import com.skillforge.service.EnrollmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Serves the student dashboard with enrollment counts and the list of
 * the student's enrolled courses.
 */
@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private final EnrollmentService enrollmentService = new EnrollmentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            HttpSession session = req.getSession();
            int studentId = (int) session.getAttribute("userId");

            List<Enrollment> enrollments = enrollmentService.getByStudent(studentId);
            int enrolled  = enrollmentService.countByStudent(studentId);
            int completed = enrollmentService.countCompleted(studentId);

            req.setAttribute("enrollments",    enrollments);
            req.setAttribute("enrolledCount",  enrolled);
            req.setAttribute("completedCount", completed);

            req.getRequestDispatcher("/WEB-INF/pages/student/dashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
