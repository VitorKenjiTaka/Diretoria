package br.edu.fateczl.diretoria.model;

public class avaliacao {

	private int codigo;
	private String tipo;
	
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	@Override
	public String toString() {
		return "avaliacao [codigo=" + codigo + ", Tipo=" + tipo + "]";
	}
}
