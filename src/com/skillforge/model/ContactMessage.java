package com.skillforge.model;

import java.sql.Timestamp;

/**
 * Represents an inquiry submitted through the Contact page.
 * Stored in the contact_messages table and reviewed by the admin.
 */
public class ContactMessage {

    private int       id;
    private String    fullName;
    private String    email;
    private String    subject;
    private String    message;
    private Timestamp sentAt;
    private boolean   handled;

    public ContactMessage() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public Timestamp getSentAt() { return sentAt; }
    public void setSentAt(Timestamp sentAt) { this.sentAt = sentAt; }

    public boolean isHandled() { return handled; }
    public void setHandled(boolean handled) { this.handled = handled; }
}
