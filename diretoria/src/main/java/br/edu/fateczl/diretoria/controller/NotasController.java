package br.edu.fateczl.diretoria.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.diretoria.model.avaliacao;
import br.edu.fateczl.diretoria.model.disciplina;
import br.edu.fateczl.diretoria.persistence.AvaliacaoDao;
import br.edu.fateczl.diretoria.persistence.DisciplinaDao;
import br.edu.fateczl.diretoria.persistence.NotasDao;

@Controller
public class NotasController {
	
	@Autowired
	DisciplinaDao dDao;
	
	@Autowired
	AvaliacaoDao aDao;
	
	@Autowired
	NotasDao nDao;
	
	@RequestMapping(name = "notas", value = "/notas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<avaliacao> avaliacoes = new ArrayList<>();
		List<disciplina> disciplinas = new ArrayList<>();
	    List<String> turnos = new ArrayList<>();
	    turnos.add("T");
	    turnos.add("N");
	    String erro = "";
	    String saida = "";
	    try {
	    	disciplinas = dDao.listarDisciplina();
	    	System.out.println(disciplinas);
	    	
	    	avaliacoes = aDao.listarAvaliacoes();
	    	System.out.println(avaliacoes);
	    	
	    } catch (SQLException | ClassNotFoundException e) {
	    	erro = e.getMessage();
	    } finally {
	    	model.addAttribute("saida", saida);
	    	model.addAttribute("erro", erro);
	    	model.addAttribute("disciplinas", disciplinas);
	    	model.addAttribute("avaliacoes", avaliacoes);
	    	model.addAttribute("turnos", turnos);
	    }
		return new ModelAndView("notas");
	}

	@RequestMapping(name = "notas", value = "/notas", method = RequestMethod.POST)
	public ModelAndView insereNota(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		String RA = allParam.get("RA");
		Double nota = Double.parseDouble(allParam.get("nota"));
		String avaliacao = allParam.get("avaliacao");
		String disciplina = allParam.get("disciplina");
		String turno = allParam.get("turno");
		String saida = "";
		String erro = "";
		try {
			if(botao.equalsIgnoreCase("Inserir")) {
				System.out.println("Entrou no inserir");
				String codDisciplina = dDao.pegaDisciplina(disciplina, turno);
				int codAvaliacao = aDao.pegarCodigo(avaliacao);
				saida = nDao.inserirNota(RA, codDisciplina, codAvaliacao, nota);
				System.out.println("nota inserida com sucesso");
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("notas");
	}
}