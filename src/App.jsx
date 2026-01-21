import { useState, useEffect } from 'react'
import './App.css'

function App() {
  const [posts, setPosts] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    fetchPosts()
  }, [])

  const fetchPosts = async () => {
    try {
      setLoading(true)
      const response = await fetch('/wp-json/wp/v2/posts')
      if (!response.ok) throw new Error('Failed to fetch posts')
      const data = await response.json()
      setPosts(data)
      setError(null)
    } catch (err) {
      setError(err.message)
      console.error('Error fetching posts:', err)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="container">
      <header>
        <h1>Inkontakt Connector</h1>
        <p>React + Vite + WordPress Headless CMS</p>
      </header>

      <main>
        <section className="status">
          <h2>WordPress Connection Status</h2>
          {loading && <p className="loading">Connecting to WordPress...</p>}
          {error && <p className="error">Error: {error}</p>}
          {!loading && !error && posts.length > 0 && (
            <p className="success">✓ Connected! Found {posts.length} posts</p>
          )}
          {!loading && !error && posts.length === 0 && (
            <p className="info">No posts found in WordPress</p>
          )}
        </section>

        {posts.length > 0 && (
          <section className="posts">
            <h2>Latest Posts from WordPress</h2>
            <div className="posts-grid">
              {posts.map((post) => (
                <article key={post.id} className="post-card">
                  <h3>{post.title.rendered}</h3>
                  <div
                    className="post-excerpt"
                    dangerouslySetInnerHTML={{
                      __html: post.excerpt.rendered
                    }}
                  />
                  <a href={post.link} target="_blank" rel="noopener noreferrer">
                    Read More →
                  </a>
                </article>
              ))}
            </div>
          </section>
        )}

        <section className="info-section">
          <h2>Getting Started</h2>
          <ol>
            <li>WordPress is running at <code>http://localhost:8000</code></li>
            <li>Access WordPress admin at <code>http://localhost:8000/wp-admin</code></li>
            <li>This React app fetches posts via WordPress REST API</li>
            <li>Edit files in <code>src/</code> to customise the frontend</li>
          </ol>
        </section>
      </main>

      <footer>
        <p>Built with React, Vite, and WordPress</p>
      </footer>
    </div>
  )
}

export default App
