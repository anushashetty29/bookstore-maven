<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bookstore®</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<!-- Cinematic Hero Section -->
<section class="hero-section">
  <h1 class="hero-title animate-fade-rise">
    Where <em>stories</em> rise <em>through the silence.</em>
  </h1>
  <p class="hero-subtext animate-fade-rise-delay">
    A curated sanctuary of timeless literature, software architecture, and foundational thought. Step away from the noise and discover books crafted for sharp minds and quiet focus.
  </p>
  <a href="#collection" class="hero-cta liquid-glass animate-fade-rise-delay-2">
    Explore Collection
  </a>
</section>

<!-- Main Bookstore Section -->
<main class="main-content" id="collection">
  <div class="section-header">
    <span class="section-tag">Library</span>
    <h2 class="section-title">The Curated Archive</h2>
    <p class="section-subtitle">Volumes selected for precision, architectural craftsmanship, and enduring value.</p>
  </div>

  <!-- Search and Live Filter Bar -->
  <div class="filter-bar">
    <div class="search-input-wrapper">
      <span class="search-icon">&#128269;</span>
      <input type="text" id="bookSearch" class="search-input" placeholder="Search by title, author, or discipline...">
    </div>
    <div class="archive-stats">
      Showing <span id="visibleCount">${empty books ? 0 : books.size()}</span> of ${empty books ? 0 : books.size()} volumes
    </div>
  </div>

  <c:if test="${empty books}">
    <div class="glass-card empty-state">
      <h3 class="empty-state-title">Archive is currently resting</h3>
      <p class="empty-state-text">No books currently indexed in this catalog.</p>
      <a class="btn-nav-journey liquid-glass" href="${pageContext.request.contextPath}/catalog">Refresh Catalog</a>
    </div>
  </c:if>

  <c:if test="${not empty books}">
    <div class="books-grid" id="booksGrid">
      <c:forEach var="b" items="${books}">
        <article class="glass-card book-card" data-title="${b.title.toLowerCase()}" data-author="${b.author.toLowerCase()}">
          <div class="book-art">
            <div class="book-art-top">
              <span>Vol. 0${b.id}</span>
              <span>Hardcover</span>
            </div>
            <div class="book-art-cover-title">${b.title}</div>
          </div>

          <div class="book-details">
            <h3 class="book-title">${b.title}</h3>
            <p class="book-author">By ${b.author}</p>

            <div class="book-footer">
              <span class="book-price">$<fmt:formatNumber value="${b.price}" pattern="0.00"/></span>
              <form method="post" action="${pageContext.request.contextPath}/cart">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="id" value="${b.id}">
                <button type="submit" class="btn-add-cart">
                  <span>Add to Cart</span>
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                  </svg>
                </button>
              </form>
            </div>
          </div>
        </article>
      </c:forEach>
    </div>
  </c:if>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>

<script>
  // Dynamic Scroll Blur & 20-30% Black Layer when scrolling down into the catalog
  function handleScroll() {
    if (window.scrollY > 80) {
      document.body.classList.add('scrolled');
    } else {
      document.body.classList.remove('scrolled');
    }
  }
  window.addEventListener('scroll', handleScroll, { passive: true });
  handleScroll();

  // Instant client-side search for the curated archive
  const searchInput = document.getElementById('bookSearch');
  const cards = document.querySelectorAll('.book-card');
  const visibleCount = document.getElementById('visibleCount');

  if (searchInput && cards) {
    searchInput.addEventListener('input', (e) => {
      const q = e.target.value.toLowerCase().trim();
      let matches = 0;
      cards.forEach(card => {
        const title = card.getAttribute('data-title') || '';
        const author = card.getAttribute('data-author') || '';
        if (title.includes(q) || author.includes(q)) {
          card.style.display = 'flex';
          matches++;
        } else {
          card.style.display = 'none';
        }
      });
      if (visibleCount) {
        visibleCount.textContent = matches;
      }
    });
  }
</script>
</body>
</html>
