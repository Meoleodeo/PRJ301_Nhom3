package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        if (username == null || password == null || email == null || role == null) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(0, username, password, email, role);
       

        boolean success = UserDAO.registerUser(newUser);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", newUser +String.valueOf(success)+ "Đăng ký thất bại, có thể username hoặc email đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}

