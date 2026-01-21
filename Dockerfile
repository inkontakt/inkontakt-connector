FROM wordpress:php8.3-apache

# Install curl and necessary tools for WP-CLI
RUN apt-get update && apt-get install -y curl less && rm -rf /var/lib/apt/lists/*

# Download and install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy our custom entrypoint that runs after the official one
COPY docker-entrypoint.sh /usr/local/bin/custom-entrypoint.sh
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

CMD ["/usr/local/bin/custom-entrypoint.sh"]
