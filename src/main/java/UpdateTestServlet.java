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

@WebServlet("/updateTestServlet")
public class UpdateTestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Inside the UpdateExamServlet ");
        String test_id = request.getParameter("test_id");
        String test_name = request.getParameter("test_name");
        String test_duration = request.getParameter("test_duration");
        String start_time = request.getParameter("start_date");
        String end_time = request.getParameter("end_date");
        String test_discription = request.getParameter("test_description");

        System.out.println("Test ID=" + test_id + "\nTest Name=" + test_name + "\nTest Duration=" + test_duration
                + "\nStart Time=" + start_time + "\nEnd Time=" + end_time + "\nTest Discription=" + test_discription);
        try {
            // Class.forName("com.mysql.cj.jdbc.Driver");
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();

        }
        try (Connection Connection = DriverManager.getConnection(
                "jdbc:mysql://167.86.101.123:3306/onlinetest", "noroot", "W3lc0m32024");) {
            // String insert_Query = "INSERT INTO `onlinetest`.`Exams` (`topic_id`,
            // `exam_name`, `exam_duration`, `start_time`,`end_time`) VALUES (?,?,?,?,?)";
            String update_Query = "update onlinetest.Test set test_id='" + test_id + "', test_name='" + test_name
                    + "', test_duration='" + test_duration + "',start_time='" + start_time + "',end_time='" + end_time
                    + "',test_description='" + test_discription + "' where test_id=" + test_id;
            System.out.println("Update Query=" + update_Query);

            try (PreparedStatement preparedStatement = Connection.prepareStatement(update_Query)) {
                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Successfuly Updated Test");
                    response.getWriter().write("Edit Test data added successfuly");
                } else {
                    System.out.println("failed Test inserted");
                    response.getWriter().write("Failed to Updated edit Test data");
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
