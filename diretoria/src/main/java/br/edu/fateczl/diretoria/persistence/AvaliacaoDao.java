package br.edu.fateczl.diretoria.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.edu.fateczl.diretoria.model.avaliacao;

@Component
public class AvaliacaoDao implements IAvaliacaoDao{

	@Autowired
	GenericDao gDao;
	
	@Override
	public List<avaliacao> listarAvaliacoes() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<avaliacao> avaliacoes = new ArrayList<avaliacao>();
		
		String sql = "SELECT codigo, tipo FROM avaliacao";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			avaliacao a = new avaliacao();
			a.setCodigo(rs.getInt("codigo"));
			a.setTipo(rs.getString("tipo"));
			avaliacoes.add(a);
		}
		rs.close();
		ps.close();
		c.close();
		return avaliacoes;
	}

	@Override
	public int pegarCodigo(String tipo) throws SQLException, ClassNotFoundException {
		System.out.println("Pegando codigo da avaliacao");
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo FROM avaliacao\r\n"
				+ "WHERE tipo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, tipo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int cod =  rs.getInt("codigo");
		rs.close();
		ps.close();
		c.close();
		System.out.println(cod);
		return cod;
	}
}