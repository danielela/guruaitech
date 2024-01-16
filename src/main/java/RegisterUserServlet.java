
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RegisterUserServlet")
public class RegisterUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Inside the RegisterUserServlet");
        response.setContentType("text/html");
        String firstname = request.getParameter("fname");
        String lastname = request.getParameter("lname");
        String username = request.getParameter("username");
        String password = request.getParameter("password1");
        String confirmpassword = request.getParameter("password2");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String dob = request.getParameter("dob");
        String errorMessage = "";

        System.out.println(
                "firstname = " + firstname + "\n lastname = " + lastname + "\n username = " + username
                        + "\n password = " + password + "\n confirmpassword = " + confirmpassword + "\n email = "
                        + email + " \nmobile = " + mobile + "\n dob = " + dob);

        if (password.length() < 5 || confirmpassword.length() < 5) {
            errorMessage = "Password should be more than 5 characters";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("registerUser.jsp").forward(request, response);
            return; // Stop further execution
        }

        if (!password.equals(confirmpassword)) {
            errorMessage = "Password and confirm password should be the same";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("registerUser.jsp").forward(request, response);
            return; // Stop further execution
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(
                    "jdbc:mysql://167.86.101.123:3306/onlinetest", "noroot",
                    "W3lc0m32024");) {
                String insert_query = "INSERT INTO `onlinetest`.`Users`(`first_name`, `last_name`, `username`, `password`, `email`, `phone`, `dob`, `user_type`) VALUES (?,?,?,?,?,?,?,?)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(insert_query)) {
                    preparedStatement.setString(1, firstname);
                    preparedStatement.setString(2, lastname);
                    preparedStatement.setString(3, username);
                    preparedStatement.setString(4, password);
                    preparedStatement.setString(5, email);
                    preparedStatement.setString(6, mobile);
                    preparedStatement.setString(7, dob);
                    preparedStatement.setString(8, "student");
                    int rowsAffected = preparedStatement.executeUpdate();

                    if (rowsAffected > 0) {
                        System.out.println("Successfully inserted login");
                        // Redirect to a success page or perform further actions
                        response.sendRedirect("login.jsp");
                    } else {
                        System.out.println("Failed to insert login");
                        // Handle failure to insert
                        errorMessage = "Failed to register user. Please try again.";
                        request.setAttribute("errorMessage", errorMessage);
                        request.getRequestDispatcher("registerUser.jsp").forward(request, response);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.getWriter().write("Database error: " + e.getMessage());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database connection error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            errorMessage = "Exception while login.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("registerUser.jsp").forward(request, response);
        }
    }
}
