package br.edu.fateczl.diretoria.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FaltasDao implements IFaltasDao {

	@Autowired
	GenericDao gDao;

	@Override
	public String inserirFalta(String ra, String codDisciplina, String data, String falta) throws SQLException, ClassNotFoundException {
		System.out.println("inserindo falta");
		System.out.println("ra: "+ ra);
		System.out.println("codDis: "+ codDisciplina);
		System.out.println("data: "+ data);
		System.out.println("falta: "+ falta);
		Connection c = gDao.getConnection();
		String sql = "INSERT INTO faltas VALUES (?,?,?,?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, ra);
		ps.setString(2, codDisciplina);
		ps.setString(3, data);
		ps.setString(4, falta);
		ps.executeQuery();
		ps.close();
		c.close();
		String saida = "Inserido com sucesso";
		return saida;
	}
	
	
}
