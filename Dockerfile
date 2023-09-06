# Use the official Ruby image with your desired version
FROM ruby:2.7.4

# Set the working directory in the container
WORKDIR /myapp

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler:2.2.29
RUN bundle install --jobs 20 --retry 5

# Copy the rest of the application code to the container
COPY . .

# Expose port 3000 for the Rails application
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
