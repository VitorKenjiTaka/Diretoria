package br.edu.fateczl.diretoria.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class NotasDao implements INotasDao{

	@Autowired
	GenericDao gDao;
	
	@Override
	public String inserirNota(String ra, String codDisciplina, int codAvalicao, double nota) throws SQLException, ClassNotFoundException {
		System.out.println("inserindo nota");
		System.out.println("ra: "+ ra);
		System.out.println("codDis: "+ codDisciplina);
		System.out.println("codAval: "+ codAvalicao);
		System.out.println("nota: "+ nota);
		Connection c = gDao.getConnection();
		String sql = "INSERT INTO notas VALUES (?,?,?,?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, ra);
		ps.setString(2, codDisciplina);
		ps.setInt(3, codAvalicao);
		ps.setDouble(4, nota);
		ps.executeQuery();
		ps.close();
		c.close();
		String saida = "Inserido com sucesso";
		return saida;
	}

}
