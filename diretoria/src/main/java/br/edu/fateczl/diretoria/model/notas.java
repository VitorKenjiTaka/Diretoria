package br.edu.fateczl.diretoria.model;

public class notas {

	private int raAluno;
	private String codigoDisciplina;
	private int codigoAvaliacao;
	private double nota;
	
	public int getRaAluno() {
		return raAluno;
	}
	public void setRaAluno(int raAluno) {
		this.raAluno = raAluno;
	}
	public String getCodigoDisciplina() {
		return codigoDisciplina;
	}
	public void setCodigoDisciplina(String codigoDisciplina) {
		this.codigoDisciplina = codigoDisciplina;
	}
	public int getCodigoAvaliacao() {
		return codigoAvaliacao;
	}
	public void setCodigoAvaliacao(int codigoAvaliacao) {
		this.codigoAvaliacao = codigoAvaliacao;
	}
	public double getNota() {
		return nota;
	}
	public void setNota(double nota) {
		this.nota = nota;
	}
	
	@Override
	public String toString() {
		return "notas [raAluno=" + raAluno + ", codigoDisciplina=" + codigoDisciplina + ", codigoAvaliacao="
				+ codigoAvaliacao + ", nota=" + nota + "]";
	}
}
