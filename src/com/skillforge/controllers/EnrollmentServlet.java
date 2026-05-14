package com.skillforge.controllers;

import com.skillforge.model.Course;
import com.skillforge.model.Enrollment;
import com.skillforge.model.Quiz;
import com.skillforge.model.QuizAttempt;
import com.skillforge.service.CourseService;
import com.skillforge.service.EnrollmentService;
import com.skillforge.service.QuizService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Serves the enrollment pages for both admin and student users.
 * /admin/enrollments lists every enrollment record.
 * /student/courses lets the student view their courses, browse and search the
 * catalog, enroll in a new course, drop an existing one or update progress.
 */
@WebServlet({"/admin/enrollments", "/student/courses"})
public class EnrollmentServlet extends HttpServlet {

    private final EnrollmentService enrollmentService = new EnrollmentService();
    private final CourseService     courseService     = new CourseService();
    private final QuizService       quizService       = new QuizService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        try {
            if ("/admin/enrollments".equals(path)) {
                // Admin view shows every enrollment in the system
                List<Enrollment> enrollments = enrollmentService.getAll();
                req.setAttribute("enrollments", enrollments);
                req.getRequestDispatcher("/WEB-INF/pages/admin/manage-enrollments.jsp").forward(req, resp);

            } else {
                // Student view supports the enroll, drop and search actions
                HttpSession session = req.getSession();
                int studentId = (int) session.getAttribute("userId");
                String action = req.getParameter("action");

                if ("enroll".equals(action)) {
                    int courseId = Integer.parseInt(req.getParameter("courseId"));
                    if (!enrollmentService.alreadyEnrolled(studentId, courseId)) {
                        enrollmentService.enroll(studentId, courseId);
                    }
                    resp.sendRedirect(req.getContextPath() + "/student/courses");
                    return;

                } else if ("drop".equals(action)) {
                    int enrollmentId = Integer.parseInt(req.getParameter("enrollmentId"));
                    enrollmentService.drop(enrollmentId, studentId);
                    resp.sendRedirect(req.getContextPath() + "/student/courses");
                    return;
                }

                // Default action shows the student's courses and the available catalog
                List<Enrollment> myEnrollments = enrollmentService.getByStudent(studentId);

                // Look up the quiz and the most recent attempt for each enrolled course
                // so the JSP can render the quiz button without further service calls
                Map<Integer, Quiz>        quizByCourse        = new HashMap<>();
                Map<Integer, QuizAttempt> lastAttemptByCourse = new HashMap<>();
                for (Enrollment en : myEnrollments) {
                    Quiz q = quizService.getQuizByCourseId(en.getCourseId());
                    if (q != null) {
                        quizByCourse.put(en.getCourseId(), q);
                        QuizAttempt last = quizService.getLastAttempt(studentId, q.getId());
                        if (last != null) {
                            lastAttemptByCourse.put(en.getCourseId(), last);
                        }
                    }
                }

                String keyword = req.getParameter("search");
                List<Course> available;
                if (keyword != null && !keyword.trim().isEmpty()) {
                    available = courseService.searchAvailableForStudent(studentId, keyword.trim());
                    req.setAttribute("search", keyword.trim());
                } else {
                    available = courseService.getAvailableForStudent(studentId);
                }
                req.setAttribute("myEnrollments", myEnrollments);
                req.setAttribute("availableCourses", available);
                req.setAttribute("quizByCourse", quizByCourse);
                req.setAttribute("lastAttemptByCourse", lastAttemptByCourse);
                req.getRequestDispatcher("/WEB-INF/pages/student/my-courses.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // The student form posts a new progress value for one of their enrollments
        try {
            HttpSession session = req.getSession();
            int studentId    = (int) session.getAttribute("userId");
            int enrollmentId = Integer.parseInt(req.getParameter("enrollmentId"));
            int progress     = Integer.parseInt(req.getParameter("progress"));

            enrollmentService.updateProgress(enrollmentId, studentId, progress);
            resp.sendRedirect(req.getContextPath() + "/student/courses");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
