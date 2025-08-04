# JustLee Library Database and Web Portal Project

This repository contains all major components of the JustLee Library Management System, developed as the final project for the ITSE-2309 Database Programming course.

The original project scope involved designing a fully normalized relational database for managing the operations of a library, including support for books, members, borrowing activity, overdue reports, and staff interactions. All SQL scripts were written for Oracle SQL Developer, and the final deliverables included schema creation, data insertion, query reports, and documentation.

In addition to the core database implementation, a separate Flask-based web portal was developed using SQLite. This web application was not required but was built to enhance the project’s usability and demonstrate how the database could power a live interface. The design was inspired by a suggestion made during early collaboration and was built from scratch for this submission.

---

## Project Scope

The original deliverables included:
- ER diagram showing all entities and relationships
- Table definitions with constraints and keys
- Sample data for testing operations
- SQL queries for inserts, deletes, updates, and complex reports
- Multiple view-based reports for staff and members
- Normalization documentation (up to 3NF)
- Presentation slides and group video presentation

All of these deliverables are included under the `Oracle_DB_Project/` directory.

The optional Flask web interface is included under `Flask_Web_Portal/`, and reuses the schema logic in a live application format using SQLite.

---

## Repository Structure

- `Oracle_DB_Project/`  
  Contains SQL scripts, ER diagrams, normalization files, and grading deliverables written for Oracle SQL Developer.

- `Flask_Web_Portal/`  
  Contains a fully functioning Flask web interface using the same logical schema. Built for demonstration and user interaction with live reports.

Each folder includes its own README with relevant instructions, documentation, and setup notes.

---

## Technologies Used

- Oracle SQL
- SQLite (for Flask demo)
- Python / Flask
- SQL Views and Reporting Logic
- HTML / CSS for templating and styling

---

## Acknowledgment

This project was completed collaboratively and received full credit upon submission. While the core deliverables focused on the Oracle SQL database system, a Flask-based web application was developed separately to demonstrate how the schema could support a live user interface.

The PortalV_002 Flask application was shown live during our final presentation to highlight interactive functionality. Although the source code for the web portal was not required or submitted as part of the official deliverables, recorded demos were included at the end of the presentation to showcase the extended implementation.

**Final Grade: 100/100**  
**Instructor Feedback:** “This is a project that was thoroughly planned and well executed. Your presentation left us wanting more.”

This repository provides a full record of both the submitted Oracle-based system and the extended Flask-based application.

