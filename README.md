
# SCHEMA
Student Course Helper & Enrollment Management Application

GitHub: https://github.com/farnswj1/ProjectSCHEMA.git

## Project Summary
This is an open-source web application that allows users to manage enrollment by allowing students to enroll/drop courses while also allowing professors and administrators to handle waitlist entries submitted by the students. Administrators have the ability to manage enrollment, manage user accounts, and create/modify/delete courses, meanwhile professors can revise the course information if necessary. 


## System Requirements
Device: Computer/Desktop (not for mobile devices)
Recommended OS: Windows, MacOS, Linux
Software: Ruby 2.6.4, Rails 5.2.3, PostgresSQL 9.2
Storage Size: 35MB
Recommended Software: Git


## Installation
Ensure your device has Ruby 2.6.4 and Rails 5.2.3 before attempting to run this program. Use Git to retrieve the program. Also, create a superuser called *sysadmin* in PostgreSQL since the program is currently set up to run on that user. The default password is located in the *config/database.yml* file. The password can be changed, however it must match the password used for *sysadmin* in PostgreSQL.

To retrieve the program via Git, enter in your terminal: 

*‘git clone https://github.com/farnswj1/ProjectSCHEMA.git’*

Another option is to download directly from the link, but there is no guarantee that this will allow the program to run properly. It is strongly advised to use Git instead.

Once the program is in your directory, go to the src/ directory, where the application is located, and enter *‘bundle install’*. The program will install the gems needed for the program. Also enter *‘rails db:setup’* or *‘bundle exec rake db:setup’* to set up the database. Finally, run the server via *'rails s'*.


## Program Use
The program has 3 types of users: students, professors, and administrators.

Upon signing up, the user is a student by default. The user will be required to create a student profile before continuing. Afterwards, the student can view the list of courses (View Course List) and browse through the courses that are being offered. The student can also view the course’s information by clicking View on the right of the desired course. From there, the student can view the roster of the course or, if there are seats available, enroll in the course! The student can also drop the course as well.

If a student wants to enroll in a course that is already filled, the user can add themselves to a waitlist. The student can fill out a form, selecting the desired course. The professors and administrators can either enroll the student or dismiss the request.
The professors are able to modify course details, such as the minimum or maximum number of seats. They can also manage waitlist entries and view the user accounts in the system.

The administrator has the same privileges as the professor, but they also have the ability to create/delete courses and user accounts. User accounts can be modified by the administrator, unlike professors. They also have the ability to change course rosters by removing students from the course.

An important feature that administrators have is that they can grant users privileges. For example, a professor can be given the privileges of an administrator. Even students can receive these privileges by the administrator. Those privileges can also be revoked by the administrators as well.

Every user can access the FAQs page to learn more about the application and its features.


## Maintenance
SCHEMA will be maintained by the original developer of the project. Users can download and submit updated versions of the software, including any addition features or bug fixes. They may be approved and the changes will be made to the master branch.


## Issues Not Addressed
The program currently doesn’t establish prerequisites for the courses, so students can enroll in any course. There is also no system that keeps track of the students’ previous courses and grades for those courses, which will determine if the student is eligible to enroll in a particular course.


## Bugs
The professors are given a link to edit profiles on the User Accounts page, although they are not supposed to. This link needs to be removed from the Options column. Only administrators should be able to edit profiles.
