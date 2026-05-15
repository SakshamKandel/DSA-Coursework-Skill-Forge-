package com.skillforge.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filters every incoming request and enforces access rules.
 * Public pages are allowed through without a session.
 * Pages under /admin require the admin role and pages under /student require the student role.
 * Any other request without a valid session is redirected to the login page.
 */
@WebFilter("/*")
public class AccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getServletPath();

        // Public paths that do not require authentication
        if (path.equals("/login") || path.equals("/register") ||
            path.equals("/forgot-password") || path.equals("/about") ||
            path.equals("/contact") ||
            path.equals("/auth/google") ||
            path.startsWith("/css") || path.startsWith("/images") ||
            path.startsWith("/photo") || path.startsWith("/uploads") ||
            path.equals("/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");

        // Block non-admins from the admin area
        if (path.startsWith("/admin")) {
            if (!"admin".equals(role)) {
                res.sendRedirect(req.getContextPath() + "/student");
                return;
            }
        }

        // Block non-students from the student area
        if (path.startsWith("/student")) {
            if (!"student".equals(role)) {
                res.sendRedirect(req.getContextPath() + "/admin");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() { }
}
