#!/bin/bash
set -e

# Source the original WordPress entrypoint
. docker-entrypoint.sh "$@" &

# Wait for WordPress files to be ready
echo "Waiting for WordPress setup..."
until [ -f /var/www/html/wp-config.php ]; do
  sleep 1
done

sleep 3

# Run WP-CLI setup
echo "Setting up WordPress..."
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
  
  echo "✓ WordPress installed!"
  
  # Create sample post
  echo "Creating sample post..."
  wp post create \
    --post_type="post" \
    --post_title="Welcome to Inkontakt" \
    --post_content="This is a sample post. You can edit or delete it." \
    --post_status="publish" \
    --post_author="1" \
    --allow-root
    
  echo "✓ Sample post created!"
else
  echo "✓ WordPress already installed"
fi

echo "✓ Setup complete!"

# Keep the container running
wait
