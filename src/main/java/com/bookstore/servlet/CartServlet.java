package com.bookstore.servlet;

import com.bookstore.data.BookRepository;
import com.bookstore.model.Book;
import com.bookstore.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    static Map<Integer, CartItem> getCart(HttpSession session) {
        Object attr = session.getAttribute("cart");
        if (attr instanceof Map) {
            return (Map<Integer, CartItem>) attr;
        }
        Map<Integer, CartItem> cart = new LinkedHashMap<>();
        session.setAttribute("cart", cart);
        return cart;
    }

    static double totalOf(Map<Integer, CartItem> cart) {
        double total = 0;
        for (CartItem item : cart.values()) {
            total += item.getTotal();
        }
        return total;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<Integer, CartItem> cart = getCart(request.getSession());
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (action != null && idParam != null) {
            int id = -1;
            try {
                id = Integer.parseInt(idParam.trim());
            } catch (NumberFormatException e) {
                // ignore invalid id
            }

            if ("add".equals(action)) {
                Book book = BookRepository.findById(id);
                if (book != null) {
                    CartItem existing = cart.get(id);
                    if (existing == null) {
                        cart.put(id, new CartItem(book, 1));
                    } else {
                        existing.setQuantity(existing.getQuantity() + 1);
                    }
                }
            } else if ("remove".equals(action)) {
                cart.remove(id);
            }
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        request.setAttribute("items", cart.values());
        request.setAttribute("total", totalOf(cart));
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
