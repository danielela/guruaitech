import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ShowTestAnswerServlet")
public class ShowTestAnswerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Inside the ShowTestAnswerServlet");
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        String attemptId = request.getParameter("attemptID");
        System.out.println("Attempt ID: " + attemptId);
        Connection connection = DBConnection.getConnection();
        StringBuilder answersTable = new StringBuilder();
        answersTable.append("<table class=\"table table-striped\">");
        answersTable.append("<thead><tr><th>Question ID</th><th>Question</th><th>Selected Option</th></tr></thead>");

        try {

            Statement statement = connection.createStatement();
            String query = "SELECT q.*, ua.selected_option FROM onlinetest.UserAnswers ua, onlinetest.Questions q where ua.attempt_id="
                    + attemptId + " and ua.question_id=q.question_id";
            ResultSet resultSet = statement.executeQuery(query);

            List<Answer> answers = new ArrayList<Answer>();

            while (resultSet.next()) {
                Answer answer = new Answer();
                answer.setQuestion_id(resultSet.getString("question_id"));
                String questionTextDB = resultSet.getString("question_text");
                System.out.println("question from DB " + questionTextDB);
                answer.setQuestion(questionTextDB);
                answer.setAnswer_selected(resultSet.getString("selected_option"));

                List<String> options = new ArrayList<>();
                options.add(resultSet.getString("option_a"));
                options.add(resultSet.getString("option_b"));
                options.add(resultSet.getString("option_c"));
                options.add(resultSet.getString("option_d"));
                answer.setOptions(options);

                answer.setCorrectAnswer(resultSet.getString("correct_option"));
                answer.setExplaination(resultSet.getString("explaination"));
                answer.setAnswer_selected(resultSet.getString("selected_option"));
                answers.add(answer);

                answersTable.append("<tr><td>").append(resultSet.getString("question_id")).append("</td><td>")
                        .append(resultSet.getString("question_text")).append("</td><td>")
                        .append(resultSet.getString("selected_option")).append("</td></tr>");
            }

            answersTable.append("</table>");
            ObjectMapper mapper = new ObjectMapper();
            String responseJson = mapper.writeValueAsString(answers);
            System.out.println("the response questionData JSON =" + responseJson);
            out.println(responseJson);
            // out.print(answersTable);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
