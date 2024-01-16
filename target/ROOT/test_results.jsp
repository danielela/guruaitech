<!DOCTYPE html>
<html lang="en">
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
            .text-bg-success{
                background-color: rgb(179, 208, 179);
            }
            .text-bg-danger{
                background-color: rgb(228, 117, 117);
            }

            .table-text-color{
                color: green;
            }
            </style>
    </head>
    <body class="sb-nav-fixed">

        <script>
            $(document).ready(function(){
                console.log("hello");
               $.ajax({
                type: "GET",
                url: "TestResultServlet",
                success: function(response) {
                    $("#result_table").append(response);
                },
                error: function (xhr, status, error) {
                    console.log("error in ajax call " + error + " stutus " + status);
                }
    
               }); 
            });
          function loadTestAttempts(attemptID){
            $("#result_table").hide();
              $.ajax({
                    type: "Post",
                    url: "ShowTestAnswerServlet",
                    dataType: "json",
                    data:{

                        attemptID:attemptID
                    },
                    success: function(response) {
                        console.log(response);
                
                        for (let i = 0; i < response.length; i++) {
                            const question = response[i];
                            loadTestAnswer(i+1, question.question, question.options, question.correctAnswer, question.answer_selected);
                        }
                        //loadTestAnswer(1, "What is your name", ["A", "B", "C", "D"], "A");  
                        //loadTestAnswer(response.questionNumber, response.questionText, response.answerOptions, response.correctAnswer);

                        //$("#answer_table").append(response);
                    },
                    error: function (xhr, status, error) {
                        console.log("error in ajax call " + error + " stutus " + status);
                    }
                });

          }

            function loadTestAnswer(questionNumber, questionText, answerOptions, correctAnswer, selectedAnswer) {
                // Create main div
                let questionDiv = document.createElement('div');
                
                // Create question header
                let questionHeader = document.createElement('h3');
                questionHeader.textContent = `Question ${questionNumber}`;
                questionDiv.appendChild(questionHeader);
            
                // Create question text
                let preTag = document.createElement('pre');
                preTag.textContent = questionText;
                questionDiv.appendChild(preTag);
                 correctAnswer = "["+correctAnswer+"]";
                var correctAnswerArray = JSON.parse(correctAnswer);
                var selectedAnswerArray = JSON.parse(selectedAnswer);
                
                console.log("correctAnswer ="+correctAnswerArray+" \n selectedAnswer = "+selectedAnswerArray);

                // Create answer options list
                let answerList = document.createElement('ul');
                answerList.className = 'answer-options';
                var listItemArray = [];
                
                answerOptions.forEach((option, index) => {
                    var newIndex = index+1;
                    let listItem = document.createElement('li');
                    listItem.textContent = option;

                    // Check if the current option value is in both correct and selected answers
                    if (correctAnswerArray.includes(newIndex) && selectedAnswerArray.includes(newIndex)) {
                        listItem.className = 'text-bg-success'; // Green for correct and selected
                    } else if (selectedAnswerArray.includes(newIndex)) {
                        listItem.className = 'text-bg-danger'; // Red for selected but incorrect
                    }
                    listItemArray.push(listItem);
                    answerList.appendChild(listItem);
                });

                listItemArray.forEach((listItem, index) => {
                    var newIndex = index+1;
                    if (correctAnswerArray.includes(newIndex) && !selectedAnswerArray.includes(newIndex)) {
                        listItem.className = 'text-bg-warning';
                    }

                    if (selectedAnswerArray.includes(newIndex) && !correctAnswerArray.includes(newIndex)) {
                        listItem.className = 'text-bg-danger'; // Mark in red if selected but not correct
                    }
                });

                questionDiv.appendChild(answerList);

                // Create selected answer text
                let selectedAnswerParagraph = document.createElement('p');
                selectedAnswerParagraph.textContent = `Selected Answer: ${selectedAnswerArray}`;
                questionDiv.appendChild(selectedAnswerParagraph);
               
                // Create correct answer text
                let correctAnswerParagraph = document.createElement('p');
                correctAnswerParagraph.textContent = `Correct Answer: ${correctAnswerArray}`;
                questionDiv.appendChild(correctAnswerParagraph);

                // Append the created div to the body or any other container
                $("#answer_table").append(questionDiv)
            }

            function areArraysEqual(array1, array2) {
                // Check if the arrays have the same length
                if (array1.length !== array2.length) {
                    return false;
                }

                // Sort the arrays and compare each element
                if(array1.length == 1){
                    if(array1[0] == array2[0]){
                        return true;
                    }else{
                        return false;
                    }
                }else{
                    const sortedArray1 = array1.slice().sort();
                    const sortedArray2 = array2.slice().sort();

                    for (let i = 0; i < sortedArray1.length; i++) {
                        if (sortedArray1[i] !== sortedArray2[i]) {
                            return false;
                        }
                    }
                    return true;
                }

            }

            </script>

       <!--Session data-->
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="student_index.jsp">Guru Technology</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Change Password</a></li>
                        <li><hr class="dropdown-divider" /></li>
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
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Test
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="list_all_test.jsp">Attend Test</a>
                                    <a class="nav-link" href="test_results.jsp">Test Results</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                Your Courses
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Java
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="core_java.jsp">Core Java</a>
                                            <a class="nav-link" href="jee.jsp">JEE</a>
                                            <a class="nav-link" href="spring.jsp">Spring Framework</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                        Python
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
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
                        <h1 class="mt-4">Test Results</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="student_index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">Test Results</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                <p class="mb-0">
                                    This page is an example of using static navigation. By removing the
                                    <code>.sb-nav-fixed</cod`e>
                                    class from the
                                    <code>body</code>
                                    , the top navigation and side navigation will become static on scroll. Scroll down this page to see an example.
                                </p>

                                <div class="card-body" id="test_table" >
                                    
                                </div>
                            </div>
                        </div>
                        
                        <div class="table-bordered " style="text-decoration-color: rgb(164, 33, 33); background-color: rgb(234, 222, 218); width: 100%" id="result_table"></div><br><br> 
                        <h2 class="table-text-color" >Test Results</h2>
                        <div class="table-bordered rounded-lg border-4 border-success" style="text-decoration-color: rgb(164, 33, 33); width: 100%" id="answer_table">
                            
                        </div>
                        

                        

                        <div style="height: 100vh"></div>
                        <div class="card mb-4"><div class="card-body">When scrolling, the navigation stays at the top of the page. This is the end of the static navigation demo.</div></div>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>
