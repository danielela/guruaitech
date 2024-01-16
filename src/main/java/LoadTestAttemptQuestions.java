import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loadTestAttemptQuestions")
public class LoadTestAttemptQuestions extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // true new session create false get existing session
        HttpSession session = req.getSession(false);
        PrintWriter out = resp.getWriter();
        if (session != null) {
            Test testObj = (Test) session.getAttribute("test");
            List<String> questionList = testObj.getTest_questions(); // [1,2,3,4]
            String formatArrayList = formatArrayList(questionList);
            System.out.println("list of question for test " + formatArrayList);
            resp.setContentType("application/json");
            List<QuizQuestion> quizeQuestionList = new ArrayList<>();
            try {
                Connection connection = DBConnection.getConnection();

                String sqlQuery = "SELECT * FROM onlinetest.Questions where question_id in "
                        + formatArrayList;
                System.out.println("sql query = " + sqlQuery);
                PreparedStatement statement = connection.prepareStatement(sqlQuery);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    QuizQuestion quizeQuestion = new QuizQuestion();
                    String questionfromDB = resultSet.getString(3);
                    System.out.println("question from DB " + questionfromDB);
                    quizeQuestion.setQuestion(resultSet.getString(3));
                    List<String> options = new ArrayList<>();
                    options.add(resultSet.getString(4));
                    options.add(resultSet.getString(5));
                    options.add(resultSet.getString(6));
                    options.add(resultSet.getString(7));
                    quizeQuestion.setOptions(options);

                    String correctAnwer = resultSet.getString(8);
                    System.out.println("correct Answer " + correctAnwer);
                    quizeQuestion.setCorrectAnswer(correctAnwer);
                    quizeQuestionList.add(quizeQuestion);

                }

            } catch (Exception e) {
                e.printStackTrace();
                System.err.println("exception while creating DBConnection =" + e.getMessage());
            }
            ObjectMapper mapper = new ObjectMapper();
            String responseJson = mapper.writeValueAsString(quizeQuestionList);
            System.out.println("the response questionData JSON =" + responseJson);
            out.println(responseJson);
        }
    }

    private static String formatArrayList(List<String> arrayList) {
        StringBuilder stringBuilder = new StringBuilder("(");

        for (int i = 0; i < arrayList.size(); i++) {
            stringBuilder.append("\"").append(arrayList.get(i)).append("\"");

            // Add a comma after each element, except for the last one
            if (i < arrayList.size() - 1) {
                stringBuilder.append(", ");
            }
        }

        stringBuilder.append(")");

        return stringBuilder.toString();
    }

}
