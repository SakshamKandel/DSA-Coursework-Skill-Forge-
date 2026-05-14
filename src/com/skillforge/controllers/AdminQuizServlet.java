package com.skillforge.controllers;

import com.skillforge.model.Course;
import com.skillforge.model.Question;
import com.skillforge.model.Quiz;
import com.skillforge.service.CourseService;
import com.skillforge.service.QuizService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles the admin pages used to create quizzes, add questions and delete quizzes.
 */
@WebServlet("/admin/quizzes")
public class AdminQuizServlet extends HttpServlet {

    private final QuizService quizService = new QuizService();
    private final CourseService courseService = new CourseService();

    // Stops the browser from caching the page so changes are visible after a redirect
    private void setNoCache(HttpServletResponse resp) {
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        setNoCache(resp);
        String action = req.getParameter("action");
        String quizIdParam = req.getParameter("quizId");

        try {
            // Delete the requested quiz before rendering the page
            if ("deleteQuiz".equals(action)) {
                if (quizIdParam != null && !quizIdParam.isEmpty()) {
                    int idToDelete = Integer.parseInt(quizIdParam);
                    quizService.deleteQuiz(idToDelete);
                    req.getSession().setAttribute("success", "Quiz " + idToDelete + " deleted successfully.");
                }
                resp.sendRedirect(req.getContextPath() + "/admin/quizzes");
                return;
            }

            // Load the lists of quizzes and courses needed to render the page
            List<Quiz> quizzes = quizService.getAllQuizzes();
            List<Course> courses = courseService.getAll();

            if (quizzes == null) quizzes = new ArrayList<>();
            if (courses == null) courses = new ArrayList<>();

            req.setAttribute("quizzes", quizzes);
            req.setAttribute("courses", courses);

            // Load the questions for the selected quiz if a quiz id was supplied
            if (quizIdParam != null && !quizIdParam.isEmpty()) {
                try {
                    int quizId = Integer.parseInt(quizIdParam);
                    List<Question> questions = quizService.getQuestionsByQuizId(quizId);
                    req.setAttribute("quizQuestions", questions != null ? questions : new ArrayList<>());
                    req.setAttribute("selectedQuizId", quizId);
                } catch (NumberFormatException nfe) {
                    // Ignore a malformed quizId and fall through to an empty selection
                }
            }

            req.setAttribute("activePage", "quizzes");
            req.setAttribute("pageTitle", "Manage Quizzes");

            req.getRequestDispatcher("/WEB-INF/pages/admin/manage-quizzes.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException("Quiz management error: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        setNoCache(resp);
        String action = req.getParameter("action");

        try {
            if ("createQuiz".equals(action)) {
                int courseId = Integer.parseInt(req.getParameter("courseId"));
                String title = req.getParameter("title");
                int passingScore = Integer.parseInt(req.getParameter("passingScore"));

                Quiz quiz = new Quiz();
                quiz.setCourseId(courseId);
                quiz.setTitle(title);
                quiz.setPassingScore(passingScore);
                quizService.saveQuiz(quiz);
                req.getSession().setAttribute("success", "Quiz saved successfully.");
            } else if ("addQuestion".equals(action)) {
                int quizId = Integer.parseInt(req.getParameter("quizId"));
                String text = req.getParameter("questionText");
                String a = req.getParameter("optionA");
                String b = req.getParameter("optionB");
                String c = req.getParameter("optionC");
                String d = req.getParameter("optionD");
                String correct = req.getParameter("correctOption");

                Question q = new Question();
                q.setQuizId(quizId);
                q.setQuestionText(text);
                q.setOptionA(a);
                q.setOptionB(b);
                q.setOptionC(c);
                q.setOptionD(d);
                q.setCorrectOption(correct.charAt(0));
                quizService.saveQuestion(q);
                req.getSession().setAttribute("success", "Question added successfully.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Could not save: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/quizzes");
    }
}
