<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Test Question</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Saira:wght@500;600;700&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">



    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <link href="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</head>

<body>
    <script>
        $(document).ready(function () {
            $.ajax({
                type: "GET",
                url: "getAllTestServlet",
                success: function (response) {
                    
                    $("#test_table").html(response);
                },
                error: function (xhr, status, error) {
                    console.log("error in ajax call " + error + " status " + status);
                }
            });

            $('#mainTopic').change(function(){
                console.log($(this).val());
                if($(this).val() != null && $(this).val() != '' && $(this).val() != 999)
                    getQuestionForTopic($(this).val());

            });

        });

        function getQuestionForTopic(topic_id) {
            console.log(topic_id);
            var test_id = $("#test_id_value").val();
            console.log( "test_id ="+test_id);
            $.ajax({
                type: "GET",
                //dataType: "json",
                data: {
                    "topic_id": topic_id,
                    "testID": $("#test_id_value").val(),
                },
                
                url: "TestQuestionServlet",
                success: function (response) {

                    //var questions = JSON.parse(response).questions;
                    //     console.log(questions);
                    $("#test_question_table").html(response);
                    //$("#existing_test_table").html(questions);
                    $("#collapseTwo").removeClass("show");

                    // Add the 'show' class to $("#collapseTwo")
                    $("#collapseThree").addClass("show");
                    $("#collapseFour").addClass("show");

                    $("#headingTwo").children("button").removeClass("bg-success");
                    $("#headingTwo").children("button").addClass("bg-danger");
                    $("#headingThree").children("button").removeClass("bg-success");
                    $("#headingFour").children("button").addClass("bg-success");

                    document.getElementById("collapseFour").scrollIntoView();
                    getExistingQuestion(test_id);
                },
                error: function (xhr, status, error) {
                    console.log("error in ajax call " + error + " status " + status);
                }
            });
        }

        function getExistingQuestion(testID){
            $.ajax({
                type: "POST",
                //dataType: "json",
                data: {
                    "testID": testID,
                },
                
                url: "TestExistingQuestionServlet",
                success: function (response) {
                    $("#existing_test_table").html(response);
                    
                },
                error: function (xhr, status, error) {
                    console.log("error in ajax call " + error + " status " + status);
                }
            });
        }

        function loadTest(test_id) {
            console.log(test_id);

            $.post('loadTestServlet',
                {
                    "test_id": test_id,
                })
                .done(function (response) {
                    console.log(response);
                    console.log(response.test_id);
                    console.log(JSON.stringify(response));
                    $("#test_id").html(response.test_id);
                    $("#test_id_value").val(response.test_id);
                    $("#test_name").html(response.test_name);
                    $("#test_name_value").val(response.test_name);
                    $("#test_duration").html(response.test_duration);
                    // Remove the 'show' class from id="collapseOne"
                    $("#collapseOne").removeClass("show");
                    $("#headingOne").children("button").removeClass("bg-success");
                    $("#headingOne").children("button").addClass("bg-danger");
                    // Add the 'show' class to $("#collapseTwo")
                    $("#collapseTwo").addClass("show");
                    $("#headingTwo").children("button").removeClass("bg-danger");
                    $("#headingTwo").children("button").addClass("bg-success");
                    document.getElementById("collapseTwo").scrollIntoView();
                    loadMainTopic();
                });

        }

        function loadMainTopic(){
            $.ajax({
                    
                    url: 'loadMainTopicServlet',
                    method: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        // Populate Main Topic dropdown
                        var mainTopicDropdown = $('#mainTopic');
                        mainTopicDropdown.empty(); 
                        $.each(data, function (index, item) {
                            mainTopicDropdown.append($('<option>', {
                                value: item.id,
                                text: item.name
                            }));
                        });
    
                        // Trigger change event to load subtopics based on the initially selected main topic
                        mainTopicDropdown.change();
                    }
                });
        }

    </script>

    <!-- Spinner Start -->
    <div id="spinner"
        class="show position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <!-- Topbar Start -->
    <div class="container-fluid bg-dark py-2 d-none d-md-flex">
        <div class="container">
            <div class="d-flex justify-content-between topbar">
                <div class="top-info">
                    <small class="me-3 text-white-50"><a href="#"><i
                                class="fas fa-map-marker-alt me-2 text-secondary"></i></a>Karadigollapatti,
                        India</small>
                    <small class="me-3 text-white-50"><a href="#"><i
                                class="fas fa-envelope me-2 text-secondary"></i></a>gurukalvi.system@gmail.com</small>
                </div>
                <div id="note" class="text-secondary d-none d-xl-flex"><small>Note : Start Learning for your
                        future</small></div>
                <div class="top-link">
                    <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i
                            class="fab fa-facebook-f text-primary"></i></a>
                    <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i
                            class="fab fa-twitter text-primary"></i></a>
                    <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i
                            class="fab fa-instagram text-primary"></i></a>
                    <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle me-0"><i
                            class="fab fa-linkedin-in text-primary"></i></a>
                </div>
            </div>
        </div>
    </div>
    <!-- Topbar End -->

    <!-- Navbar Start -->
    <div class="container-fluid bg-primary">
        <div class="container">
            <nav class="navbar navbar-dark navbar-expand-lg py-0">
                <a href="index.jsp" class="navbar-brand">
                    <h1 class="text-black-50 fw-bold d-block">Guru Tech </h1>
                </a>
                <button type="button" class="navbar-toggler me-0" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse bg-transparent" id="navbarCollapse">
                    <div class="navbar-nav ms-auto mx-xl-auto p-0">
                        <a href="index.jsp" class="nav-item nav-link">Home</a>
                        <a href="about.jsp" class="nav-item nav-link">About</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Courses</a>
                            <div class="dropdown-menu rounded">
                                <a href="java.jsp" class="dropdown-item">Java</a>
                                <a href="python.jsp" class="dropdown-item">Python</a>
                                <a href="reactjs.jsp" class="dropdown-item">ReactJs</a>

                            </div>
                        </div>


                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active text-secondary"
                                data-bs-toggle="dropdown">Test</a>
                                <div class="dropdown-menu rounded">
                                    <a href="edit_topic.jsp" class="dropdown-item">Add/Edit Topics</a>
                                    <a href="edit_subtopic.jsp" class="dropdown-item">Add/Edit SubTopic</a>
                                    <a href="create_question.jsp" class="dropdown-item"> Create Questions</a>
                                    <a href="edit_question.jsp " class="dropdown-item"> Edit Question</a>
                                    <a href="create_test.jsp" class="dropdown-item"> Create Test</a>
                                    <a href="edit_test.jsp" class="dropdown-item">Edit Test</a>
                                    <a href="test_question.jsp" class="dropdown-item">Test Question </a>
                                </div>
                        </div>
                        <a href="testimonial.jsp" class="nav-item nav-link">Testimonial</a>
                        <a href="contact.jsp" class="nav-item nav-link">Contact</a>
                        <a href="login.jsp" class="nav-item nav-link" id="loginSection">Logout</a>
                        <a href="#" class="nav-item nav-link" onclick="logout()" id="logoutSection" style="display: none;">Logout</a>                    </div>
                </div>
                <div class="d-none d-xl-flex flex-shirink-0">
                    <div id="phone-tada" class="d-flex align-items-center justify-content-center me-4">
                        <a href="" class="position-relative animated tada infinite">
                            <i class="fa fa-phone-alt text-white fa-2x"></i>
                            <div class="position-absolute" style="top: -7px; left: 20px;">
                                <span><i class="fa fa-comment-dots text-secondary"></i></span>
                            </div>
                        </a>
                    </div>
                    <div class="d-flex flex-column pe-4 border-end">
                        <span class="text-white-50">Have any questions?</span>
                        <span class="text-secondary">Call: + 0123 456 7890</span>
                    </div>
                    <div class="d-flex align-items-center justify-content-center ms-4 ">
                        <a href="#"><i class="bi bi-search text-white fa-2x"></i> </a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->


    <!-- Page Header Start -->

    <div class="container-fluid page-header py-5">
        <div class="container text-center py-5">
            <div class="container">
                <h1 class="display-2 text-white mb-4 animated slideInDown">Add Test Question</h1>
                <!--  *************************************  -->
                <div class="accordion" id="accordionExample">

                    <!-- First Accordion Item -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button bg-success" style="color: #163ba4;" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Available Tests
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <div class="row justify-content-center">
                                    <div class="col-8" style="display: flex; flex-direction: column;">
                                        <div class="table-bordered" style="text-decoration-color: rgb(164, 33, 33); background-color: rgb(234, 222, 218); width: 150%; height:100%; align-self: center; max-height: 500px; overflow-x: auto; overflow-y: auto;" id="test_table"></div><br><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                
                    <!-- Second Accordion Item -->
                    <div class="accordion-item">
                        <h2 class="accordion-header " id="headingTwo">
                            <button class="accordion-button collapsed bg-danger" style="color: #163ba4;" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                Test Details
                            </button>
                        </h2>
                        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <div class="row bg-primary text-white justify-content-center">
                                    <div class="col-2" style="display: flex; flex-direction: column;"  > Test ID: <div id="test_id"></div>  </div>
                                    <div class="col-2" style="display: flex; flex-direction: column;" >Name : <div id="test_name"></div> <input type="hidden" id="test_name_value" name="test_name_value" value="" ></input> </div>
                                    <div class="col-2" style="display: flex; flex-direction: column;"  > Duration: <div id="test_duration"></div></div>
                                    <div class="col-4" style="display: flex; flex-direction: column;">
                                        Topic: 

                                        <select id="mainTopic" class="form-select mb-2 " name="topic" aria-label="Select Main Topic" ></select>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Third Accordion Item -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed bg-danger" style="color: #163ba4;" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                Existing Questions for This Test:
                            </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <div class="row bg-primary text-white justify-content-center">
                                    <div class="col-8" style="display: flex; flex-direction: column;">
                                        <div class="table-bordered" style="text-decoration-color: rgb(164, 33, 33); background-color: rgb(234, 222, 218); width: 150%; height:100%; align-self: center; max-height: 500px; overflow-x: auto; overflow-y: auto;" id="existing_test_table"></div><br><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                
                    <!-- Fourth Accordion Item -->
                    <div class="accordion-item">
                        <h2 class="accordion-header bg-secondary" id="headingFour">
                            <button class="accordion-button collapsed bg-danger" style="color: #163ba4;" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                Questions
                            </button>
                        </h2>
                        <form action="AddTestQuestionServlet" method="get">
                            <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
                                <div class="accordion-body">
                                    <div class="row justify-content-center">
                                            <div class="col-8" style="display: flex; flex-direction: column;">
                                                <div><input type="hidden" id="test_id_value" name="test_id_value" value="" ></input> </div>
                                                    <div class="table-bordered"
                                                        style="text-decoration-color: rgb(164, 33, 33); background-color: rgb(234, 222, 218); width: 150%; height:100%; align-self: center; max-height: 500px; overflow: auto; overflow-x: auto; overflow-y: auto;" id="test_question_table">
                                                    </div><br><br>
                                                    <div class="text-start d-flex justify-content-center">
                                                        <input type="submit" value="Submit" class="btn btn-dark  text-white py-3 px-5" style="margin-right: 75px;"> 
                                                        <input type="reset" value="Reset" class="btn btn-dark  text-white py-3 px-5">
                                                        <!--button id="button" type="submit" onclick="showWindow()" class="btn btn-dark  text-white py-3 px-5">Submit</button>-->
                                                    </div>
                                                
                                            </div>
                                    
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <!-- Page Header End -->




    <!-- Footer Start -->
    <div class="container-fluid footer bg-dark wow fadeIn" data-wow-delay=".3s">
        <div class="container pt-5 pb-4">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <a href="index.jsp">
                        <h1 class="text-white fw-bold d-block">High<span class="text-secondary">Tech</span> </h1>
                    </a>
                    <p class="mt-4 text-light">Lorem ipsum dolor sit amet consectetur adipisicing elit. Soluta
                        facere
                        delectus qui placeat inventore consectetur repellendus optio debitis.</p>
                    <div class="d-flex hightech-link">
                        <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i
                                class="fab fa-facebook-f text-primary"></i></a>
                        <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i
                                class="fab fa-twitter text-primary"></i></a>
                        <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i
                                class="fab fa-instagram text-primary"></i></a>
                        <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-0"><i
                                class="fab fa-linkedin-in text-primary"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <a href="#" class="h3 text-secondary">Short Link</a>
                    <div class="mt-4 d-flex flex-column short-link">
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>About
                            us</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Contact
                            us</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Our
                            Services</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Our
                            Projects</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Latest
                            Blog</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <a href="#" class="h3 text-secondary">Help Link</a>
                    <div class="mt-4 d-flex flex-column help-link">
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Terms
                            Of use</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Privacy
                            Policy</a>
                        <a href="" class="mb-2 text-white"><i
                                class="fas fa-angle-right text-secondary me-2"></i>Helps</a>
                        <a href="" class="mb-2 text-white"><i
                                class="fas fa-angle-right text-secondary me-2"></i>FQAs</a>
                        <a href="" class="mb-2 text-white"><i
                                class="fas fa-angle-right text-secondary me-2"></i>Contact</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <a href="#" class="h3 text-secondary">Contact Us</a>
                    <div class="text-white mt-4 d-flex flex-column contact-link">
                        <a href="#" class="pb-3 text-light border-bottom border-primary"><i
                                class="fas fa-map-marker-alt text-secondary me-2"></i> 123 Street, New York, USA</a>
                        <a href="#" class="py-3 text-light border-bottom border-primary"><i
                                class="fas fa-phone-alt text-secondary me-2"></i> +123 456 7890</a>
                        <a href="#" class="py-3 text-light border-bottom border-primary"><i
                                class="fas fa-envelope text-secondary me-2"></i> info@exmple.con</a>
                    </div>
                </div>
            </div>
            <hr class="text-light mt-5 mb-4">
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <span class="text-light"><a href="#" class="text-secondary"><i
                                class="fas fa-copyright text-secondary me-2"></i>Your Site Name</a>, All right
                        reserved.</span>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                    <span class="text-light">Designed By<a href="https://htmlcodex.com" class="text-secondary">HTML
                            Codex</a> Distributed By <a href="https://themewagon.com">ThemeWagon</a></span>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-secondary btn-square rounded-circle back-to-top"><i
            class="fa fa-arrow-up text-white"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    <script>
        // Check if the user is logged in
        function checkLoginStatus() {
            const isLoggedIn = localStorage.getItem('loggedIn');

            if (isLoggedIn) {
                document.getElementById('loginSection').style.display = 'none';
                document.getElementById('logoutSection').style.display = 'block';
            } else {
                document.getElementById('loginSection').style.display = 'block';
                document.getElementById('logoutSection').style.display = 'none';
            }
        }

        // Simulating logout by clearing local storage
        function logout() {
            localStorage.removeItem('loggedIn');
            checkLoginStatus();
        }

        // Call this function to check login status on page load
        checkLoginStatus();
    </script>
</body>

</html>