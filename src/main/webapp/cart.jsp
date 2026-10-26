<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shopping Cart - Bookstore®</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="page-tinted">
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<main class="main-content" style="padding-top: 6rem;">
  <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
    <span class="section-tag">Cart</span>
    <h1 class="section-title">Your Selected Works</h1>
  </div>

  <c:choose>
    <c:when test="${empty items}">
      <div class="glass-card empty-state">
        <div style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.6;">&#128218;</div>
        <h2 class="empty-state-title">Your collection is empty</h2>
        <p class="empty-state-text">No volumes have been claimed yet. Discover architectural masterpieces in our catalog.</p>
        <a class="btn-nav-journey liquid-glass" href="${pageContext.request.contextPath}/catalog">Browse Catalog &rarr;</a>
      </div>
    </c:when>

    <c:otherwise>
      <div class="cart-layout">
        <!-- Items Table -->
        <div class="glass-card" style="padding: 1.5rem; overflow-x: auto;">
          <table class="cart-table">
            <thead>
              <tr>
                <th>Volume</th>
                <th>Price</th>
                <th>Qty</th>
                <th>Total</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="item" items="${items}">
                <tr>
                  <td>
                    <div class="cart-item-title">${item.book.title}</div>
                    <div style="font-size: 0.8rem; color: var(--muted-foreground);">By ${item.book.author}</div>
                  </td>
                  <td>$<fmt:formatNumber value="${item.book.price}" pattern="0.00"/></td>
                  <td>
                    <span style="font-weight: 600; padding: 0.25rem 0.6rem; border-radius: 6px; background: rgba(255,255,255,0.08);">
                      ${item.quantity}
                    </span>
                  </td>
                  <td>
                    <strong style="color: #fff;">$<fmt:formatNumber value="${item.total}" pattern="0.00"/></strong>
                  </td>
                  <td>
                    <a class="btn-remove" href="${pageContext.request.contextPath}/cart?action=remove&amp;id=${item.book.id}">
                      Remove
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- Summary Checkout Card -->
        <aside class="glass-card summary-card">
          <h2 class="summary-title">Acquisition Summary</h2>
          
          <div class="summary-row">
            <span>Subtotal</span>
            <span>$<fmt:formatNumber value="${total}" pattern="0.00"/></span>
          </div>
          
          <div class="summary-row">
            <span>Courier Dispatch</span>
            <span style="color: #2ed573;">Complimentary</span>
          </div>

          <div class="summary-row">
            <span>Edition Proofing</span>
            <span style="color: var(--muted-foreground);">Included</span>
          </div>

          <div class="summary-row total">
            <span>Total Payable</span>
            <span class="amount">$<fmt:formatNumber value="${total}" pattern="0.00"/></span>
          </div>

          <form method="post" action="${pageContext.request.contextPath}/order">
            <button type="submit" class="btn-checkout liquid-glass">
              Confirm &amp; Place Order &rarr;
            </button>
          </form>

          <a class="btn-continue" href="${pageContext.request.contextPath}/catalog">
            &larr; Add more volumes
          </a>
        </aside>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
