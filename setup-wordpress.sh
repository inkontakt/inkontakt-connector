#!/bin/bash

echo "⏳ Waiting for WordPress to be ready..."
sleep 10

WORDPRESS_URL="http://localhost:8000"
WP_ADMIN_USER="admin"
WP_ADMIN_PASS="AdminPassword123!"
WP_ADMIN_EMAIL="admin@example.com"
WP_SITE_TITLE="Inkontakt"

echo "🔧 Setting up WordPress..."

# Run WordPress setup via WP-CLI inside the container
docker exec wordpress_app wp core install \
  --url="$WORDPRESS_URL" \
  --title="$WP_SITE_TITLE" \
  --admin_user="$WP_ADMIN_USER" \
  --admin_password="$WP_ADMIN_PASS" \
  --admin_email="$WP_ADMIN_EMAIL" \
  --skip-email \
  --allow-root

if [ $? -eq 0 ]; then
  echo "✅ WordPress installed successfully!"
  echo ""
  echo "📝 WordPress Admin Credentials:"
  echo "   URL: $WORDPRESS_URL/wp-admin"
  echo "   Username: $WP_ADMIN_USER"
  echo "   Password: $WP_ADMIN_PASS"
  echo ""
  echo "🔗 WordPress REST API:"
  echo "   $WORDPRESS_URL/wp-json/wp/v2"
  echo ""
  echo "✨ WordPress is ready! Your React app should now connect successfully."
else
  echo "⚠️  WordPress setup encountered an issue (may already be installed)"
  echo "Visit $WORDPRESS_URL to complete setup manually if needed"
fi
