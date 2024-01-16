<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@page
import="java.util.HashMap"%> <%@page import="java.util.Map"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Multiple Choice Quiz</title>

    <!-- Bootstrap CSS -->
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    />

    <style>
      body {
        font-family: "Segoe UI", Arial, sans-serif;
        margin: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      #quiz-container {
        font-size: 24px;
        font-family: "Segoe UI", Arial, sans-serif;
        max-width: 600px;
        margin: 0 auto;
        position: relative;
      }

      .question {
        font-size: 18px;
        font-family: "Segoe UI", Arial, sans-serif;
        margin-bottom: 20px;
        color: #000000;
        border-radius: 10px;
        padding: 15px;
        display: block;
        width: 100%; /* Make the question container take full width */
        box-sizing: border-box; /* Include padding in the width */
      }

      .question:nth-child(even) {
        background-color: hsla(0, 0%, 40%, 0.8);
      }

      #countdown {
        font-size: 25px;
        color: black;
        position: absolute;
        top: 20px;
        right: 20px;
      }

      .btn {
        margin-top: 5px;
        padding: 5px;
        cursor: pointer;
      }

      .option-container {
        margin-bottom: 2px;
        width: 100%; /* Make the option container take full width */
        box-sizing: border-box; /* Include padding in the width */
      }

      .custom-control {
        background-color: #e7e9eb;
        color: #000000;
        border-radius: 2px;
        width: 100%;
        padding: 10px 10px 10px 50px;
        margin-bottom: 7px;
        display: block;
      }

      .custom-control:nth-child(even) {
        background-color: #e7e9eb;
      }

      .btn-primary {
        background-color: rgb(255, 27, 1);
        border-color: rgb(253, 10, 10);
      }

      .btn-danger {
        background-color: hsla(0, 100%, 50%, 1);
        border-color: hsla(0, 100%, 50%, 1);
      }
      .correct-answer {
        background-color: #8eff8e; /* Light green for correct answers */
      }

      .wrong-answer {
        background-color: #ff8e8e; /* Light red for wrong answers */
      }
    </style>
  </head>
  <body class="bg-lightgray">
    <% session = request.getSession(false); String userName = null; String
    test_name = "", test_duration = ""; //Test test = null; if (session == null)
    { response.sendRedirect("login.jsp"); }else{ userName =
    (String)session.getAttribute("userName"); System.out.println("******username
    ****** ="+userName); test_name = (String) session.getAttribute("test_name");
    test_duration = (String) session.getAttribute("test_duration");
    //session.getAttribute("testData"); Map testMap =
    (HashMap)session.getAttribute("testObj"); System.out.println("test Question
    "+testMap.get("test_questions")); System.out.println("the test Name in JSP
    page = "+test_name+" **** test_duration**** =="+test_duration); } %>

    <div id="quiz-container" class="container mt-5">
      <h1 class="mb-4">Java Quiz</h1>

      <div id="question-info" class="mb-3"></div>

      <div id="countdown" class="mb-3"></div>

      <div id="questions-container"></div>

      <div class="btn-group">
        <button
          class="btn btn-outline-primary mr-3"
          onclick="previousQuestion()"
          id="prevBtn"
        >
          Previous Question
        </button>
        <button
          class="btn btn-outline-primary"
          onclick="nextQuestion()"
          id="nextBtn"
        >
          Next Question
        </button>
        <button
          class="btn btn-primary mt-2 mr-3"
          onclick="submitQuiz()"
          id="submitBtn"
          style="display: none"
        >
          Submit Quiz
        </button>
      </div>
    </div>
    <div id="result-container" class="container mt-5" style="display: none">
      <h2 class="mb-4">Quiz Results</h2>
      <p id="result-message"></p>
      <p id="percentage"></p>
      <p id="time-spent"></p>
      <button
        class="btn btn-primary mr-3"
        onclick="checkAnswers()"
        id="checkAnswersBtn"
      >
        Check Your Answers
      </button>
      <button class="btn btn-success" onclick="tryAgain()">Try Again</button>
    </div>
    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
      const quizData = [
        {
          question:
            "Question 1: What is the main purpose of Java Virtual Machine (JVM)?",
          options: [
            "To provide an interpreter for Java bytecode",
            "To compile Java source code",
            "To manage memory in Java",
            "To execute Java applications",
          ],
          correctAnswer: "To execute Java applications",
        },
        {
          question:
            "Question 2: Which keyword is used for inheritance in Java?",
          options: ["extends", "inherit", "implements", "extension"],
          correctAnswer: "extends",
        },
        {
          question:
            'Question 3: What is the output of the following code?\n```java\npublic class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello, Java!");\n    }\n}\n```',
          options: ["Hello, World!", "Hello, Java!", "Java!", "No output"],
          correctAnswer: "Hello, Java!",
        },
        {
          question:
            "Question 4: Which of the following is NOT a primitive data type in Java?",
          options: ["int", "float", "char", "class"],
          correctAnswer: "class",
        },
        {
          question:
            "Question 5: What is the purpose of the 'finally' block in a try-catch-finally statement?",
          options: [
            "To define a block of code to be executed if an exception occurs",
            "To specify the exception type to catch",
            "To ensure a block of code is always executed, regardless of exception occurrence",
            "To indicate the end of the try-catch block",
          ],
          correctAnswer:
            "To ensure a block of code is always executed, regardless of exception occurrence",
        },
        {
          question:
            "Question 6: What is the default value of the data members of a class in Java?",
          options: ["0", "null", "undefined", "Depends on the data type"],
          correctAnswer: "Depends on the data type",
        },
        {
          question:
            "Question 7: Which method is called when an object is garbage collected in Java?",
          options: ["dispose()", "delete()", "finalize()", "clean()"],
          correctAnswer: "finalize()",
        },
        {
          question:
            "Question 8: What is the purpose of the 'super' keyword in Java?",
          options: [
            "To refer to the superclass or parent class",
            "To invoke a static method",
            "To declare a constant variable",
            "To access the current instance of the class",
          ],
          correctAnswer: "To refer to the superclass or parent class",
        },
        {
          question:
            "Question 9: What is the difference between '== 'and '.equals()' in Java?",
          options: [
            "They are the same",
            "'==' compares object references, '.equals()' compares object content",
            "'==' compares object content, '.equals()' compares object references",
            "There is no such method as '.equals()' in Java",
          ],
          correctAnswer:
            "'==' compares object references, '.equals()' compares object content",
        },
        {
          question:
            "Question 10: Which of the following statements is true about Java interfaces?",
          options: [
            "Interfaces can have method implementations",
            "A class can implement multiple interfaces",
            "Interfaces can extend classes",
            "An interface cannot have any methods",
          ],
          correctAnswer: "A class can implement multiple interfaces",
        },
        // Add more questions here...
      ];

      const quizContainer = document.getElementById("questions-container");
      const countdownElement = document.getElementById("countdown");
      const questionInfoElement = document.getElementById("question-info");
      const prevBtn = document.getElementById("prevBtn");
      const nextBtn = document.getElementById("nextBtn");
      const submitBtn = document.getElementById("submitBtn");
      let countdownTimer;
      let currentQuestionIndex = 0;

      function startCountdown(duration) {
        let timer = duration * 60;
        countdownTimer = setInterval(function () {
          const minutes = Math.floor(timer / 60);
          const seconds = timer % 60;

          countdownElement.textContent = `${minutes}:${seconds}`;

          if (--timer < 0) {
            clearInterval(countdownTimer);
            alert("Time's up! Quiz submitted.");
            submitQuiz();
          }
        }, 1000);
      }

      function loadQuestion(index) {
        const questionData = quizData[index];

        const questionElement = document.createElement("div");
        questionElement.classList.add("question", "mb-3", "p-3", "square");
        questionElement.innerHTML = `<p>${questionData.question}</p>`;

        const optionContainer = document.createElement("div");
        optionContainer.classList.add("option-container");

        questionData.options.forEach((option, optionIndex) => {
          const inputId = `q${index}_o${optionIndex}`;
          optionContainer.innerHTML += `
            <a href="#" class="custom-control custom-radio" onclick="selectOption('${inputId}')">
                <input type="radio" id="${inputId}" name="q${index}" class="custom-control-input" value="${option}">
                <label class="custom-control-label" for="${inputId}">${option}</label>
            </a>
        `;
        });

        questionElement.appendChild(optionContainer);

        quizContainer.innerHTML = "";
        quizContainer.appendChild(questionElement);

        updateQuestionInfo();
        updateButtons();
      }

      function selectOption(inputId) {
        const radioButton = document.getElementById(inputId);
        radioButton.checked = true;
      }

      function updateQuestionInfo() {
        questionInfoElement.textContent = `Question ${
          currentQuestionIndex + 1
        } of ${quizData.length}`;
      }

      function updateButtons() {
        if (currentQuestionIndex === 0) {
          // First question
          nextBtn.style.display = "block";
          prevBtn.style.display = "none";
          submitBtn.style.display = "none";
        } else if (currentQuestionIndex === quizData.length - 1) {
          // Last question
          nextBtn.style.display = "none";
          prevBtn.style.display = "block";
          submitBtn.style.display = "block";
        } else {
          // In between questions
          nextBtn.style.display = "block";
          prevBtn.style.display = "block";
          submitBtn.style.display = "none";
        }
      }

      function previousQuestion() {
        currentQuestionIndex--;

        if (currentQuestionIndex >= 0) {
          loadQuestion(currentQuestionIndex);
        }

        updateButtons();
      }
      function nextQuestion() {
        const selectedOption = document.querySelector(
          `input[name="q${currentQuestionIndex}"]:checked`
        );

        if (!selectedOption) {
          alert("Please select an option.");
          return;
        }

        currentQuestionIndex++;

        if (currentQuestionIndex < quizData.length) {
          loadQuestion(currentQuestionIndex);
        } else {
          alert("All questions completed.");
          submitQuiz();
        }
      }

      function submitQuiz() {
        clearInterval(countdownTimer);
        checkAnswers();
        // alert("Quiz submitted!");
      }

      window.onload = function () {
        loadQuestion(currentQuestionIndex);
        startCountdown(30);
      };

      function checkAnswers() {
        let correctCount = 0;
        quizData.forEach((question, index) => {
          const selectedOption = document.querySelector(
            `input[name="q${index}"]:checked`
          );
          if (
            selectedOption &&
            selectedOption.value === question.correctAnswer
          ) {
            correctCount++;
          }
        });

        const percentage = (correctCount / quizData.length) * 100;
        const timeSpent =
          30 * 60 -
          countdownElement.textContent
            .split(":")
            .reduce((acc, time) => acc * 60 + +time, 0);

        document.getElementById(
          "result-message"
        ).textContent = `You got ${correctCount} out of ${quizData.length} questions correct!`;
        document.getElementById(
          "percentage"
        ).textContent = `Percentage: ${percentage.toFixed(2)}%`;
        document.getElementById(
          "time-spent"
        ).textContent = `Time Spent: ${formatTime(timeSpent)}`;

        // Show "Submit Quiz" button, hide "Check Your Answers" button
        document.getElementById("submitBtn").style.display = "block";

        document.getElementById("quiz-container").style.display = "none";
        document.getElementById("result-container").style.display = "block";
      }

      function tryAgain() {
        currentQuestionIndex = 0;
        loadQuestion(currentQuestionIndex);
        startCountdown(30);
        document.getElementById("quiz-container").style.display = "block";
        document.getElementById("result-container").style.display = "none";
      }

      function formatTime(seconds) {
        const minutes = Math.floor(seconds / 60);
        const remainingSeconds = seconds % 60;
        return `${minutes}:${
          remainingSeconds < 10 ? "0" : ""
        }${remainingSeconds}`;
      }
    </script>
  </body>
</html>
