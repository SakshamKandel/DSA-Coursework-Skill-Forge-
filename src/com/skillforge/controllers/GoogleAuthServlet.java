package com.skillforge.controllers;

import com.skillforge.model.User;
import com.skillforge.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Handles the Sign In with Google flow.
 * The ID token returned by Google Identity Services is verified against
 * Google's tokeninfo endpoint. If the token is valid the user is either
 * logged in (existing student) or automatically registered as a new student.
 *
 * The verification steps are:
 *   1. Read the JWT ID token from the POST parameter "credential".
 *   2. Send it to Google's tokeninfo endpoint which validates the signature,
 *      issuer and expiry server-side and returns the decoded payload as JSON.
 *   3. Confirm that the audience matches our client id and that the email
 *      is verified.
 *   4. Look up the account by email and create a new student account if
 *      none exists.
 *   5. Set the same session attributes that a normal login would set.
 */
@WebServlet("/auth/google")
public class GoogleAuthServlet extends HttpServlet {

    // OAuth 2.0 client id issued by the Google Cloud Console
    private static final String CLIENT_ID =
        "740455423110-bi3kos6v3msmmcs1u09lrudu2g0r0dnt.apps.googleusercontent.com";

    private static final String TOKENINFO_URL =
        "https://oauth2.googleapis.com/tokeninfo?id_token=";

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // A direct GET to this endpoint is not meaningful so send the user to login
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idToken = req.getParameter("credential");
        if (idToken == null || idToken.trim().isEmpty()) {
            redirectError(req, resp, "Missing Google credential.");
            return;
        }

        try {
            String json = fetchTokenInfo(idToken.trim());
            if (json == null) {
                redirectError(req, resp, "Google did not accept the sign-in token.");
                return;
            }

            String aud           = jsonString(json, "aud");
            String email         = jsonString(json, "email");
            String emailVerified = jsonString(json, "email_verified");
            String name          = jsonString(json, "name");
            String sub           = jsonString(json, "sub");

            if (!CLIENT_ID.equals(aud)) {
                redirectError(req, resp, "Invalid Google audience.");
                return;
            }
            if (!"true".equalsIgnoreCase(emailVerified)) {
                redirectError(req, resp, "Google email not verified.");
                return;
            }
            if (email == null || email.isEmpty()) {
                redirectError(req, resp, "No email returned from Google.");
                return;
            }

            User user = userService.findByEmail(email);
            if (user == null) {
                // Brand new Google user, create a student account on the fly
                String displayName = (name != null && !name.isEmpty()) ? name : email;
                user = userService.registerGoogleUser(email, displayName, sub);
            } else if (!"student".equals(user.getRole())) {
                redirectError(req, resp, "Admin accounts must sign in with a password.");
                return;
            } else if (user.isLocked()) {
                redirectError(req, resp, "Account is locked. Please contact admin.");
                return;
            }

            // Set the same session attributes that LoginServlet uses for password login
            HttpSession session = req.getSession(true);
            session.setAttribute("userId",    user.getId());
            session.setAttribute("userName",  user.getFullName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("hasPhoto",
                user.getProfilePhoto() != null && user.getProfilePhoto().length > 0);
            session.setAttribute("role",      user.getRole());
            session.setMaxInactiveInterval(30 * 60);

            resp.sendRedirect(req.getContextPath() + "/student");

        } catch (Exception e) {
            redirectError(req, resp, "Google sign-in failed: " + e.getMessage());
        }
    }

    /**
     * Calls Google's tokeninfo endpoint and returns the JSON body on success.
     * Returns null if the HTTP status code is not 200.
     */
    private String fetchTokenInfo(String idToken) throws IOException {
        URL url = new URL(TOKENINFO_URL + URLEncoder.encode(idToken, StandardCharsets.UTF_8.name()));
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(5000);
        try {
            int code = conn.getResponseCode();
            if (code != 200) return null;
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) sb.append(line);
                return sb.toString();
            }
        } finally {
            conn.disconnect();
        }
    }

    /**
     * Reads a string valued field from a flat JSON object.
     * This is sufficient for the tokeninfo response because the values are
     * quoted strings and there is no nesting.
     */
    private static String jsonString(String json, String field) {
        if (json == null) return null;
        Pattern p = Pattern.compile(
            "\"" + Pattern.quote(field) + "\"\\s*:\\s*\"((?:\\\\.|[^\"\\\\])*)\"");
        Matcher m = p.matcher(json);
        return m.find() ? m.group(1) : null;
    }

    private void redirectError(HttpServletRequest req, HttpServletResponse resp, String msg)
            throws IOException {
        resp.sendRedirect(req.getContextPath() + "/login?error="
                + URLEncoder.encode(msg, StandardCharsets.UTF_8.name()));
    }
}
