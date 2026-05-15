package com.skillforge.controllers;

import com.skillforge.model.User;
import com.skillforge.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;

/**
 * Streams a user's profile photo from the database to the browser.
 * The photo is stored as a BLOB in the users table and is requested using
 * the URL pattern /photo?userId=123.
 */
@WebServlet("/photo")
public class PhotoServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String userIdStr = req.getParameter("userId");
        if (userIdStr == null || userIdStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            User user = userService.findById(userId);

            if (user == null || user.getProfilePhoto() == null || user.getProfilePhoto().length == 0) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            byte[] imageData = user.getProfilePhoto();

            // Allow the browser to cache the photo for one hour
            resp.setHeader("Cache-Control", "public, max-age=3600");

            // Detect the image type from the first few bytes of the file
            String mimeType = "image/jpeg";
            if (imageData.length > 4) {
                if (imageData[0] == (byte) 0x89 && imageData[1] == (byte) 0x50) mimeType = "image/png";
                else if (imageData[0] == (byte) 0x47 && imageData[1] == (byte) 0x49) mimeType = "image/gif";
                else if (imageData[0] == (byte) 0x52 && imageData[1] == (byte) 0x49) mimeType = "image/webp";
            }

            resp.setContentType(mimeType);
            resp.setContentLength(imageData.length);

            try (OutputStream out = resp.getOutputStream()) {
                out.write(imageData);
            }

        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
