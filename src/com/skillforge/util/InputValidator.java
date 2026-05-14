package com.skillforge.util;

/**
 * Collection of static helpers used to validate form input on the server side.
 */
public class InputValidator {

    /**
     * Returns true when the name contains only letters and spaces and is
     * between 2 and 100 characters in length.
     */
    public static boolean isValidName(String name) {
        return name != null && name.matches("^[a-zA-Z ]{2,100}$");
    }

    /**
     * Returns true when the value looks like a standard email address.
     */
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[\\w.+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
    }

    /**
     * Returns true when the value is exactly 10 digits.
     */
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^\\d{10}$");
    }

    /**
     * Returns true when the password is at least 6 characters long.
     */
    public static boolean isValidPassword(String pwd) {
        return pwd != null && pwd.length() >= 6;
    }

    /**
     * Returns true when the value is null or only whitespace.
     */
    public static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    /**
     * Returns true when the value can be parsed as a positive integer.
     */
    public static boolean isPositiveInt(String s) {
        if (isBlank(s)) return false;
        try {
            return Integer.parseInt(s.trim()) > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
