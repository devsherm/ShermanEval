FROM ruby:3.2.2

# Install OS dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client

# Install Yarn
RUN npm install -g yarn

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock /app/

# Install gems
RUN bundle install

# Copy the whole project
COPY . /app

# Install Tailwind CSS using Yarn
RUN yarn add tailwindcss@npm:@tailwindcss/postcss7-compat @tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9

# Attempt to run the Tailwind CSS Rails installer
RUN rails tailwindcss:install

# Attempt to precompile assets, including Tailwind CSS
RUN rails assets:precompile

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
