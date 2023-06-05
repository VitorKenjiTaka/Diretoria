package br.edu.fateczl.diretoria.persistence;

import java.sql.SQLException;
import java.util.List;
import br.edu.fateczl.diretoria.model.disciplina;

public interface IDisciplinaDao {

	public List<disciplina> listarDisciplina()  throws SQLException, ClassNotFoundException;
	public String pegaDisciplina(String nome, String turno)throws SQLException, ClassNotFoundException;
	
}
