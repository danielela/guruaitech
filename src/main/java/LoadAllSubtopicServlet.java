
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loadAllSubtopicServlet")
public class LoadAllSubtopicServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Simulating data retrieval from a database based on the selected Main Topic
        String mainTopicId = request.getParameter("mainTopic");
        System.out.println("mainTopicId=" + mainTopicId);
        // You can use the mainTopicId to query the database and get subtopics
        List<Topic> subTopics = getSubtopicsForMainTopic(mainTopicId);

        // Convert the list to JSON and send it as the response
        String json = new Gson().toJson(subTopics);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }

    // Method to simulate fetching subtopics from the database
    private List<Topic> getSubtopicsForMainTopic(String mainTopicId) {
        // Simulating data retrieval from a database based on the selected Main Topic
        List<Topic> subTopics = new ArrayList<>();
        try {
            Connection connection = DBConnection.getConnection();
            Statement stat = connection.createStatement();
            ResultSet resultSet = stat
                    .executeQuery("SELECT * FROM onlinetest.Subtopics where topic_id = " + mainTopicId);
            while (resultSet.next()) {
                String subtopic_id = resultSet.getString(1);
                subTopics.add(new Topic(Integer.parseInt(subtopic_id), resultSet.getString(3)));
            }
        } catch (Exception e) {
            System.err.println("Got an exception! " + e.getMessage());
        }
        return subTopics;
    }

    // Class representing a Topic (you can create a separate file for this class)
    private static class Topic {
        private int id;
        private String name;

        public Topic(int id, String name) {
            this.id = id;
            this.name = name;
        }
    }
}