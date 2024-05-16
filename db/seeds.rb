# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Create admin user 
User.create!(email: 'admin@example.com', password: 'testpassword', password_confirmation: 'testpassword', admin: true, name: 'Admin')

# Create users
3.times do |n|
    names = ["John Doe", "Jane Doe", "Joe Schmoe"]
    User.create!(email: "user-#{n+1}@example.com", password: 'testpassword', password_confirmation: 'testpassword', name: names[n])
end

# Create job applications
JobApplication.create!(
  summary: <<~TEXT,
    Motivated Junior Rails Developer with foundational skills in Ruby on Rails
    and web development.

    Skills:

      - Ruby on Rails: Basic knowledge
      - Front-end:
        - HTML
        - CSS
        - JavaScript
      - Databases:
        - SQL
        - PostgreSQL
      - Version Control: Git
  TEXT
  experience: "Entry Level",
  git_competence: "Very Comfortable",
  rails_competence: "Comfortable",
  preferred_contact: "Email",
  terms: true,
  email: "user-1@example.com",
  name: "John Doe",
  user_id: 2,
  status: "Pending"
)

JobApplication.create!(
  summary: <<~TEXT,
    Enthusiastic Junior Rails Developer with foundational skills in Ruby on Rails and web development.
    Eager to learn and contribute to dynamic team projects.

    Skills:

      - Ruby on Rails: Basic understanding of Rails, MVC, RESTful design.
      - Front-end: Familiar with HTML, CSS, JavaScript, and Bootstrap.
      - Databases: Experience with SQL and PostgreSQL.
      - Version Control: Proficient in Git.
      - Testing: Knowledge of RSpec and Capybara.

    Experience:

      - Projects/Internships: Hands-on experience with Rails projects, demonstrating practical skills.
      - Teamwork: Worked in team settings, familiar with Agile and code reviews.

    Personal Attributes:

      - Quick learner, problem solver, good communicator.

    Goals:

      - Committed to continuous learning and career growth in Rails development.
  TEXT
  experience: "Intermediate",
  git_competence: "Comfortable",
  rails_competence: "Comfortable",
  preferred_contact: "Phone",
  terms: true,
  email: "user-2@example.com",
  name: "Jane Doe",
  user_id: 3,
  status: "Rejected"
)

JobApplication.create!(
  summary: <<~TEXT,
    A motivated and eager Junior Rails Developer with a foundational understanding of web development, particularly in Ruby on Rails. Passionate about learning and growing in the field, with hands-on experience through internships, personal projects, or bootcamp training. Adept at working collaboratively in a team environment and eager to contribute to building efficient, scalable web applications.

    Skills:

      - Ruby on Rails: Basic to intermediate knowledge of Rails framework, MVC architecture, RESTful design, and common gems.
      - Front-end Technologies: Familiar with HTML, CSS, JavaScript, and libraries like Bootstrap and jQuery.
      - Databases: Experience with SQL, PostgreSQL, and Active Record for database management and queries.
      - Version Control: Proficient in Git for version control and collaboration.
      - Testing: Basic knowledge of RSpec and Capybara for testing Rails applications.
      - Development Tools: Familiar with using editors like VSCode, command-line tools, and Rails console.

    Experience:

      - Internships/Projects: Practical experience through internships or personal projects, demonstrating the ability to build and maintain Rails applications.
      - Collaborative Work: Experience working in a team setting, using Agile methodologies and participating in code reviews.

    Personal Attributes:

      - Quick Learner: Ability to quickly pick up new technologies and frameworks.
      - Problem Solver: Strong analytical skills and a methodical approach to debugging and solving issues.
      - Communication: Good communication skills, both written and verbal, enabling effective collaboration with team members and stakeholders.

    Goals:

      - Continuous Learning: Committed to continuous improvement and keeping up with the latest industry trends and best practices in Ruby on Rails development.
      - Career Growth: Aspiring to advance to a full-fledged Rails Developer role, contributing to larger and more complex projects over time.
  TEXT
  experience: "Advanced",
  git_competence: "Neutral",
  rails_competence: "Neutral",
  preferred_contact: "No Preference",
  terms: true,
  email: "user-3@example.com",
  name: "Joe Schmoe",
  user_id: 4,
  status: "Accepted"
)