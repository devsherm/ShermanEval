# Use the official Ruby image
FROM ruby:3.2.2

# Set up working directory inside the container
WORKDIR /app

# Install essential packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install npm globally to manage JavaScript packages
RUN apt-get install -y npm

# Install yarn globally
RUN npm install -g yarn

# Copy Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems specified in the Gemfile
RUN bundle install

# Copy the entire application code into the container
COPY . .

# Install Tailwind CSS and related dependencies via npm
RUN npm install tailwindcss autoprefixer postcss-cli

# Precompile assets and build Tailwind CSS stylesheets
RUN yarn build

# Prepare the database
RUN bundle exec rails db:create && bundle exec rails db:migrate

# Set up the command to run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
