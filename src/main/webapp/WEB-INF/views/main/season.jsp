<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file= "/resources/includes/header.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>


<!DOCTYPE html>
<html lang="en">
<link href="${ctx }/resources/css/styles.css" rel="stylesheet">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>season</title>
    <link rel="icon" type="${ctx }/resources/image/x-icon" href="assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
	<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
	<!-- Google fonts-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
	<!-- Core theme CSS (includes Bootstrap)-->

<style type="text/css">
.text-uppercase {
	width: max-content;
	margin: auto;
}
h2{
	font-family: "NANUM";
}
</style>	   
</head>
	<body id="page-top">
	    <!-- Portfolio Grid-->
	<section class="page-section bg-light" id="portfolio">
	<a name="spring"></a><br>
	    <div class="container">
	        <div class="text-center">
	            <h2 class="section-heading text-uppercase">SPRING</h2>
	            <hr width="480px"><br><br>
	        </div>
	         <div class="row">
	       	 <c:forEach items="${springList}" var="spring" begin="0" end="8" step="1" varStatus="status">
	             <div class="col-lg-4 col-sm-6 mb-4">
	                 <div class="portfolio-item">
	                     <a class="portfolio-link" data-toggle="modal" href="#springportfolioModal${status.count}">
	                         <div class="portfolio-hover">
	                             <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	                         </div>
	                         <img class="img-fluid" src="${spring.img}"/>
	                     </a>
	                     <div class="portfolio-caption">
	                         <div class="portfolio-caption-heading" style="font-family:'NANUM'; font-size: 25px;">${spring.subject}</div>
	                     </div>
	                 </div>
	             </div>
	   	  </c:forEach>
	         </div>
	      <a name="summer"></a><br>
	     <div class="text-center">
	            <h2 class="section-heading text-uppercase">SUMMER</h2>
	            <hr width="480px"><br><br>
	        </div>
	         <div class="row">
	     	   <c:forEach items="${summerList}" var="summer" begin="0" end="8" step="1" varStatus="status">
	             <div class="col-lg-4 col-sm-6 mb-4">
	                 <div class="portfolio-item">
	                     <a class="portfolio-link" data-toggle="modal" href="#summerportfolioModal${status.count}">
	                         <div class="portfolio-hover">
	                             <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	                         </div>
	                         <img class="img-fluid" src="${summer.img}"/>
	                     </a>
	                     <div class="portfolio-caption">
	                         <div class="portfolio-caption-heading" style="font-family:'NANUM'; font-size: 25px;">${summer.subject}</div>
	                     </div>
	                 </div>
	             </div>
	  	   </c:forEach>
	         </div>
	     
	     <a name="fall"></a><br>
	     <div class="text-center">
	            <h2 class="section-heading text-uppercase">FALL</h2>
	            <hr width="480px"><br><br>
	        </div>
	         <div class="row">
		        <c:forEach items="${fallList}" var="fall" begin="0" end="8" step="1" varStatus="status">
	             <div class="col-lg-4 col-sm-6 mb-4">
	                 <div class="portfolio-item">
	                     <a class="portfolio-link" data-toggle="modal" href="#fallportfolioModal${status.count}">
	                         <div class="portfolio-hover">
	                             <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	                         </div>
	                         <img class="img-fluid" src="${fall.img}"/>
	                     </a>
	                     <div class="portfolio-caption">
	                         <div class="portfolio-caption-heading" style="font-family:'NANUM'; font-size: 25px;">${fall.subject}</div>
	                     </div>
	                 </div>
	             </div>
		     </c:forEach>
	         </div>
	     
	     <a name="winter"></a><br>
	     <div class="text-center">
	            <h2 class="section-heading text-uppercase">WINTER</h2>
	            <hr width="480px"><br><br>
	       </div>
	       <div class="row">
			 	 <c:forEach items="${winterList}" var="winter" begin="0" end="8" step="1" varStatus="status">
	       <div class="col-lg-4 col-sm-6 mb-4">
	   			<div class="portfolio-item">
	   			    <a class="portfolio-link" data-toggle="modal" href="#winterportfolioModal${status.count}">
	          		 <div class="portfolio-hover">
	             	   <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	          		 </div>
	           		 <img class="img-fluid" src="${winter.img}"/>
	        		</a>
	        		<div class="portfolio-caption">
	          		  <div class="portfolio-caption-heading" style="font-family:'NANUM'; font-size: 25px;">${winter.subject}</div>
	       			</div>
	   			 </div>
	        </div>
				</c:forEach>
	    </div>
	     
	  </div>
	</section>
	<!-- Portfolio Modals-->
	<c:forEach items="${springList}" var="spring" begin="0" end="8" step="1" varStatus="status">
		<div class="portfolio-modal modal fade" id="springportfolioModal${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="close-modal" data-dismiss="modal"><img src="${ctx }/resources/images/close-icon.svg" alt="Close modal" /></div>
		            <div class="container">
		                <div class="row justify-content-center">
		                    <div class="col-lg-8">
		                        <div class="modal-body">
		                            <!-- Project Details Go Here-->
		                            <h2 class="text-uppercase">${spring.subject}</h2>
		                            <p class="item-intro text-muted">${spring.sido} ${spring.gungu}</p>
		                            <img class="img-fluid d-block mx-auto" src="${spring.img}" alt="..." />
		                            <p style="font-family: 'NANUMb'; font-weight: bold">tag : ${spring.tag}</p>
		                            <p style="font-family: 'NANUMb'">${spring.summary}</p>
		                            <button class="btn btn-primary" data-dismiss="modal" type="button">
		                                <i class="fas fa-times mr-1"></i>
		                                Close
		                            </button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</c:forEach>
	
	<c:forEach items="${summerList}" var="summer" begin="0" end="8" step="1" varStatus="status">
		<div class="portfolio-modal modal fade" id="summerportfolioModal${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="close-modal" data-dismiss="modal"><img src="${ctx }/resources/images/close-icon.svg" alt="Close modal" /></div>
		            <div class="container">
		                <div class="row justify-content-center">
		                    <div class="col-lg-8">
		                        <div class="modal-body">
		                            <!-- Project Details Go Here-->
		                            <h2 class="text-uppercase">${summer.subject}</h2>
		                            <p class="item-intro text-muted">${summer.sido} ${summer.gungu}</p>
		                            <img class="img-fluid d-block mx-auto" src="${summer.img}" alt="..." />
		                            <p style="font-family: 'NANUMb'; font-weight: bold">tag : ${summer.tag}</p>
		                             <p style="font-family: 'NANUMb'">${summer.summary}</p>
		                            <button class="btn btn-primary" data-dismiss="modal" type="button">
		                                <i class="fas fa-times mr-1"></i>
		                                Close
		                            </button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</c:forEach>
	
	<c:forEach items="${fallList}" var="fall" begin="0" end="8" step="1" varStatus="status">
		<div class="portfolio-modal modal fade" id="fallportfolioModal${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="close-modal" data-dismiss="modal"><img src="${ctx }/resources/images/close-icon.svg" alt="Close modal" /></div>
		            <div class="container">
		                <div class="row justify-content-center">
		                    <div class="col-lg-8">
		                        <div class="modal-body">
		                            <!-- Project Details Go Here-->
		                            <h2 class="text-uppercase">${fall.subject}</h2>
		                            <p class="item-intro text-muted">${fall.sido} ${fall.gungu}</p>
		                            <img class="img-fluid d-block mx-auto" src="${fall.img}" alt="..." />
		                            <p style="font-family: 'NANUMb'; font-weight: bold">tag : ${fall.tag}</p>
		                             <p style="font-family: 'NANUMb'">${fall.summary}</p>
		                            <button class="btn btn-primary" data-dismiss="modal" type="button">
		                                <i class="fas fa-times mr-1"></i>
		                                Close
		                            </button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</c:forEach>
	
	<c:forEach items="${winterList}" var="winter" begin="0" end="8" step="1" varStatus="status">
		<div class="portfolio-modal modal fade" id="winterportfolioModal${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="close-modal" data-dismiss="modal"><img src="${ctx }/resources/images/close-icon.svg" alt="Close modal" /></div>
		            <div class="container">
		                <div class="row justify-content-center">
		                    <div class="col-lg-8">
		                        <div class="modal-body">
		                            <!-- Project Details Go Here-->
		                            <h2 class="text-uppercase">${winter.subject}</h2>
		                            <p class="item-intro text-muted">${winter.sido} ${winter.gungu}</p>
		                            <img class="img-fluid d-block mx-auto" src="${winter.img}" alt="..." />
		                            <p style="font-family: 'NANUMb'; font-weight: bold">tag : ${winter.tag}</p>
		                             <p style="font-family: 'NANUMb'">${winter.summary}</p>
		                            <button class="btn btn-primary" data-dismiss="modal" type="button">
		                                <i class="fas fa-times mr-1"></i>
		                                Close
		                            </button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</c:forEach>
	<!-- Bootstrap core JS-->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Third party plugin JS-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
	<!-- Contact form JS-->
	<script src="${ctx }/resources/assets/mail/jqBootstrapValidation.js"></script>
	<script src="${ctx }/resources/assets/mail/contact_me.js"></script>
	<!-- Core theme JS-->
	<script src="${ctx }/resources/js/scripts.js"></script>
</body>

</html>