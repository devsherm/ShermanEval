# README

  

## Base Project for Evaluating Sherman Developer Candidates

  

**Instructions:**

Fork this repository, make your changes, and submit a Pull Request. This serves as your application for the job. Detailed instructions can be found at the URL provided to you.

  

**Important Files to Review:**

-  `.env`: Ensure you create and configure your development database.

-  `Gemfile`: Key dependencies include:

-  `ruby "3.2.2"`

-  `gem "rails", "~> 7.0.8", ">= 7.0.8.1"`

-  `gem 'dotenv-rails', groups: [:development, :test]`

-  `gem "pg", "~> 1.1"`

-  `gem "tailwindcss-rails"`

-  `gem "devise", "~> 4.9"`

-  `# gem "bcrypt", "~> 3.1.7"` # bcrypt is a dependency of Devise

  

## Prerequisites

- Docker

- Docker Compose

  

## Setup and Launch

1.  **Clone the Repository:**

`git clone <repository-url>`

2.  **Navigate to the App's Root Directory:**

`cd <repository-name>`

3.  **Review Configuration Files:**

-  `config/environments/development.rb`

-  `config/database.yml`

- Create your `.env.development.local` for Docker environment settings.

4.  **Build the Docker Containers:**

`docker-compose build --no-cache`

5.  **Start the Application:**

`docker-compose up`

6.  **Setup the Database:**

Open a new terminal and run the following commands one after another:
`docker-compose exec web bash`
`rails db:migrate`

7.  **Access the Application:**

Open a web browser and go to `http://localhost:3000`. The first user created is an admin; all subsequent users are regular users.

8.  **Shutdown and Cleanup:**

Exit from the bash shell and run:

`docker-compose down --volumes --remove-orphans`    