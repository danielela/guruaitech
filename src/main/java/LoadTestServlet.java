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

@WebServlet("/loadTestServlet")
public class LoadTestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        Connection connection = DBConnection.getConnection();

        Test test = new Test();
        String test_id = request.getParameter("test_id");
        System.out.println("Test Id =" + test_id);
        try {
            PreparedStatement statement = connection
                    .prepareStatement("SELECT * FROM onlinetest.Test where test_id = " + test_id);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                test.setTest_id(rs.getString(1));
                test.setTest_name(rs.getString(2));
                test.setTest_duration(rs.getString(3));
                test.setStart_time(rs.getString(4));
                test.setEnd_time(rs.getString(5));
                test.setTest_description(rs.getString(6));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        ObjectMapper mapper = new ObjectMapper();
        String responseJson = mapper.writeValueAsString(test);
        System.out.println("response json string =" + responseJson);
        out.println(responseJson);
    }

}
