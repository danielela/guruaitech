import java.util.List;

public class Test {
    String test_id;
    String test_name;
    String test_duration;
    String start_time;
    String end_time;
    String test_description;
    List<String> test_questions;

    public List<String> getTest_questions() {
        return test_questions;
    }

    public void setTest_questions(List<String> test_questions) {
        this.test_questions = test_questions;
    }

    public String getTest_id() {
        return test_id;
    }

    public String getTest_name() {
        return test_name;
    }

    public String getTest_duration() {
        return test_duration;
    }

    public String getStart_time() {
        return start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public String getTest_description() {
        return test_description;
    }

    public void setTest_id(String test_id) {
        this.test_id = test_id;
    }

    public void setTest_name(String test_name) {
        this.test_name = test_name;
    }

    public void setTest_duration(String test_duration) {
        this.test_duration = test_duration;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public void setTest_description(String test_discription) {
        this.test_description = test_discription;
    }
}