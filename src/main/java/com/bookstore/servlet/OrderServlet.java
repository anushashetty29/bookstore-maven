package com.bookstore.servlet;

import com.bookstore.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<Integer, CartItem> cart = CartServlet.getCart(request.getSession());

        if (cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<CartItem> orderedItems = new ArrayList<>(cart.values());
        double total = CartServlet.totalOf(cart);
        String orderNumber = "ORD-" + (System.currentTimeMillis() % 1000000);

        cart.clear();

        request.setAttribute("orderItems", orderedItems);
        request.setAttribute("orderTotal", total);
        request.setAttribute("orderNumber", orderNumber);
        request.getRequestDispatcher("/order.jsp").forward(request, response);
    }
}
