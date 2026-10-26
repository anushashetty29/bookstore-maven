<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Confirmed - Bookstore®</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="page-tinted">
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<main class="main-content" style="padding-top: 6rem;">
  <c:choose>
    <c:when test="${empty orderItems}">
      <div class="glass-card empty-state" style="max-width: 500px; margin: 4rem auto;">
        <h2 class="empty-state-title">No Active Order</h2>
        <p class="empty-state-text">We couldn't locate an active order receipt in this session.</p>
        <a class="btn-nav-journey liquid-glass" href="${pageContext.request.contextPath}/catalog">Return to Catalog</a>
      </div>
    </c:when>

    <c:otherwise>
      <div class="glass-card order-card">
        <div class="order-icon-badge">&#10003;</div>
        <h1 class="order-title">Acquisition Confirmed</h1>
        <p style="color: var(--muted-foreground); font-size: 1.05rem; margin-bottom: 1.5rem;">
          Thank you for entrusting your library to Bookstore. Your order is registered in our archival logs.
        </p>

        <div class="order-pill">
          Archival Reference: <strong>${orderNumber}</strong>
        </div>

        <div style="text-align: left; margin: 2rem 0; background: rgba(0, 0, 0, 0.25); border-radius: 12px; padding: 1.25rem; border: 1px solid rgba(255,255,255,0.08);">
          <table class="cart-table">
            <thead>
              <tr>
                <th>Dispatched Title</th>
                <th>Qty</th>
                <th style="text-align: right;">Amount</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="item" items="${orderItems}">
                <tr>
                  <td>
                    <div style="font-family: var(--font-display); font-size: 1.15rem; color: #fff;">${item.book.title}</div>
                    <div style="font-size: 0.8rem; color: var(--muted-foreground);">${item.book.author}</div>
                  </td>
                  <td>${item.quantity}</td>
                  <td style="text-align: right; color: #fff;">
                    $<fmt:formatNumber value="${item.total}" pattern="0.00"/>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="2" style="padding-top: 1.25rem; font-size: 1.1rem; color: #fff; font-weight: 500;">
                  Total Settled
                </td>
                <td style="padding-top: 1.25rem; text-align: right; font-family: var(--font-display); font-size: 1.6rem; color: #fff;">
                  $<fmt:formatNumber value="${orderTotal}" pattern="0.00"/>
                </td>
              </tr>
            </tfoot>
          </table>
        </div>

        <a class="btn-nav-journey liquid-glass" style="padding: 1rem 2.5rem; font-size: 1rem;" href="${pageContext.request.contextPath}/catalog">
          Browse More Works &rarr;
        </a>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
