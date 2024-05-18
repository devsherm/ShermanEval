# ShermanEval

ShermanEval is a web application designed to manage applicant information seamlessly. This project is developed using Ruby on Rails, Docker, and Tailwind CSS, making it robust, scalable, and easy to manage.

## Table of Contents

1. [Getting Started](#getting-started)
   1. [Prerequisites](#prerequisites)
   2. [Installation](#installation)
2. [Database Setup](#database-setup)
3. [Running the Application](#running-the-application)
4. [Tests](#tests)
5. [Security Checks](#security-checks)
6. [Docker](#docker)
7. [Contributing](#contributing)
8. [License](#license)

## Getting Started

This section provides a quick guide to set up the project locally.

### Prerequisites

Ensure you have the following software installed:

- Docker & Docker Compose
- Ruby 3.2.2
- PostgreSQL
- Node.js & npm

### Installation

1. Clone the Repository:

    ```bash
    git clone https://github.com/your-username/ShermanEval.git
    cd ShermanEval
    ```

2. Set up Gems:

   Install necessary Ruby gems:

    ```bash
    bundle install
    ```

3. Set up JavaScript Packages:

   Install necessary JavaScript packages:

    ```bash
    npm install
    ```

4. Install Tailwind CSS and Build Assets:

   Install Tailwind CSS dependencies:

    ```bash
    npm install tailwindcss autoprefixer postcss-cli
    ```

   Then build Tailwind CSS:

    ```bash
    yarn build
    ```

## Database Setup

1. Create the Database:

    ```bash
    bundle exec rails db:create
    ```

2. Run Migrations:

    ```bash
    bundle exec rails db:migrate
    ```

## Running the Application

1. Run Rails Server:

   Start the Rails server:

    ```bash
    bundle exec rails server
    ```

2. Access the Application:

   Open a web browser and navigate to:

    [http://localhost:3000](http://localhost:3000)

## Tests

Run the RSpec tests to ensure everything works as expected:

```bash
bundle exec rspec
```

This will generate a report detailing any potential vulnerabilities.


## Security Checks

To ensure your project is secure, run Brakeman:

```bash
brakeman
```

## Docker
This project is Dockerized for easy deployment and scaling.


1. Build Docker Image:

```bash
docker-compose build 
```

2. Run Docker Containers:

```bash
docker-compose up
```
3. Access the Application:

    Open a web browser and navigate to:

    [http://localhost:3000](http://localhost:3000)

The Dockerfile includes steps for installing Tailwind CSS, and the project builds it directly.

## Authors

👤 **Ahmed Adel**

- GitHub: [Ahmed](https://github.com/ahmedadel56)
- LinkedIn: [Ahmed Adel](https://www.linkedin.com/in/ahmed-adel56/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](./LICENSE) licensed.