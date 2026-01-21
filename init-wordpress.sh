#!/bin/bash
# WordPress initialization script

set -e

echo "Waiting for WordPress files to be ready..."
until [ -f /var/www/html/wp-config.php ]; do
  sleep 1
done

echo "Checking WordPress installation..."
if ! wp core is-installed --allow-root 2>/dev/null; then
  echo "Installing WordPress..."
  
  wp core install \
    --url="http://localhost:8000" \
    --title="Inkontakt" \
    --admin_user="admin" \
    --admin_password="AdminPassword123!" \
    --admin_email="admin@example.com" \
    --skip-email \
    --allow-root
  
  echo "WordPress installed successfully!"
  
  # Create a sample post
  echo "Creating sample post..."
  wp post create \
    --post_type="post" \
    --post_title="Welcome to Inkontakt" \
    --post_content="This is a sample post created by the React + WordPress setup. You can edit or delete it." \
    --post_status="publish" \
    --post_author="1" \
    --allow-root
    
  echo "✓ WordPress setup complete!"
  echo "  Admin: admin / AdminPassword123!"
else
  echo "✓ WordPress is already installed."
fi

