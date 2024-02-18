import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddTestQuestionServlet")
public class AddQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("Inside the AddTestQuestionServlet");
        String test_id = req.getParameter("test_id_value");
        String[] question_id = req.getParameterValues("selectedQuestions");
        System.out.println("Test Id=" + test_id + "\n Question ID=" + question_id.length);

        if (test_id != null && question_id != null) {
            Connection connection = null;
            try {
                connection = DBConnection.getConnection();

                // Assuming your tabledata table has columns test_id and question_id
                String insertQuery = "INSERT INTO `onlinetest`.`TestQuestions` (`test_id`, `question_id`) VALUES (?,?)";
                PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);

                for (String questionId : question_id) {
                    System.out.println("test Id=" + test_id + " Question ID=" + questionId);

                    preparedStatement.setString(1, test_id);
                    preparedStatement.setString(2, questionId);
                    preparedStatement.addBatch();
                }

                int[] result = preparedStatement.executeBatch();
                System.out.println("Result .=" + result.length);

                // Check the result array if you want to handle success or failure
                // (result[i] > 0 means the ith batch update was successful)
                resp.sendRedirect("test_question.jsp"); // Redirect to test_question.jsp

                // resp.getWriter().println("Questions added to the test successfully.");

            } catch (SQLException e) {
                e.printStackTrace();
                resp.getWriter().println("Error adding questions to the test.");
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
            resp.getWriter().println("Invalid parameters.");
        }
    }
}