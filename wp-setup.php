<?php
/**
 * WordPress Setup Script
 * This script initializes WordPress when accessed via CLI
 */

// Suppress all output
ob_start();

// Define WordPress paths
define('ABSPATH', '/var/www/html/');

// Load WordPress setup functions
require_once ABSPATH . 'wp-load.php';

// Check if WordPress is already installed
$site_url = get_option('siteurl');

if (!$site_url || $site_url === 'http://localhost') {
    // Need to install WordPress
    require_once ABSPATH . 'wp-admin/includes/upgrade.php';
    require_once ABSPATH . 'wp-admin/includes/user.php';
    
    // Perform WordPress installation
    wp_install(
        'Inkontakt',        // Blog title
        'admin',            // Blog admin user
        'admin@example.com', // Blog admin email
        true,               // Public
        '',                 // DEPRECATED
        'AdminPassword123!' // Blog admin password
    );
    
    ob_end_clean();
    echo "✓ WordPress installed successfully\n";
    echo "URL: http://localhost:8000\n";
    echo "Username: admin\n";
    echo "Password: AdminPassword123!\n";
} else {
    ob_end_clean();
    echo "✓ WordPress is already installed\n";
    echo "URL: " . $site_url . "\n";
}

// Ensure we have at least one post
$args = [
    'numberposts' => 1,
    'post_type'   => 'post',
    'post_status' => 'publish'
];
$posts = get_posts($args);

if (empty($posts)) {
    wp_insert_post([
        'post_title'   => 'Welcome to Inkontakt',
        'post_content' => 'This is a sample post created by the React + WordPress setup. You can edit or delete this post to get started!',
        'post_status'  => 'publish',
        'post_type'    => 'post',
        'post_author'  => 1
    ]);
    echo "Sample post created\n";
}

echo "\n✓ Setup complete! Refresh your browser.\n";
?>
