import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.google.gson.Gson;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TestQuestionServlet")
public class TestQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("Inside the TestQuestionServlet");
        String topic_id = req.getParameter("topic_id");
        String testID = req.getParameter("testID");
        System.out.println("topic_id=" + topic_id + " testID=" + testID);

        TestAndQuestion testAndQuestion = new TestAndQuestion();
        PrintWriter out = resp.getWriter();

        // resp.setContentType("application/json");
        resp.setContentType("text/html");
        Connection connection = DBConnection.getConnection();
        StringBuilder resultTable = new StringBuilder();
        resultTable.append("<table class=\"table table-striped\" width='100%' >");
        resultTable.append(
                "<thead><tr><th>Select</th><th>Question ID</th><th style='width: 30%;' >SubTopic ID</th><th>Question Text</th><th>Option A</th><th>Option B</th><th>Option C</th><th>Option D</th><th>Correct Option</th><th>Diffculty</th><th>Mark</th><th>Explaination</th><th>SubTopic Name</th></tr></thead>");
        try {
            Statement stat = connection.createStatement();

            String newQuery = "SELECT q.*, st.subtopic_name FROM onlinetest.Questions q, onlinetest.Subtopics st where st.topic_id = "
                    + topic_id
                    + " and st.subtopic_id = q.subtopic_id and q.question_id NOT IN (select tq.question_id from onlinetest.TestQuestions tq where tq.test_id = "
                    + testID + ")";

            // String newQuery = "SELECT q.*, s.subtopic_name FROM
            // onlinetest.Questions q, onlinetest.Subtopics s,
            // onlinetest.TestQuestions tq where s.topic_id="
            // + topic_id + " and q.subtopic_id=s.subtopic_id and tq.test_id=" + testID
            // + " and tq.question_id NOT IN (select tq.question_id from
            // onlinetest.TestQuestions tq where tq.test_id = "
            // + testID + ")";
            String query = "SELECT q.*, s.subtopic_name FROM onlinetest.Questions q, onlinetest.Subtopics s where s.topic_id="
                    + topic_id + " and q.subtopic_id=s.subtopic_id";
            ResultSet resultSet = stat.executeQuery(newQuery);
            System.out.println("***************\n TestQuestionServlet Select Query newQuery=" + newQuery);
            System.out.println("**************************************************************** \n");
            while (resultSet.next()) {
                String question_id = resultSet.getString(1);
                resultTable.append("<tr><td><input type=\"checkbox\" name=\"selectedQuestions\" value=\"" + question_id
                        + "\"></td>"
                        + "<td> <a href='#' onclick=\"loadTestQuestion(" + question_id + ")\">"
                        + question_id + "</a> </td><td>"
                        + resultSet.getString(2)
                        + "</td><td style='text-align: left;' ><pre> \n" + resultSet.getString(3)
                        + "</pre></td><td>" + resultSet.getString(4)
                        + "</td><td>" + resultSet.getString(5)
                        + "</td><td>" + resultSet.getString(6)
                        + "</td><td>" + resultSet.getString(7)
                        + "</td><td>" + resultSet.getString(8)
                        + "</td><td>" + resultSet.getString(9)
                        + "</td><td>" + resultSet.getString(10)
                        + "</td><td>" + resultSet.getString(11)
                        + "</td><td>" + resultSet.getString(12)
                        + "</td></tr>");

            }
            resultTable.append("</table>");
            // testAndQuestion.setQuestions(resultTable.toString());
            // String json = new Gson().toJson(testAndQuestion);
            System.out.println(resultTable);
            out.println(resultTable);
        } catch (SQLException e) {
            e.printStackTrace();

        }

    }
}
