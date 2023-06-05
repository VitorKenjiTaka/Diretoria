package br.edu.fateczl.diretoria.persistence;

import java.sql.SQLException;

public interface INotasDao {
	
	public String inserirNota(String ra, String codDisciplina, int codAvalicao, double nota)throws SQLException, ClassNotFoundException;
	
}				