# Oracle_DB_Project

This folder contains the full set of Oracle SQL deliverables submitted for the ITSE-2309 final group project.  
The objective of the assignment was to design and implement a normalized relational database for a library management system.  
Our implementation included core operations such as book and member management, borrowing and returning, overdue tracking,  
and various reporting features.

The entire schema and supporting logic were written in Oracle SQL syntax and tested in SQL*Plus and Oracle SQL Developer.

This version represents the official graded submission. The project met all technical and documentation requirements defined by the course.

---

## Deliverables Included

- `JustLee_All_in_One_DB_Script_OracleDev_V002.sql`  
  Full drop, create, insert, and view logic in a single run-ready file.

- `Expected_Output_All_in_One_DB_Script_OracleDev_RUN002.txt`  
  Console output from a successful full execution of the SQL script in SQL Developer.

- `JustLee_Data_Normalization.txt`  
  Step-by-step explanation of normalization decisions applied through 3NF.

- `ER-DiagramV_002.txt`  
  Textual representation of the entity-relationship diagram.  
  A visual `.png` version is also included.

- `LibraryERDiagramV_001.png`  
  Visual layout of all entities and relationships used in the final schema.

- `Oracle_DB_Project.pptx`  
  Slides used during the final group presentation, covering technical design, motivation, and feature highlights.  
  Included on the final slide are two videos demonstrating the Flask app in operation. See Additional Context for more details.

- `SCRIPT FINAL DRAFT.docx`  
  Annotated speaker script used during the group presentation.

---

## Project Highlights

- Normalized schema with 3NF enforcement  
- Functional table creation with constraints and foreign keys  
- Insert scripts for sample data population  
- View definitions for staff and member analytics  
- Drop and rebuild support for reruns and testing  
- Consistent formatting and human-readable structure  
- All queries validated and functional in Oracle SQL Developer

---

## Output Notes

The `Expected_Output_All_in_One_DB_Script_OracleDev_RUN002.txt` file reflects the expected behavior of the script under Oracle SQL Developer.  
Minor error messages are expected when dropping tables or views that do not exist in a fresh environment. These do not affect execution.

---

## Additional Context

Some minor formatting inconsistencies (such as indentation or alignment) may appear when viewing certain files directly in GitHub. These are rare and do not affect the core structure or accuracy of the SQL or documentation.

The PowerPoint presentation may need to be **downloaded** to view properly due to embedded videos. GitHub’s online preview may not render all media correctly because of file size or format limitations.

Note: This version does **not** include the Flask-based web portal build. That implementation is located in the `/Flask_Web_Portal` directory of the main repository and was shown during the final presentation. While the Flask source code was not required for grading, two short demo videos were embedded in the final slide of the presentation to illustrate functionality.

This folder represents the original submission required for full credit. The work was graded on database design, normalization, SQL correctness, query functionality, and documentation quality.

**Final Grade Received: 100/100**
