<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Order Confirmation - Online Bookstore</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<c:choose>
  <c:when test="${empty orderItems}">
    <h2>No order found</h2>
    <p><a class="btn" href="${pageContext.request.contextPath}/catalog">Back to Catalog</a></p>
  </c:when>
  <c:otherwise>
    <h2>Thank you! Your order is confirmed.</h2>
    <p class="success">Order number: <strong>${orderNumber}</strong></p>
    <table>
      <thead>
        <tr><th>Title</th><th>Qty</th><th>Subtotal</th></tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${orderItems}">
          <tr>
            <td>${item.book.title}</td>
            <td>${item.quantity}</td>
            <td>$<fmt:formatNumber value="${item.total}" pattern="0.00"/></td>
          </tr>
        </c:forEach>
      </tbody>
      <tfoot>
        <tr><td colspan="2"><strong>Total paid</strong></td>
            <td><strong>$<fmt:formatNumber value="${orderTotal}" pattern="0.00"/></strong></td></tr>
      </tfoot>
    </table>
    <p><a class="btn" href="${pageContext.request.contextPath}/catalog">Continue Shopping</a></p>
  </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
