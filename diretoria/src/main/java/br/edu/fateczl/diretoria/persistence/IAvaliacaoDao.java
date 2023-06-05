package br.edu.fateczl.diretoria.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.diretoria.model.avaliacao;

public interface IAvaliacaoDao {

	public List<avaliacao> listarAvaliacoes()  throws SQLException, ClassNotFoundException;
	public int pegarCodigo(String tipo)  throws SQLException, ClassNotFoundException;
}
