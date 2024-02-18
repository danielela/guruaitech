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

@WebServlet("/UpdateSubTopicServlet")
public class UpdateSubTopicServlet extends HttpServlet {

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    System.out.println("Inside the UpdateSubTopicServlet ");
    String add_sub_topic = request.getParameter("addsubtopic");
    String update_sub_topic = request.getParameter("updatesubtopic");
    System.out.println("Add SubTopic =" + add_sub_topic + "Update SubTopic =" + update_sub_topic);

    if (add_sub_topic != null) {
      System.out.println("Add SubTopic");
      System.out.println("Inside the SubTopic Servlet");
      String sub_topic_id = request.getParameter("subtopic_id");
      String topic_id = request.getParameter("topic_id");
      String sub_topic_name = request.getParameter("subtopic_name");
      System.out
          .println(" SubTopic Id=" + sub_topic_id + "\n Topic ID=" + topic_id + "\n SubTopic Name=" + sub_topic_name);
      try {
        Connection con = DBConnection.getConnection();
        String insert_query = "INSERT INTO `onlinetest`.`Subtopics` ( `topic_id`, `subtopic_name`) VALUES (?,?)";
        try (PreparedStatement preparedStatement = con.prepareStatement(insert_query)) {
          // preparedStatement.setString(1, sub_topic_id);
          preparedStatement.setString(1, topic_id);
          preparedStatement.setString(2, sub_topic_name);
          int rowsAffected = preparedStatement.executeUpdate();
          if (rowsAffected > 0) {
            System.out.println("Sucessful Added");
            response.getWriter().write("SubTopic data added successful");

          } else {
            System.out.println("Failed login");
            response.getWriter().write("Failed to add SubTopic data");
          }
          preparedStatement.close();
          con.close();
        }
      } catch (SQLException e) {
        e.printStackTrace();
        response.getWriter().write("Database error : " + e.getMessage());
      }
      RequestDispatcher dispatcher = null;
      dispatcher = request.getRequestDispatcher("edit_subtopic.jsp");
      dispatcher.forward(request, response);

    } else if (update_sub_topic != null) {
      System.out.println("Update SubTopic");
      String subtopic_id = request.getParameter("subtopic_id");
      String topic_id = request.getParameter("topic_id");
      String subtopic_name = request.getParameter("subtopic_name");

      System.out.println("SubTopic ID=" + subtopic_id + "\n Topic ID=" + topic_id + "\nSubTopic Name=" + subtopic_name);
      try {

        Class.forName("com.mysql.cj.jdbc.Driver");

      } catch (ClassNotFoundException e) {
        e.printStackTrace();

      }
      try (Connection Connection = DriverManager.getConnection(
          "jdbc:mysql://167.86.101.123:3306/onlinetest", "noroot", "W3lc0m32024");) {
        String update_Query = "update onlinetest.Subtopics set subtopic_id='" + subtopic_id + "', topic_id='" + topic_id
            + "', subtopic_name='" + subtopic_name + "' where subtopic_id=" + subtopic_id;
        System.out.println("Update   " + update_Query);
        try (PreparedStatement preparedStatement = Connection.prepareStatement(update_Query)) {

          int rowsAffected = preparedStatement.executeUpdate();
          if (rowsAffected > 0) {
            System.out.println("Successfuly Updated SubTopic");
            response.getWriter().write("Edit SubTopic data Updated successfuly");
          } else {
            System.out.println("failed SubTopic Updated");
            response.getWriter().write("Failed to Update edit Subtopic data");
          }
          preparedStatement.close();
          Connection.close();
        }
      } catch (SQLException e) {
        e.printStackTrace();
        response.getWriter().write("Database error:" + e.getMessage());
      }
      RequestDispatcher dispatcher = null;
      dispatcher = request.getRequestDispatcher("edit_subtopic.jsp");
      dispatcher.forward(request, response);

    }
  }

}
