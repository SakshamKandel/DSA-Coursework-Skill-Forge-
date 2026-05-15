package com.skillforge.controllers;

import com.skillforge.model.Enrollment;
import com.skillforge.model.User;
import com.skillforge.service.CourseService;
import com.skillforge.service.EnrollmentService;
import com.skillforge.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Serves the admin dashboard and the admin student management page.
 * The same URL handles three actions selected by the action parameter:
 * the dashboard view, the list of students and the unlock or remove actions.
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final UserService       userService       = new UserService();
    private final CourseService     courseService     = new CourseService();
    private final EnrollmentService enrollmentService = new EnrollmentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("students".equals(action)) {
                List<User> students = userService.getAllStudents();
                req.setAttribute("students", students);
                req.getRequestDispatcher("/WEB-INF/pages/admin/manage-students.jsp").forward(req, resp);

            } else if ("unlock".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                userService.unlockAccount(id);
                resp.sendRedirect(req.getContextPath() + "/admin?action=students");

            } else if ("remove".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                userService.removeStudent(id);
                resp.sendRedirect(req.getContextPath() + "/admin?action=students");

            } else {
                // Default action renders the dashboard with summary statistics
                int totalStudents    = userService.getAllStudents().size();
                int totalCourses     = courseService.countAll();
                int totalEnrollments = enrollmentService.countAll();
                List<Enrollment> recent = enrollmentService.getAll();

                req.setAttribute("totalStudents",    totalStudents);
                req.setAttribute("totalCourses",     totalCourses);
                req.setAttribute("totalEnrollments", totalEnrollments);
                req.setAttribute("recentEnrollments", recent);
                req.getRequestDispatcher("/WEB-INF/pages/admin/dashboard.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
