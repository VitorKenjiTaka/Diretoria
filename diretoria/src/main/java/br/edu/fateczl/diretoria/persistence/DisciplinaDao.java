package br.edu.fateczl.diretoria.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.edu.fateczl.diretoria.model.disciplina;

@Component
public class DisciplinaDao implements IDisciplinaDao {

	@Autowired
	GenericDao gDao;

	@Override
	public List<disciplina> listarDisciplina() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<disciplina> disciplinas = new ArrayList<disciplina>();
		
		String sql = "SELECT DISTINCT nome FROM disciplina";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			disciplina d = new disciplina();
			d.setNome(rs.getString("nome"));
			disciplinas.add(d);
		}
		rs.close();
		ps.close();
		c.close();
		return disciplinas;
	}

	@Override
	public String pegaDisciplina(String nome, String turno) throws SQLException, ClassNotFoundException {
		System.out.println("Pegando disciplina");
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo FROM disciplina";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		String codDisciplina = rs.getString("codigo");
		rs.close();
		ps.close();
		c.close();
		System.out.println("codDisciplina: "+ codDisciplina);
		return codDisciplina;
	}
	
}
