<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file= "/resources/includes/header.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>thema</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
	<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
	<!-- Google fonts-->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
	<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
	<!-- Core theme CSS (includes Bootstrap)-->
	    <link href="${ctx }/resources/css/styles.css" rel="stylesheet" />
	</head>
	
<style>
h2{
	font-family: "NANUM";
}
</style>
<body id="page-top">
	    <!-- Portfolio Grid-->
	<section class="page-section bg-light" id="portfolio">
	<a name="culture"></a><br>
	    <div class="container">
	        <div class="text-center">
	            <h2 class="section-heading text-uppercase">CULTURE</h2>
	            <hr width="480px"><br><br>
	        </div>
	         <div class="row">
	       	 <c:forEach items="${cultureList}" var="culture" begin="1" end="9" step="1" varStatus="status">
	             <div class="col-lg-4 col-sm-6 mb-4">
	                 <div class="portfolio-item">
	                     <a class="portfolio-link" data-toggle="modal" href="#cultureportfolioModal${status.count}">
	                         <div class="portfolio-hover">
	                             <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	                         </div>
	                         <img class="img-fluid" src="${culture.img}"/>
	                     </a>
	                     <div class="portfolio-caption">
	                         <div class="portfolio-caption-heading" style="font-family:'NANUM'; font-size: 25px;">${culture.subject}</div>
	                     </div>
	                 </div>
	             </div>
	   	  </c:forEach>
	         </div>
	      <a name="activity"></a><br>
	     <div class="text-center">
	            <h2 class="section-heading text-uppercase">ACTIVITY</h2>
	            <hr width="480px"><br><br>
	        </div>
	         <div class="row">
	     	   <c:forEach items="${activityList}" var="activity" begin="1" end="9" step="1" varStatus="status">
	             <div class="col-lg-4 col-sm-6 mb-4">
	                 <div class="portfolio-item">
	                     <a class="portfolio-link" data-toggle="modal" href="#activityportfolioModal${status.count}">
	                         <div class="portfolio-hover">
	                             <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	                         </div>
	                         <img class="img-fluid" src="${activity.img}"/>
	                     </a>
	                     <div class="portfolio-caption">
	                         <div class="portfolio-caption-heading" style="font-family:'NANUM'; font-size: 25px;">${activity.subject}</div>
	                     </div>
	                 </div>
	             </div>
	  	   </c:forEach>
	         </div>
	     
	     <a name="healing"></a><br>
	     <div class="text-center">
	            <h2 class="section-heading text-uppercase">HEALING</h2>
	            <hr width="480px"><br><br>
	        </div>
	         <div class="row">
		        <c:forEach items="${healingList}" var="healing" begin="1" end="9" step="1" varStatus="status">
	             <div class="col-lg-4 col-sm-6 mb-4">
	                 <div class="portfolio-item">
	                     <a class="portfolio-link" data-toggle="modal" href="#healingportfolioModal${status.count}">
	                         <div class="portfolio-hover">
	                             <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
	                         </div>
	                         <img class="img-fluid" src="${healing.img}"/>
	                     </a>
	                     <div class="portfolio-caption">
	                         <div class="portfolio-caption-heading" style="font-family:'NANUM'; font-size: 25px;">${healing.subject}</div>
	                     </div>
	                 </div>
	             </div>
		     </c:forEach>
	         </div>
	  </div>
	</section>
	<!-- Portfolio Modals-->
	<c:forEach items="${cultureList}" var="culture" begin="1" end="9" step="1" varStatus="status">
		<div class="portfolio-modal modal fade" id="cultureportfolioModal${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="close-modal" data-dismiss="modal"><img src="${ctx }/resources/images/close-icon.svg" alt="Close modal" /></div>
		            <div class="container">
		                <div class="row justify-content-center">
		                    <div class="col-lg-8">
		                        <div class="modal-body">
		                            <!-- Project Details Go Here-->
		                            <h2 class="text-uppercase">${culture.subject}</h2>
		                            <p class="item-intro text-muted">${culture.sido} ${culture.place}</p>
		                            <img class="img-fluid d-block mx-auto" src="${culture.img}" alt="..." />
		                            <p style="font-family: 'NANUMb'; font-weight: bold">${culture.time}</p>
		                            <P style="font-family: 'NANUMb'; font-weight: bold">${culture.price}</P>
		                            <p style="font-family: 'NANUMb';">${culture.content}</p>
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
	
	<c:forEach items="${activityList}" var="activity" begin="1" end="9" step="1" varStatus="status">
		<div class="portfolio-modal modal fade" id="activityportfolioModal${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="close-modal" data-dismiss="modal"><img src="${ctx }/resources/images/close-icon.svg" alt="Close modal" /></div>
		            <div class="container">
		                <div class="row justify-content-center">
		                    <div class="col-lg-8">
		                        <div class="modal-body">
		                            <!-- Project Details Go Here-->
		                            <h2 class="text-uppercase">${activity.subject}</h2>
		                            <p class="item-intro text-muted">${activity.sido} ${activity.place}</p>
		                            <img class="img-fluid d-block mx-auto" src="${activity.img}" alt="..." />
		                            <P style="font-family: 'NANUMb'; font-weight: bold">${activity.price}</P>
		                            <p style="font-family: 'NANUMb'; ">${activity.content}</p>
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
	
	<c:forEach items="${healingList}" var="healing" begin="1" end="9" step="1" varStatus="status">
		<div class="portfolio-modal modal fade" id="healingportfolioModal${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="close-modal" data-dismiss="modal"><img src="${ctx }/resources/images/close-icon.svg" alt="Close modal" /></div>
		            <div class="container">
		                <div class="row justify-content-center">
		                    <div class="col-lg-8">
		                        <div class="modal-body">
		                            <!-- Project Details Go Here-->
		                            <h2 class="text-uppercase">${healing.subject}</h2>
		                            <p class="item-intro text-muted">${healing.sido} ${healing.place}</p>
		                            <img class="img-fluid d-block mx-auto" src="${healing.img}" alt="..." />
		                            <p style="font-family: 'NANUMb'; ">${healing.content}</p>
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