# React + Vite with WordPress Headless CMS

This project combines React with Vite as the frontend and WordPress as a headless CMS backend.

## Project Structure

```
.
├── src/                    # React source files
├── public/                 # Static assets
├── docker-compose.yml      # WordPress + MySQL setup
├── vite.config.js         # Vite configuration
└── package.json           # Dependencies
```

## Getting Started

### 1. Install Frontend Dependencies

```bash
npm install
```

### 2. Start WordPress Backend

```bash
docker-compose up -d
```

WordPress will be available at `http://localhost:8000`
- Admin URL: `http://localhost:8000/wp-admin`
- Default credentials: Set on first login
- REST API: `http://localhost:8000/wp-json/wp/v2`

### 3. Start React Development Server

```bash
npm run dev
```

The React app will be available at `http://localhost:5173`

## WordPress Configuration

First time setup:
1. Visit `http://localhost:8000`
2. Follow the WordPress installation wizard
3. Create an admin account

### Enable CORS (for local development)

Add this to `wp-content/plugins/custom-cors-plugin.php` or use the REST API directly:

```php
add_filter('rest_pre_serve_request', function( $served, $result, $server, $request ) {
    header('Access-Control-Allow-Origin: *');
    return false;
}, 10, 4);
```

Or install a CORS plugin like "REST API - CORS" from WordPress.org.

## Fetching Data from WordPress

Example: Fetch posts from React:

```javascript
useEffect(() => {
  fetch('http://localhost:8000/wp-json/wp/v2/posts')
    .then(res => res.json())
    .then(data => console.log(data))
    .catch(err => console.error(err));
}, []);
```

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint

## Stop Services

```bash
docker-compose down
```

To also remove volumes (data):
```bash
docker-compose down -v
```

## Useful Links

- [WordPress REST API Docs](https://developer.wordpress.org/rest-api/)
- [Vite Documentation](https://vitejs.dev/)
- [React Documentation](https://react.dev/)

## Development Tips

- Hot Module Replacement (HMR) works out of the box with Vite
- WordPress REST API is available at `/wp-json/wp/v2/`
- You can fetch posts, pages, users, and custom post types
- Use environment variables for WordPress URL (see `.env.example`)
