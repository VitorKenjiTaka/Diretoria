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

import br.edu.fateczl.diretoria.model.disciplina;
import br.edu.fateczl.diretoria.persistence.DisciplinaDao;
import br.edu.fateczl.diretoria.persistence.FaltasDao;

@Controller
public class FaltasController {
	
	@Autowired
	DisciplinaDao dDao;
	
	@Autowired
	FaltasDao fDao;
	
	@RequestMapping(name = "faltas", value = "/faltas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<disciplina> disciplinas = new ArrayList<>();
		List<String> turnos = new ArrayList<>();
		List<String> numFalta = new ArrayList<>();
	    String erro = "";
	    String saida = "";
	    turnos.add("T");
	    turnos.add("N");
	    numFalta.add("PPPP");
	    numFalta.add("PPPF");
	    numFalta.add("PPFF");
	    numFalta.add("PFFF");
	    numFalta.add("FFFF");
	    numFalta.add("PP");
	    numFalta.add("PF");
	    numFalta.add("FF");
	    try {
	    	disciplinas = dDao.listarDisciplina();
	    } catch (SQLException | ClassNotFoundException e) {
	    	erro = e.getMessage();
	    } finally {
	    	model.addAttribute("saida", saida);
	    	model.addAttribute("erro", erro);
	    	model.addAttribute("disciplinas", disciplinas);
	    	model.addAttribute("faltas", numFalta);
	    	model.addAttribute("turnos", turnos);
	    }
		return new ModelAndView("faltas");
	}
	
	@RequestMapping(name = "faltas", value = "/faltas", method = RequestMethod.POST)
	public ModelAndView insereFalta(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		String RA = allParam.get("RA");
		String disciplina = allParam.get("disciplina");
		String turno = allParam.get("turno");
		String dataFalta = allParam.get("dataFalta");
		String numFalta = allParam.get("falta");
		String saida = "";
		String erro = "";
		try {
			if(botao.equalsIgnoreCase("Inserir")) {
				System.out.println("Entrou no inserir");
				String codDisciplina = dDao.pegaDisciplina(disciplina, turno);
				saida = fDao.inserirFalta(RA, codDisciplina, dataFalta, numFalta);
				System.out.println("presença inserida com sucesso");
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("faltas");
	}
}