package com.bookstore.data;

import com.bookstore.model.Book;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class BookRepository {

    private static final List<Book> BOOKS = new ArrayList<>();

    static {
        BOOKS.add(new Book(1, "Clean Code", "Robert C. Martin", 32.99));
        BOOKS.add(new Book(2, "Effective Java", "Joshua Bloch", 38.50));
        BOOKS.add(new Book(3, "Head First Java", "Kathy Sierra", 29.95));
        BOOKS.add(new Book(4, "Java Concurrency in Practice", "Brian Goetz", 41.00));
        BOOKS.add(new Book(5, "The Pragmatic Programmer", "Andrew Hunt", 35.25));
        BOOKS.add(new Book(6, "Design Patterns", "Erich Gamma", 44.80));
        BOOKS.add(new Book(7, "Refactoring", "Martin Fowler", 39.90));
        BOOKS.add(new Book(8, "Introduction to Algorithms", "Thomas H. Cormen", 59.99));
    }

    private BookRepository() {
    }

    public static List<Book> getAll() {
        return Collections.unmodifiableList(BOOKS);
    }

    public static Book findById(int id) {
        for (Book book : BOOKS) {
            if (book.getId() == id) {
                return book;
            }
        }
        return null;
    }
}
