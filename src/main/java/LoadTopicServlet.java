import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoadTopicServlet")
public class LoadTopicServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        Connection connection = DBConnection.getConnection();

        Topic topic = new Topic();
        String topic_id = request.getParameter("topic_id");
        System.out.println("TopicId =" + topic_id);
        try {
            PreparedStatement statement = connection
                    .prepareStatement("SELECT * FROM onlinetest.Topics where topic_id = " + topic_id);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                topic.setTopic_id(rs.getString(1));
                topic.setTopic_name(rs.getString(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        ObjectMapper mapper = new ObjectMapper();
        String responseJson = mapper.writeValueAsString(topic);
        System.out.println("response json string =" + responseJson);
        out.println(responseJson);
    }

}
