<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.onlinecloth.pojo.*"%>
<%@ page import="com.onlinecloth.dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Breeze - Home</title>
<%@ include file="components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="components/navbar.jsp"%>

	<%
	String searchResult = (String) request.getAttribute("enteredText");
	String prodFor = (String) request.getAttribute("prodFor");
	String bId = (String) request.getAttribute("bId");
	String cId = (String) request.getAttribute("cId");
	String cat = request.getParameter("category");
	String cloId = request.getParameter("cloth");
	ProductDaoImp pdao = new ProductDaoImp();

	List<Product> l1 = null;

	if (cat == null && cloId == null) {
		cat = "0";
		cloId = "0";
		if (cat.trim().equals("0") && cloId.trim().equals("0")) {
			l1 = pdao.getAllProduct();
		}
	}

	else if (cloId != null) {

		if (cloId.equals("0")) {
			l1 = pdao.getAllProduct();
		}

		else {
			int clotId = Integer.parseInt(cloId.trim());
			l1 = pdao.getProductByCloth(clotId);
		}

	}

	else {
		if (cat.equals("0")) {
			l1 = pdao.getAllProduct();
		}

		else {

			int categoryId = Integer.parseInt(cat.trim());
			l1 = pdao.getProductByCategory(categoryId);

		}

	}
	%>


	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		</ol>
		<div class="carousel-inner" style="width: 100%;">
			<div class="carousel-item active">
				<img class="d-block w-100 img-fluid" src="images/carro1.png"
					alt="Primeiro slide">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100 img-fluid" src="images/carro2.png"
					alt="Segundo slide">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Anterior</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Próximo</span>
		</a>
	</div>





	<div class="text-center"><%@ include
			file="components/message.jsp"%></div>
	<div class="container-fluid">

		<!-- Pesquisa -->

		<div class="row">
			<div class="col-md-2 mt-4 admin">

				<div class="card">

					<div class="card-header text-center">
						<h4>Pesquisa Rápida</h4>
					</div>

					<div class="card-body">
						<form action="ProductOperationServlet" method="post">

							<input type="hidden" name="action" value="searchSmartly">


							<div class="form-group">

								<select class="form-control custom-bg text-center mt-3"
									id="cloth" name="clothId">
									<option value="0">Selecione a roupa</option>
									<%
									for (Cloth c : cll) {
									%>
									<option value="<%=c.getClothId()%>"><%=c.getClothTitle()%></option>

									<%
									}
									%>
								</select> <select class="form-control custom-bg text-center mt-3"
									id="type" name="productFT">
									<option value="0">Selecione a categoria:</option>
									<option value="Casual">Casual</option>
									<option value="Formal">Formal</option>
									<option value="Íntima">Íntima</option>
								</select>

							</div>

							<button type="submit" class="btn custom-bg" style="width: 100px;">Procurar</button>

						</form>
					</div>

				</div>


			</div>

			<!-- show products -->

			<%
			if (searchResult != null) {
				List<Product> listOfProductFromSearch = new ProductDaoImp().getSearchedProduct(searchResult);
			%>

			<div class="col-md-10">

				<div class="row mt-4">
					<div class="col-md-12 admin">
						<div class="card-columns">

							<%
							String stock = "Fora de estoque!";
							for (Product p : listOfProductFromSearch) {
							%>
							<div class="card p-2">

								<img src="productImages/<%=p.getProductPhoto()%>"
									style="max-height: 270px; max-width: 100%; width: auto;"
									class="card-img-top rounded mx-auto d-block m-2" alt="img">

								<div class="card-body">
									<a href="product.jsp?productId=<%=p.getProductId()%>"
										style="text-decoration: none; color: black;">
										<h5 class="card-title"><%=p.getProductTitle()%></h5>
									</a>
									<p class="card-text"><%=Helper.get10Words(p.getProductDescription())%></p>
								</div>
								<div class="card-footer text-center">
									<span class="ml-2" style="font-size: 20px;">Estoque:</span> <span
										class="ml-1" style="font-size: 20px"> <%
 					if (p.getProductQuantity() < 1) {
 					%><span style="color: red;"><b><%=stock%></b></span> <%
 					} else {
 					%><%=p.getProductQuantity()%> <%
 						}
 						%>
									</span>
								</div>

							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>

			</div>

			<%
			} else if (bId != null && cId != null && prodFor != null) {

			int brId = Integer.parseInt(bId);
			int clId = Integer.parseInt(cId);

			List<Product> listOfProductFromSearch = new ProductDaoImp().getSearchedProduct(prodFor, brId, clId);
			%>
			<div class="col-md-10">

				<div class="row mt-4">
					<div class="col-md-12 admin">
						<div class="card-columns">

							<%
							String stock = "Fora de estoque!";
							for (Product p : listOfProductFromSearch) {
							%>
							<div class="card p-2">

								<img src="productImages/<%=p.getProductPhoto()%>"
									style="max-height: 270px; max-width: 100%; width: auto;"
									class="card-img-top rounded mx-auto d-block m-2" alt="img">

								<div class="card-body">
									<a href="product.jsp?productId=<%=p.getProductId()%>"
										style="text-decoration: none; color: black;">
										<h5 class="card-title"><%=p.getProductTitle()%></h5>
									</a>
									<p class="card-text"><%=Helper.get10Words(p.getProductDescription())%></p>
								</div>
								<div class="card-footer text-center">

									</p>
									<span class="ml-2" style="font-size: 20px;">Estoque:</span> <span
										class="ml-1" style="font-size: 20px"> <%
 if (p.getProductQuantity() < 1) {
 %><span style="color: red;"><b><%=stock%></b></span> <%
 } else {
 %><%=p.getProductQuantity()%> <%
 }
 %>
									</span>
								</div>

							</div>


							<%
							}
							%>
						</div>
					</div>
				</div>

			</div>
			<%
			}

			else {
			%>
			<div class="col-md-10 ">

				<div class="row mt-4">
					<div class="col-md-12 admin">
						<div class="card-columns hover">

							<%
							String stock = "Fora de estoque!";
							for (Product p : l1) {
							%>

							<div class="card">

								<img src="productImages/<%=p.getProductPhoto()%>"
									style="max-height: 270px; max-width: 100%; width: auto;"
									class="card-img-top rounded mx-auto d-block m-2" alt="img">

								<div class="card-body">
									<h5 class="card-title">
										<a href="product.jsp?productId=<%=p.getProductId()%>"
											style="text-decoration: none; color: black;"> <%=p.getProductTitle()%></a>
									</h5>
									<p class="card-text"><%=Helper.get10Words(p.getProductDescription())%></p>
								</div>
								<div class="card-footer text-center">
									<span class="ml-2" style="font-size: 20px;">Estoque:</span> <span
										class="ml-1" style="font-size: 20px"> <%
 if (p.getProductQuantity() < 1) {
 %><span style="color: red;"><b><%=stock%></b></span> <%
 } else {
 %><%=p.getProductQuantity()%> <%
 }
 %>
									</span>
								</div>

							</div>


							<%
							}
							%>
						</div>
					</div>
				</div>

			</div>
			<%
			}
			%>

		</div>
	</div>

	<footer class="text-black py-4">
		<div class="container text-center">
			<p>
				2023 - Breeze<br> Todos os direitos reservados.
			</p>
		</div>
	</footer>

</body>
</html>