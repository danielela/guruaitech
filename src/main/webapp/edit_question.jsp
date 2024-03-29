
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>HighTech - IT Solutions Website Template</title>
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
    
    <!-- <link href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css" rel="stylesheet">
     -->
    <style>
 .scroll-container {
            display: flex;
            flex-direction: column;
            overflow: hidden;
            max-height: 700px; /* Adjust as needed */
        }

        .horizontal-scroll {
            display: flex;
            overflow-x: auto;
            overflow-y: hidden;
            width: 100%; /* Table width will be 100% of the container */
        }

        .question-table {
            text-decoration-color: rgb(164, 33, 33);
            background-color: rgb(234, 222, 218);
            height:1000px;
        }
    </style>

    
</head>

<body>
     <form action="updateQuestionServlet" method="post">
    <script>
        $(document).ready(function(){
            console.log("hello");
           $.ajax({
            type: "GET",
            url: "getAllQuestionServlet",
            success: function(response) {
                $("#question_table").append(response);
            },
            error: function (xhr, status, error) {
                console.log("error in ajax call " + error + " stutus " + status);
            }

           });
        });
        function loadQuestion(question_id) {
            console.log(question_id);

            $.post('loadQuestionServlet',
            {
                "question_id": question_id,
            })

            .done(function (response) {
                console.log(response);
                console.log(response.topic_id);
                console.log(JSON.stringify(response));
                        $("#formGroupExampleInput0").val(question_id);
                        $("#formGroupExampleInput1").val(response.topic_id);
                        $("#formGroupExampleInput2").val(response.question_text);
                        $("#formGroupExampleInput3").val(response.option_a);
                        $("#formGroupExampleInput4").val(response.option_b);
                        $("#formGroupExampleInput5").val(response.option_c);
                        $("#formGroupExampleInput6").val(response.option_d);
                        $("#formGroupExampleInput7").val(response.correct_option);
                        $("#formGroupExampleInput8").val(response.explaination);
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
                <div class="row justify-content-center">
                    <div class="col-8" style="display: flex; flex-direction: column;" >

                            <!-- Your table content here -->
                            
                            <div class="scroll-container">
                             <div class="horizontal-scroll">
                                <div class="table-responsive table-bordered" style="text-decoration-color: rgb(164, 33, 33); background-color: rgb(234, 222, 218);" id="question_table">
                                </div>
                                </div>
                            </div>  
                    </div>
                    <div class="col-4 p-2 rounded contact-form fadeIn" style="display: flex; flex-direction: column;">
                        <form class="row g-3 needs-validation" novalidate>
                                
                            <div class="mb-4">
                                <input type="hidden" id="formGroupExampleInput0" name="question_id" >
                                <input type="text" id="formGroupExampleInput1" name="topicid"
                                    class="form-control border-0 py-3" placeholder="Topic ID" readonly>

                            </div>
                            <div class="mb-4">
                                    <textarea
                                        id="formGroupExampleInput2"
                                        class="w-100 form-control border-0 py-3"
                                        rows="6"
                                        cols="5"
                                        name="question_text"
                                        placeholder="Question Text"
                                        required
                                    ></textarea>
                            </div>
                            <div class="mb-4">
                                    <textarea
                                    id="formGroupExampleInput3"
                                    class="w-100 form-control border-0 py-3"
                                    name="option_a"
                                    rows="3"
                                    cols="5"
                                    placeholder="Option A"
                                ></textarea>
                            </div>
                            <div class="mb-4">
                               
                                    <textarea
                                    id="formGroupExampleInput4"
                                    class="w-100 form-control border-0 py-3"
                                    name="option_b"
                                    rows="3"
                                    cols="5"
                                    placeholder="Option B"
                                ></textarea>
                            </div>
                            <div class="mb-4">
                                    <textarea
                                    id="formGroupExampleInput5"
                                    class="w-100 form-control border-0 py-3"
                                    name="option_c"
                                    rows="3"
                                    cols="5"
                                    placeholder="Option C"
                                ></textarea>
                            </div>
                            <div class="mb-4">
                                <textarea
                                    id="formGroupExampleInput6"
                                    class="w-100 form-control border-0 py-3"
                                    name="option_d"
                                    rows="3"
                                    cols="5"
                                    placeholder="Option D"
                                ></textarea>
                            </div>
                            <div class="mb-4">
                                <input type="text" id="formGroupExampleInput7" name="correct_option"
                                    class="form-control border-0 py-3" placeholder="Correct Option">
                            </div>
                            <div class="mb-4">
                                <input type="text" id="formGroupExampleInput8" name="explaination"
                                    class="form-control border-0 py-3" placeholder="Explaination">
                            </div>
                            
                            <div class="text-start d-flex justify-content-center">
                                <button class="btn btn-dark  text-white py-3 px-5" type="submit">Update</button> &nbsp;
                                <button class="btn btn-secondary text-white py-3 px-5" type="reset">Reset</button> &nbsp;
                            </div>
                            
                         </form> 
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
                    <p class="mt-4 text-light">Lorem ipsum dolor sit amet consectetur adipisicing elit. Soluta facere
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
  </form>
</body>

</html>
