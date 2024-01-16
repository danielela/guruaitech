import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TestResultServlet")
public class TestResultServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Inside the TestResultServlet");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        // Get user ID from session
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");
        System.out.println("User ID: " + userId);
        Connection connection = DBConnection.getConnection();
        StringBuilder resultTable = new StringBuilder();
        resultTable.append("<table class=\"table table-striped\" >");
        resultTable.append(
                "<thead><tr><th>Attempt ID</th><th>User ID</th><th>Test ID</th><th>Attempt Start Time</th><th>Attempt End Time</th><th>Score</th></tr></thead>");

        try {
            Statement statement = connection.createStatement();
            // Use a prepared statement to avoid SQL injection
            String query = "SELECT * FROM onlinetest.TestAttempts WHERE user_id = " + userId;
            System.out.println("Query: " + query);
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                String attemptId = resultSet.getString(1);
                resultTable.append("<tr><td> <a href='javascript:void(0);' onclick=\"loadTestAttempts(" + attemptId
                        + ")\">"
                        + attemptId + "</a> </td> <td>" + resultSet.getString(2) + "</td><td>" + resultSet.getString(3)
                        + "</td><td>" + resultSet.getString(4) + "</td><td>" + resultSet.getString(5) + "</td><td>"
                        + resultSet.getString(6) + "</td></tr>");
            }

            resultTable.append("</table>");
            System.out.println(resultTable);
            out.print(resultTable);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
