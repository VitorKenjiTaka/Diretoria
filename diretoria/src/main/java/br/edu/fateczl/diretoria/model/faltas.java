package br.edu.fateczl.diretoria.model;

public class faltas {
	
	private int 	raAluno;
	private String 	codigoDisciplina;
	private String 	dataf;
	private int		presenca;
	
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
	public String getDataf() {
		return dataf;
	}
	public void setDataf(String dataf) {
		this.dataf = dataf;
	}
	public int getPresenca() {
		return presenca;
	}
	public void setPresenca(int presenca) {
		this.presenca = presenca;
	}
	
	@Override
	public String toString() {
		return "faltas [raAluno=" + raAluno + ", codigoDisciplina=" + codigoDisciplina + ", dataf=" + dataf
				+ ", presenca=" + presenca + "]";
	}
}