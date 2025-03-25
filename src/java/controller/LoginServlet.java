package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String savePass = request.getParameter("savePass");
        User user = UserDAO.getUserByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // ✅ Manage Remember Me cookies
            Cookie cEmail = new Cookie("username", savePass != null ? username : "");
            Cookie cPass = new Cookie("password", savePass != null ? password : "");
            Cookie cSave = new Cookie("savePass", savePass != null ? "true" : "false");
            cEmail.setMaxAge(24 * 60 * 60);
            cPass.setMaxAge(24 * 60 * 60);
            cSave.setMaxAge(24 * 60 * 60);

            response.addCookie(cEmail);
            response.addCookie(cPass);
            response.addCookie(cSave);
            if ("buyer".equals(user.getRole())) {
                response.sendRedirect("home");
            } else {
                response.sendRedirect("dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
