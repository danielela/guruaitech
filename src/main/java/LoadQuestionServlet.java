import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loadQuestionServlet")
public class LoadQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        Connection connection = DBConnection.getConnection();

        Question question = new Question();
        String question_id = request.getParameter("question_id");
        System.out.println("questionId=" + question_id);
        try {
            PreparedStatement statement = connection
                    .prepareStatement("SELECT * FROM onlinetest.Questions where question_id = " + question_id);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                question.setQuestion_id(resultSet.getString(1));
                question.setTopc_id(resultSet.getString(2));
                question.setQuestion_text(resultSet.getString(3));
                question.setOption_a(resultSet.getString(4));
                question.setOption_b(resultSet.getString(5));
                question.setOption_c(resultSet.getString(6));
                question.setOption_d(resultSet.getString(7));
                question.setCorrect_option(resultSet.getString(8));
                question.setExplaination(resultSet.getString(9));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        ObjectMapper mapper = new ObjectMapper();
        String responseJson = mapper.writeValueAsString(question);
        System.out.println("response json string =" + responseJson);
        out.println(responseJson);
    }

}
