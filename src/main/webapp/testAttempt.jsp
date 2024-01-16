<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.*"%>

    <% 
        session=request.getSession(false); 
        String userName=null; 
        String userID = "";
        String test_name="" , test_duration="", test_id = "" ; 
        Map<String, String> testData= (HashMap)session.getAttribute("testObj");
        String test_questions = "";
        //Test test=null; 
        if (session==null) { 
            response.sendRedirect("login.jsp"); 
        }else{
            userName=(String)session.getAttribute("userName"); 
            userID = (String) session.getAttribute("userID");

            System.out.println("******username ******="+userName);
            test_name = (String) session.getAttribute("test_name"); 
            test_id = (String) session.getAttribute("test_id");
            test_duration=(String)session.getAttribute("test_duration"); 
            test_questions = testData.get("test_questions");

            System.out.println("test Question "+test_questions);
            

            //session.getAttribute("testData");
            //test=(Test)session.getAttribute("testData"); 
            System.out.println("the test Name in JSP page="+test_name+" ****test_duration****=="+test_duration);

        }
%>
<!DOCTYPE html>
<html lang=" en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <title>GuruTech</title>
            <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
            <link href="css/student/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <link href="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js" rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

            <style>
                
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
                text-decoration: none;
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

            <script>

                var quizData = [];

                var quizContainer = $("#questions-container");
                var countdownElement = $("#countdown");
                var questionInfoElement = $("#question-info");
                var prevBtn = $("#prevBtn");
                var nextBtn = $("#nextBtn");
                var submitBtn = $("#submitBtn");
                let countdownTimer;
                let currentQuestionIndex = 0;
                var duration = <%= test_duration %>;
                var testID = <%= test_id %>;
                var userID = <%= userID %>;
                var selectedAnswer = [];
                function startCountdown(duration) {
                    let timer = duration * 60;
                    //console.log(countdownElement);
                    countdownTimer = setInterval(function () {
                        const minutes = Math.floor(timer / 60);
                        const seconds = timer % 60;
                        var time = minutes + ":" + seconds;
                        
                        $("#countdown").html(time);
                        if (--timer < 0) {
                            clearInterval(countdownTimer);
                            alert("Time's up! Quiz submitted.");
                            submitQuiz();
                        }
                    }, 1000);
                }

                function loadQuestion(index) {
                    var quizContainer = $("#questions-container");

                    //post ajax call to load question
                    if( quizData.length == 0 ){
                        console.log("making AJAX call......");
                        $.ajax({
                            url: 'loadTestAttemptQuestions',
                            dataType: 'json',
                            method: 'POST',
                            async: false,
                            success: function(response) {
                                console.log("ajax question response *************** \n "+response);
                                console.log("old json data "+quizData);
                                var jsonStr = JSON.stringify(response);
                                console.log("new json data string ="+jsonStr);
                                var responseJson   = JSON.parse(jsonStr);
                                quizData = responseJson;
                                console.log("new json data "+quizData);
                            },
                            error: function(xhr, status, error) {
                                // Error handler
                                console.log(error);
                            }
                        });
                    }

                            const questionData = quizData[index];
                            console.log("loadQuestion questionData:", questionData);
                            var questionElement = $("<div>");
                            questionElement.addClass("question mb-3 p-3 square");
                            console.log("questionData.question = "+ questionData.question);
                            questionElement.html("<p> <pre> "+questionData.question+"</pre></p>");

                            var optionContainer = $("<div>");
                            optionContainer.addClass("option-container");

                            questionData.options.forEach((option, optionIndex) => {
                                const inputId = `q${index}_o${optionIndex}`;
                                var actualCorrectAnswers = questionData.correctAnswer;
                                console.log("inputId = "+inputId+ " actualCorrectAnswers "+actualCorrectAnswers);
                                    optionContainer.append(`
                                        <a href="#" class="custom-control ${actualCorrectAnswers.length > 1 ? 'custom-checkbox' : 'custom-radio'}" onclick="selectOption('${inputId}')">
                                            <input type="${actualCorrectAnswers.length > 1 ? 'checkbox' : 'radio'}" id="${inputId}" name="q${index}" class="custom-control-input" value="${(optionIndex + 1)}">
                                            <label class="custom-control-label" for="${inputId}">${option}</label>
                                        </a>
                                    `);
                                /*                               
                                optionContainer.append(`
                                    <a href="#" class="custom-control custom-radio" onclick="selectOption('${inputId}')">
                                        <input type="radio" id="${inputId}" name="q${index}" class="custom-control-input" value="${option}">
                                        <label class="custom-control-label" for="${inputId}">${option}</label>
                                    </a>
                                `);
                                */
                            });

                            questionElement.append(optionContainer);
                            quizContainer.html("");
                            quizContainer.append(questionElement);

                            updateQuestionInfo();
                            updateButtons();

                    
                }

                function selectOption(inputId) {
                    const radioButton = $("#" + inputId);
                    radioButton.prop("checked", true);
                }

                function updateQuestionInfo() {
                    $("#question-info").html(`Question ${currentQuestionIndex + 1} of ${quizData.length}`);
                    
                }

                function updateButtons() {
                    if (currentQuestionIndex === 0) {
                        $(nextBtn).show();
                        $(prevBtn).hide();
                        $(submitBtn).hide();
                    } else if (currentQuestionIndex === quizData.length - 1) {
                        $(nextBtn).hide();
                        $(prevBtn).show();
                        $(submitBtn).show();
                    } else {
                        
                        $(nextBtn).show();
                        $(prevBtn).show();
                        $(submitBtn).hide();

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
                    console.log("currentQuestionIndex = "+currentQuestionIndex);

                    const selectedOption = document.querySelectorAll(`input[name="q${currentQuestionIndex}"]:checked`);

                    selectedAnswer[currentQuestionIndex] = Array.from(selectedOption).map(checkbox => checkbox.value);

                    console.log("selectedOption ="+(selectedOption));

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

                function arraysHaveSameItems(array1, array2) {
                    // Check if both arrays have the same length
                    if (array1.length !== array2.length) {
                        return false;
                    }
                    // Check if every item in array1 is present in array2
                    const allItemsMatch = array1.every(item => array2.includes(item));

                    return allItemsMatch;
                }


                function checkAnswers() {
                    var userSelectedAnswerValue= [];
                    var countdownElement = $("#countdown");
                    let correctCount = 0;
                    quizData.forEach((question, index) => {
                        //document.querySelector(`input[name="q${index}"]:checked`);
                        const selectedOption = selectedAnswer[index];
                        userSelectedAnswerValue[index] = selectedOption;
                        const correctAnsArray = question.correctAnswer.split(',');
                        console.log("correctAnsArray = "+correctAnsArray);
                        if (selectedOption && arraysHaveSameItems(selectedOption, correctAnsArray)) {
                            correctCount++;
                        }
                    });

                    const percentage = (correctCount / quizData.length) * 100;
                    console.log("scrore percentage "+percentage);
                    timerText = countdownElement.text();
                    console.log("time to complete test ="+timerText)
                    const timeSpent = (duration * 60) - (timerText.split(":").reduce((acc, time) => acc * 60 + +time, 0));

                    $("#result-message").text(`You got ${correctCount} out of ${quizData.length} questions correct!`);
                    $("#percentage").text(`Percentage: ${percentage.toFixed(2)}%`);

                    $("#time-spent").text(`Time Spent: ${formatTime(timeSpent)}`);

                    $("#submitBtn").css("display", "block");
                    //$("#result-container").css("display", "none");

                    
                    console.log("userID ="+userID+" \n correctCount= "+correctCount+" \n percentage = "+percentage);
                    console.log("testID = "+testID+ " \n  userSelectedAnswerValue= "+userSelectedAnswerValue+" \n timeSpent = "+timeSpent);
                    //ajax call to save the result
                    //attemptID is generated by server
                    $.ajax({
                        type: "POST",
                        url: "saveTestResultServlet",
                        data: {
                            userID: userID,
                            testID: testID,
                            score: percentage,
                            correctCount: correctCount,
                            userSelectedAnswer: JSON.stringify(userSelectedAnswerValue), 
                            timeSpent: timeSpent
                        },
                        success: function (response) {
                            console.log("response = "+response);
                            var saveResult = response;
                            if(response == "saved success"){
                                $("#db-saved").text(response);
                               console.log("DB saved success "+response); 
                               
                            }else{
                                $("#db-saved").text(response);
                                console.log("DB saved Failed "+response); 
                            }
                            $("#result-container").css("display", "block");
                        },
                        error: function (xhr, status, error) {
                            console.log("error in ajax call " + error + " status " + status);
                        }
                    });

                }

                function tryAgain() {
                    currentQuestionIndex = 0;
                    loadQuestion(currentQuestionIndex);
                    startCountdown(duration);
                    $("#quiz-container").css("display", "block");
                    $("#result-container").css("display", "none");
                }

                function formatTime(seconds) {
                    const minutes = Math.floor(seconds / 60);
                    const remainingSeconds = seconds % 60;
                    return `${minutes}:${remainingSeconds < 10 ? "0" : ""
                        }${remainingSeconds}`;
                }

                $(document).ready(function () {
                    $("#test_attempt").hide();
                    // code to be executed when the DOM is ready
                    $.ajax({
                        type: "GET",
                        url: "getAllTestQuestionServlet",
                        success: function (response) {
                            $("#test_table").append(response);
                        },
                        error: function (xhr, status, error) {
                            console.log("error in ajax call " + error + " status " + status);
                        }
                    });
                });

                function loadTest(test_id) {
                    console.log(test_id);

                    $.post('loadTestAttemptQuestionServlet',
                        {
                            "test_id": test_id,
                        })
                        .done(function (response) {
                            console.log(response);
                            console.log(response.test_id);
                            var questions = response.test_questions;
                            console.log(response.test_questions);
                            console.log(JSON.stringify(response));
                            
                        });

                }

                function startTest() {
                    // Attempt ID:
                    //ajax call to get the attempt id



                    $("#test_confirmation").hide();
                    $("#test_attempt").show();
                    console.log("start test");
                    loadQuestion(currentQuestionIndex);
                    //var duration = <%= test_duration %>;
                    startCountdown(duration);

                }



            </script>
        </head>

        <body>
            <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
                <!-- Navbar Brand-->
                <a class="navbar-brand ps-3" href="student_index.jsp">Guru Technology</a>
                <!-- Sidebar Toggle-->
                <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                        class="fas fa-bars"></i></button>
                <!-- Navbar Search-->
                <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                    <div class="input-group">
                        <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..."
                            aria-describedby="btnNavbarSearch" />
                        <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i
                                class="fas fa-search"></i></button>
                    </div>
                </form>
                <!-- Navbar-->
                <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="#!">
                                    <%= userName %>
                                </a></li>
                            <li><a class="dropdown-item" href="#!">Change Password</a></li>
                            <li>
                                <hr class="dropdown-divider" />
                            </li>
                            <li><a class="dropdown-item" href="#!">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div id="layoutSidenav">
                <div id="layoutSidenav_nav">
                    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                        <div class="sb-sidenav-menu">
                            <div class="nav">
                                <div class="sb-sidenav-menu-heading">Core</div>
                                <a class="nav-link" href="student_index.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                    Test Dashboard
                                </a>
                                <div class="sb-sidenav-menu-heading">Interface</div>
                                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                    data-bs-target="#collapseLayouts" aria-expanded="false"
                                    aria-controls="collapseLayouts">
                                    <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                    Test
                                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                </a>
                                <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne"
                                    data-bs-parent="#sidenavAccordion">
                                    <nav class="sb-sidenav-menu-nested nav">
                                        <a class="nav-link" href="list_all_test.jsp">Attend Test</a>
                                        <a class="nav-link" href="test_results.jsp">Test Results</a>
                                    </nav>
                                </div>
                                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                    data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                    <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                    Your Courses
                                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                </a>
                                <div class="collapse" id="collapsePages" aria-labelledby="headingTwo"
                                    data-bs-parent="#sidenavAccordion">
                                    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                            data-bs-target="#pagesCollapseAuth" aria-expanded="false"
                                            aria-controls="pagesCollapseAuth">
                                            Java
                                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i>
                                            </div>
                                        </a>
                                        <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne"
                                            data-bs-parent="#sidenavAccordionPages">
                                            <nav class="sb-sidenav-menu-nested nav">
                                                <a class="nav-link" href="core_java.jsp">Core Java</a>
                                                <a class="nav-link" href="jee.jsp">JEE</a>
                                                <a class="nav-link" href="spring.jsp">Spring Framework</a>
                                            </nav>
                                        </div>
                                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                            data-bs-target="#pagesCollapseError" aria-expanded="false"
                                            aria-controls="pagesCollapseError">
                                            Python
                                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i>
                                            </div>
                                        </a>
                                        <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne"
                                            data-bs-parent="#sidenavAccordionPages">
                                            <nav class="sb-sidenav-menu-nested nav">
                                                <a class="nav-link" href="401.jsp">Python</a>
                                                <a class="nav-link" href="404.jsp">DJango</a>
                                                <a class="nav-link" href="500.jsp">Flask</a>
                                                <a class="nav-link" href="500.jsp">Machine Learning</a>
                                            </nav>
                                        </div>
                                    </nav>
                                </div>
                                <div class="sb-sidenav-menu-heading">Addons</div>
                                <a class="nav-link" href="charts.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                    Charts
                                </a>
                                <a class="nav-link" href="tables.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                    Tables
                                </a>
                            </div>
                        </div>
                        <div class="sb-sidenav-footer">
                            <div class="small">Logged in as:</div>
                            Start Bootstrap
                        </div>
                    </nav>
                </div>
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">Attend Test</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="student_index.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item active">Attend Test</li>
                            </ol>
                            <div class="card mb-4">
                                <div class="card mb-4" id="test_confirmation" >
                                    <div class="card-header">
                                        <i class="fas fa-table me-1"></i>
                                        Ready for the Test?
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                              <p class="mb-0" class="sb-nav-fixed">
                                                Your about to take a test on
                                              </p>
                                            </div>
                                            <div class="col">
                                              <div id="test_name">
                                                <%= test_name %>
                                              </div>
                                            </div>
                                          </div>
                                          <div class="row">
                                            <div class="col">
                                              Test duration
                                            </div>
                                            <div class="col">
                                              <%= test_duration %>
                                            </div>
                                          </div>
                                          <div class="row">
                                            <div class="col">
                                              Number of Question
                                            </div>
                                            <div class="col">
                                              <%= test_questions %>
                                            </div>
                                          </div>
                                          <div class="row">
                                            <div class="col text-end">
                                              <input type="button" class="btn btn-primary" value="Start Test" onclick="startTest()">
                                            </div>
                                          </div>
                                    </div>
                                    
                                </div>
                                <div class="card mb-4" id="test_attempt" >

                                    <div id="quiz-container" class="container mt-5">
                                        <h1 class="mb-4">Java Quiz</h1>

                                        <div id="question-info" class="mb-3"></div>

                                        <div id="countdown" class="mb-3"></div>

                                        <div id="questions-container"></div>

                                        <div class="btn-group">
                                            <button class="btn btn-outline-primary mx-3" onclick="previousQuestion()"
                                                id="prevBtn">
                                                Previous Question
                                            </button>
                                            <button class="btn btn-outline-primary mx-3" onclick="nextQuestion()"
                                                id="nextBtn">
                                                Next Question
                                            </button>
                                            <button class="btn btn-primary mt-2 mx-3" onclick="submitQuiz()"
                                                id="submitBtn" style="display: none">
                                                Submit Quiz
                                            </button>
                                        </div>
                                    </div>
                                    <div id="result-container" class="container mt-5" style="display: none">
                                        <h2 class="mb-4">Quiz Results</h2>
                                        <p id="result-message"></p>
                                        <p id="percentage"></p>
                                        <p id="time-spent"></p>
                                        <p id="db-saved"></p>
                                        <button class="btn btn-primary mr-3" onclick="checkAnswers()"
                                            id="checkAnswersBtn">
                                            Check Your Answers
                                        </button>
                                        <button class="btn btn-success" onclick="tryAgain()">Try Again</button>
                                    </div>

                                </div>
                            </div>
                            <div style="height: 100vh"></div>
                            <div class="card mb-4">
                                <div class="card-body">When scrolling, the navigation stays at the top of the page. This
                                    is the
                                    end of the static navigation demo.</div>
                            </div>
                        </div>
                    </main>
                    <footer class="py-4 bg-light mt-auto">
                        <div class="container-fluid px-4">
                            <div class="d-flex align-items-center justify-content-between small">
                                <div class="text-muted">Copyright &copy; Your Website 2023</div>
                                <div>
                                    <a href="#">Privacy Policy</a>
                                    &middot;
                                    <a href="#">Terms &amp; Conditions</a>
                                </div>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="js/scripts.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                crossorigin="anonymous"></script>
            <script src="assets/demo/chart-area-demo.js"></script>
            <script src="assets/demo/chart-bar-demo.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                crossorigin="anonymous"></script>
            <script src="js/datatables-simple-demo.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        </body>

        </html>