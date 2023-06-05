package br.edu.fateczl.diretoria.persistence;

import java.sql.SQLException;

public interface IFaltasDao {
	
	public String inserirFalta(String ra, String codDisciplina, String data, String falta)throws SQLException, ClassNotFoundException;
	
}
