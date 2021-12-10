<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="right_col" role="main">
  <div class="">
    <div class="clearfix"></div>
    
    <div class="row">
    	<div class="col-md-12 col-sm-12">
    		<div class="x_panel">
    			<div class="x_title">
    				<h2>${titlePage }</h2>
					<ul class="nav navbar-right panel_toolbox">
						<li>
							<a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
					</ul>
					<div class="clearfix"></div>
    			</div>
    			
    			<div class="x_content">
    				<br>
    				<form:form modelAttribute="modelForm" method="POST" servletRelativeAction="/order-detail/edit"  cssClass="form-horizontal form-label-left">
    					<form:hidden path="id"/> 					
    					<form:hidden path="active"/>    					
    					<form:hidden path="created"/>
    					
    					<div class="item form-group">
							<label class="col-form-label col-md-3 col-sm-3 label-align" for="orderCode">Order <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12"> 
								<c:choose>
									<c:when test="${!viewOnly }">
										<form:errors path="orderCode" cssClass="help-block" cssStyle="color: #dc3545;"></form:errors>
										<form:select path="orderCode" cssClass="form-control ">
											<form:options items="${mapOrder }" />
										</form:select>
									</c:when>
									<c:otherwise>
										<form:input path="order.code" cssClass="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<div class="item form-group">
							<label class="col-form-label col-md-3 col-sm-3 label-align" for="productCode">Product <span class="required">*</span>
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12"> 
								<c:choose>
									<c:when test="${!viewOnly }">
										<form:errors path="productCode" cssClass="help-block" cssStyle="color: #dc3545;"></form:errors>
										<form:select path="productCode" cssClass="form-control ">
											<form:options items="${mapProduct }" />
										</form:select>
									</c:when>
									<c:otherwise>
										<form:input path="product.code" cssClass="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>
    					
    					<div class="item form-group">
							<label class="col-form-label col-md-3 col-sm-3 label-align" for="code">Quantity 
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12"> 
								<form:errors path="quantity" cssClass="help-block" cssStyle="color: #dc3545;" />
								<form:input path="quantity" disabled="${viewOnly }" type="number" cssClass="form-control" />
							</div>
						</div>
    					
    					<div class="item form-group">
							<label class="col-form-label col-md-3 col-sm-3 label-align" for="code">Price 
							</label>
							<div class="col-md-6 col-sm-6 col-xs-12"> 
								<form:errors path="price" cssClass="help-block" cssStyle="color: #dc3545;" />
								<form:input path="price" disabled="${viewOnly }" cssClass="form-control" />
							</div>
						</div>
						
						<div class="ln_solid"></div>
										
						<div class="item form-group">
							<div class="col-md-6 col-sm-6 col-xs-12 offset-md-3">
								<button class="btn btn-primary" type="button" onclick="cancel();">Cancel</button>
								<button class="btn btn-primary" type="reset">Reset</button>
								<button type="submit" class="btn btn-success">Submit</button>
							</div>
						</div>
						    					
    				</form:form>
    			</div>
    		</div>
    	</div>
    </div>
  </div>
</div>

<script type="text/javascript">
	$(document).ready(
		function () {
			$('#order-detaillistId').addClass('cuurent-page').siblings().removeClass('current-page');
			var parent = $('#order-detaillistId').parents('li');
			parent.addClass('active').siblings().removeClass('active');
			$('#order-detaillistId').parents().show();
		}		
	);
	
	function cancel() {
		window.location.href = '<c:url value="/order-detail/list"/>'
	}
</script>