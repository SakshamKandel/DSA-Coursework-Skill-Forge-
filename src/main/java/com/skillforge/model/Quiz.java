package com.skillforge.model;

/**
 * Represents a quiz that belongs to a course.
 */
public class Quiz {

    private int id;
    private int courseId;
    private String title;
    private String description;
    private int passingScore;

    public Quiz() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getPassingScore() { return passingScore; }
    public void setPassingScore(int passingScore) { this.passingScore = passingScore; }
}
