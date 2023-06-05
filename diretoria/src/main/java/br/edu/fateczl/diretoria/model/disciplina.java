package br.edu.fateczl.diretoria.model;

public class disciplina {

	private String codigo	;	
	private String nome		;
	private String sigla	;	
	private String turno	;	
	private int numAulas	;
	
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getSigla() {
		return sigla;
	}
	public void setSigla(String sigla) {
		this.sigla = sigla;
	}
	public String getTurno() {
		return turno;
	}
	public void setTurno(String turno) {
		this.turno = turno;
	}
	public int getNumAulas() {
		return numAulas;
	}
	public void setNumAulas(int numAulas) {
		this.numAulas = numAulas;
	}
	
	@Override
	public String toString() {
		return "disciplina [codigo=" + codigo + ", nome=" + nome + ", sigla=" + sigla + ", turno=" + turno
				+ ", numAulas=" + numAulas + "]";
	}
	
	
}
