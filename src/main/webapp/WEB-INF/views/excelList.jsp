<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <c:forEach items="${datas}" var="groom">
   		${groom.g_code }
   		${groom.g_name }
   		${groom.g_r_code }
   </c:forEach>
   
</body>
</html>