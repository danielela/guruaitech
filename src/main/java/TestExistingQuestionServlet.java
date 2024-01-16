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

@WebServlet("/TestExistingQuestionServlet")
public class TestExistingQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String testID = req.getParameter("testID");
        System.out.println("Inside the TestExistingQuestionServlet the testId=  " + testID);
        PrintWriter out = resp.getWriter();

        // resp.setContentType("application/json");
        resp.setContentType("text/html");
        Connection connection = DBConnection.getConnection();
        StringBuilder resultTable = new StringBuilder();
        resultTable.append("<table class=\"table table-striped\" width='100%' >");
        resultTable.append(
                "<thead><tr><th>Question ID</th><th style='width: 30%;' >SubTopic Name</th><th>Question Text</th><th>Option A</th><th>Option B</th><th>Option C</th><th>Option D</th><th>Correct Option</th></tr></thead>");
        try {
            Statement stat = connection.createStatement();
            String existingQuestions = "select q.*,s.subtopic_name  from onlinetest.TestQuestions tq, onlinetest.Questions q, onlinetest.Subtopics s where tq.test_id = "
                    + testID + " and tq.question_id = q.question_id and q.subtopic_id=s.subtopic_id";
            // String query = "SELECT q.*, s.subtopic_name FROM
            // onlinetest.Questions q, onlinetest.Subtopics s where
            // s.topic_id="
            // + topic_id + " and q.subtopic_id=s.subtopic_id";
            ResultSet resultSet = stat.executeQuery(existingQuestions);
            System.out.println(
                    "******************************* \n TestExistingQuestionServlet Select Query existingQuestions="
                            + existingQuestions);
            System.out.println("**************************************************************** \n");
            while (resultSet.next()) {
                String question_id = resultSet.getString(1);
                resultTable.append("<tr><td>" + question_id
                        + "</td>"
                        + "<td>"
                        + resultSet.getString(12) + "</td>"
                        + "<td style='text-align: left;' ><pre> \n" + resultSet.getString(3)
                        + "</pre></td><td>" + resultSet.getString(4)
                        + "</td><td>" + resultSet.getString(5)
                        + "</td><td>" + resultSet.getString(6)
                        + "</td><td>" + resultSet.getString(7)
                        + "</td></tr>");
            }
            resultTable.append("</table>");
            System.out.println(resultTable);
            out.print(resultTable);
        } catch (Exception e) {
            System.err.println("Got an exception! " + e.getMessage());
            e.printStackTrace();
        }

    }

}
