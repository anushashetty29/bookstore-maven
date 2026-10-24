<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Catalog - Online Bookstore</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<h2>Book Catalog</h2>
<c:if test="${empty books}">
  <p>No books to show. Please open the <a href="${pageContext.request.contextPath}/catalog">catalog</a>.</p>
</c:if>
<c:if test="${not empty books}">
  <table>
    <thead>
      <tr><th>ID</th><th>Title</th><th>Author</th><th>Price</th><th></th></tr>
    </thead>
    <tbody>
      <c:forEach var="b" items="${books}">
        <tr>
          <td>${b.id}</td>
          <td>${b.title}</td>
          <td>${b.author}</td>
          <td>$<fmt:formatNumber value="${b.price}" pattern="0.00"/></td>
          <td>
            <form method="post" action="${pageContext.request.contextPath}/cart">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="id" value="${b.id}">
              <button type="submit" class="btn">Add to Cart</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:if>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
