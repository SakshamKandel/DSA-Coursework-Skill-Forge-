package com.skillforge.service;

import com.skillforge.config.DBConfig;
import com.skillforge.model.ContactMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Provides the business logic for inquiries submitted through the Contact page.
 * Stores submissions in the contact_messages table and supports listing and
 * marking messages as handled by the admin.
 */
public class ContactService {

    /**
     * Saves a new inquiry and returns the generated id.
     */
    public int saveMessage(ContactMessage msg) throws SQLException {
        String sql = "INSERT INTO contact_messages (full_name, email, subject, message) VALUES (?,?,?,?)";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, msg.getFullName());
            ps.setString(2, msg.getEmail());
            ps.setString(3, msg.getSubject());
            ps.setString(4, msg.getMessage());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    /**
     * Returns all messages ordered from newest to oldest.
     */
    public List<ContactMessage> getAll() throws SQLException {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY sent_at DESC";
        try (Connection c = DBConfig.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    /**
     * Flags an inquiry as handled by the admin.
     */
    public void markHandled(int id) throws SQLException {
        String sql = "UPDATE contact_messages SET handled = 1 WHERE id = ?";
        try (Connection c = DBConfig.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private ContactMessage map(ResultSet rs) throws SQLException {
        ContactMessage m = new ContactMessage();
        m.setId(rs.getInt("id"));
        m.setFullName(rs.getString("full_name"));
        m.setEmail(rs.getString("email"));
        m.setSubject(rs.getString("subject"));
        m.setMessage(rs.getString("message"));
        m.setSentAt(rs.getTimestamp("sent_at"));
        m.setHandled(rs.getInt("handled") == 1);
        return m;
    }
}
