 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/resources/includes/header.jsp" %>
<%@ include file="/resources/includes/header_.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <style>
 .panel-body tr th {
 	text-align: center;
 	font-family: "HANNA";
 }
 .panel-body tr td {
 	font-family: "NANUM";
 	font-size: 16px;
 	font-weight: bold;
 }
 </style>
 <body style="margin: 8px; background-color: white;">
    <h1 style="margin-left: 200px; margin-top:50px; margin-bottom: 0;  font-family: 'HANNA'; font-size: 95px;">고객센터</h1>
	<hr width="480px" style="color: black; margin-left: 200px;"><br><br>
        <div id="page-wrapper" style="margin: 0 300px;">

            <div class="row">
                <div class="col-lg-12" >
                    <h1 class="page-header" style="font-family: 'NANUM'">문의 & 답변</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 41px;">
                        <c:if test="${not empty loginUser}">
                            <button id="regBtn" type="button" class="btn btn-xs pull-right">새글작성</button>                        
                        </c:if>
                           		<!-- // 새글 작성 page로 이동 -->
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th style="width: 10%">NO</th>
                                        <th style="width: 45%">TITLE</th>
                                        <th style="width: 20%">WRITER</th>
                                        <th style="width: 15%">DATE</th>
                                        <th style="width: 10%">VIEWCNT</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${list }" var="board">
                                		<tr>
                                			<td style="text-align: center;">${board.bno }</td>
                                			<td style="padding-left: 20px;">
                                				<a style="color: palevioletred;" class="move" href="<c:out value='${board.bno}'/>">
                                				<c:out value="${board.title}"/><b>&nbsp;&nbsp;[${board.replycnt}]</b></a>
                                			</td>
                                			<%-- <td><a href="${contextPath}/board/read?bno=${board.bno}">${board.title}</a></td> --%>
                                			<td style="padding-left: 20px;">${board.writer}</td>
                                			<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}"/></td>
                                			<td style="text-align: center;"><span class="badge bg-ref">${board.viewcnt}</span></td>
                                		</tr>
                                	</c:forEach>
                                </tbody>
                            </table> <!-- table태그 끝 -->
                <div class="row">
                	<div class="col-lg-12" style="padding-top: 30px;">
                		<form id="searchForm" action="${ctx}/board/list" method="get" style="text-align: center;">
							<select name="type" style="height: 32px; font-family: 'NANUM' " >
								<option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>선택하세요</option>
								<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
								<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
								<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
								<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
								<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 or 작성자</option>
								<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':'' }"/>>제목 or 내용 or 작성자</option>
							</select>  
							<input style="height: 32px; font-family: 'NANUM'; font-weight: bold; " type="text" name="keyword" placeholder="검색어"  value='<c:out value="${pageMaker.cri.keyword}"/>'/>
							<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
							<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>
							<button class="btn btn-default" style="font-family: 'NANUM'">검색</button> 	
                		</form>
                	</div>       
                </div> 
                    
                <div class='pull-right'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage -1}">Previous</a>
							</li>
						</c:if>

						<c:forEach var="num" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}">
							<li class="paginate_button  ${pageMaker.cri.pageNum == num ? 'active':''} ">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>

						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage +1 }">Next</a></li>
						</c:if>
					</ul>
				</div>
				<!--  end Pagination -->

		    <!-- 실제 페이지를 클릭하면 동작을 하는 부분  -->
			<form id='actionForm' action="${contextPath}/board/list" method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
				<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
				<input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
			</form>                            
                            			<!-- Modal  추가 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">수정완료</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">닫기</button>
							<!-- <button type="button" class="btn btn-primary">Save
								changes</button> -->
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>    
        </body>
<script type="text/javascript">
	$(document).ready(function() {
//		var result = '<c:out value="${result}"/>';
		var result = "${result}";
		// controllor에서 받은 result값(추가된 게시글 번호)
		
		// 파라메터에 따라서 모달창을 보여주거나 내용을 수정한 뒤 보이도록 작성하기 위함.
		checkModal(result);
		
		// history 객체에 현재 저장된 데이터를 변경 (새 기록을 작성하는 대신 사용자의 동작에 따라 현재 히스토리 엔트리의 URL을 업데이트 하려고 할 때 매우 유용)
		// window.history.replace(data, title [, url]);
		// 사용 예) window.history.replaceState("http://example.ca", "Sample Title", "/example/path.html");
	    // 이 예제는 현재 기록, 주소 표시 줄 및 페이지 제목을 바꿉니다.
		history.replaceState({}, null, null);
		
		function checkModal(result) {
			if (result === "" || history.state) {
				return;
			}

			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}

			$("#myModal").modal("show");
	    }
		
		$("#regBtn").on("click", function() {
			self.location = "${contextPath}/board/register";
		});
		
		// 페이지 번호를 클릭하면 처리하는 부분
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault(); // <a>태그를 클릭해도 페이지 이동이 없도록 처리
			
			console.log("click");

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		$(".move").on("click", function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"
											+ $(this).attr("href")
											+ "'>");
			actionForm.attr("action", "${contextPath}/board/read");
			/* actionForm.attr("action", "${contextPath}/board/read"); */
			actionForm.submit();
		});

		var searchForm = $("#searchForm");

		$("#searchForm button").on("click", function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				
				return false;
			}

			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");
			
			e.preventDefault();

			searchForm.submit();

		});
	});
</script>

<%@include file="/resources/includes/footer_.jsp"%>
<%@include file="/resources/includes/footer.jsp"%>