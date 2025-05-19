# Use Ruby 2.7.6 base image
FROM ruby:2.7.6

# Set environment variables
ENV RAILS_ENV=development \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

# Install OS dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  postgresql-client

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler:2.3.26

# Copy Gemfiles and install dependencies
COPY Gemfile* ./
RUN bundle install

# Copy the entire app
COPY . .

# Expose port 3000 for the Rails server
EXPOSE 3000

# Default command to run the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
