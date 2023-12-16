package com.onlinecloth.pojo;

/* O termo "POJO" é usado para descrever classes Java simples que não herdam de nenhuma classe
 * específica, não implementam interfaces de frameworks e não têm dependências externas.
 * Em outras palavras, são objetos de dados puros, sem a necessidade de seguir padrões específicos.
 * Essa simplicidade facilita a compreensão, manutenção e reutilização do código em diferentes contextos.
 * Geralmente tem o construtor e seu métodos de acesso dos membros (getters e setters) */

public class Cart
{
     private int cartId,userId,productId,quantity;
     private String productSize;

	public Cart(int userId, int productId, int quantity) {
		super();
		this.userId = userId;
		this.productId = productId;
		this.quantity = quantity;
	}

	public Cart(int cartId, int userId, int productId, int quantity) {
		super();
		this.cartId = cartId;
		this.userId = userId;
		this.productId = productId;
		this.quantity = quantity;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getProductSize() {
		return productSize;
	}

	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}
	
	
     
    
     
}
