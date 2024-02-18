import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    // create a doGet method
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Inside the Logout Servlet");
        response.setContentType("text/html");
        HttpSession session = request.getSession(false); // false will not create new session
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect("index.jsp");
    }
}
