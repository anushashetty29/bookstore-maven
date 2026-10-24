<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Cart - Online Bookstore</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<h2>Your Shopping Cart</h2>
<c:choose>
  <c:when test="${empty items}">
    <p>Your cart is empty.</p>
    <p><a class="btn" href="${pageContext.request.contextPath}/catalog">Browse Catalog</a></p>
  </c:when>
  <c:otherwise>
    <table>
      <thead>
        <tr><th>Title</th><th>Price</th><th>Qty</th><th>Subtotal</th><th></th></tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${items}">
          <tr>
            <td>${item.book.title}</td>
            <td>$<fmt:formatNumber value="${item.book.price}" pattern="0.00"/></td>
            <td>${item.quantity}</td>
            <td>$<fmt:formatNumber value="${item.total}" pattern="0.00"/></td>
            <td><a class="btn btn-danger" href="${pageContext.request.contextPath}/cart?action=remove&amp;id=${item.book.id}">Remove</a></td>
          </tr>
        </c:forEach>
      </tbody>
      <tfoot>
        <tr><td colspan="3"><strong>Total</strong></td>
            <td colspan="2"><strong>$<fmt:formatNumber value="${total}" pattern="0.00"/></strong></td></tr>
      </tfoot>
    </table>
    <form method="post" action="${pageContext.request.contextPath}/order">
      <button type="submit" class="btn">Checkout</button>
      <a class="btn btn-secondary" href="${pageContext.request.contextPath}/catalog">Continue Shopping</a>
    </form>
  </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
