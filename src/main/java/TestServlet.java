import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("inside the examservlet");
        String test_id = request.getParameter("test_id");
        String test_name = request.getParameter("test_name");
        String test_duration = request.getParameter("test_duration");
        String start_time = request.getParameter("start_date");
        String end_time = request.getParameter("end_date");
        String test_description = request.getParameter("test_discription");

        System.out.println("Start Time=" + start_time);
        Timestamp timestamp = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date parsedDate = (Date) dateFormat.parse(start_time);
            timestamp = new Timestamp(parsedDate.getTime());
            System.out.println("Converted Timestamp: " + timestamp);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        System.out.println("Test ID=" + test_id + "\nTest Name=" + test_name + "\nTest Duration=" + test_duration
                + "\nStartTime=" + start_time + "\nEndTime=" + end_time + "\nTest Discription=" + test_description);
        try {
            // Class.forName("com.mysql.cj.jdbc.Driver");
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();

        }
        try (Connection Connection = DriverManager.getConnection(
                "jdbc:mysql://167.86.101.123:3306/onlinetest", "noroot", "W3lc0m32024");) {
            String insert_Query = "INSERT INTO `onlinetest`.`Test` ( `test_name`, `test_duration`, `start_time`, `end_time`, `test_description`) VALUES (?,?,?,?,?)";
            try (PreparedStatement preparedStatement = Connection.prepareStatement(insert_Query)) {
                // preparedStatement.setString(1, test_id);
                preparedStatement.setString(1, test_name);
                preparedStatement.setString(2, test_duration);
                preparedStatement.setTimestamp(3, timestamp);
                preparedStatement.setString(4, end_time);
                preparedStatement.setString(5, test_description);

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Successfuly inserted Test");
                    response.getWriter().write("Test data added successfuly");
                } else {
                    System.out.println("failed Test inserted");
                    response.getWriter().write("Failed to add Test data");
                }
                preparedStatement.close();
                Connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error:" + e.getMessage());
        }
        RequestDispatcher dispatcher = null;
        dispatcher = request.getRequestDispatcher("create_test.jsp");
        dispatcher.forward(request, response);
    }

}
