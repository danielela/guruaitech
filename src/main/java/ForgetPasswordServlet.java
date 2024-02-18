import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ForgetPasswordServlet")
public class ForgetPasswordServlet extends HttpServlet {

    // add to doPost method and accept the username and password as parameters and
    // return a string
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Inside the ForgetPassword Servlet");
        response.setContentType("text/html");
        HttpSession session = request.getSession(true); // true create new session
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String errorMessage = "";
        try {
            if (email.length() < 3) {
                errorMessage = "email should be more than 3 characters.";
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else if (password.length() < 5) {
                errorMessage = "Password should be more than 5 characters.";
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Validate user from the database
                // make a database connection and insert the password into user table which
                // matches to the username column
                // DBConnection dbConnection = new DBConnection();
                Connection connection = DBConnection.getConnection();
                String query = "UPDATE Users SET password = ? WHERE email = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, password);
                preparedStatement.setString(2, email);
                int result = preparedStatement.executeUpdate();
                if (result > 0) {
                    System.out.println("Password updated successfully");
                    response.sendRedirect("login.jsp");
                } else {
                    System.out.println("Password update failed");
                    errorMessage = "Password update failed";
                    request.setAttribute("errorMessage", errorMessage);
                    request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
