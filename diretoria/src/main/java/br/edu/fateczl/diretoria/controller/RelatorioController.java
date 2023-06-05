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

@Controller
public class RelatorioController {
	
	@Autowired
	DisciplinaDao dDao;

	@RequestMapping(name = "relatorio", value = "/relatorio", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<String> turnos = new ArrayList<>();
		List<disciplina> disciplinas = new ArrayList<>();
	    turnos.add("T");
	    turnos.add("N");
	    String erro = "";
	    String saida = "";
	    try {
	    	disciplinas = dDao.listarDisciplina();
	    	System.out.println(disciplinas);
	    	
	    } catch (SQLException | ClassNotFoundException e) {
	    	erro = e.getMessage();
	    } finally {
	    	model.addAttribute("saida", saida);
	    	model.addAttribute("erro", erro);
	    	model.addAttribute("disciplinas", disciplinas);
	    	model.addAttribute("turnos", turnos);
	    }
		return new ModelAndView("relatorio");
	}
	
	@RequestMapping(name = "relatorio", value = "/relatorio", method = RequestMethod.POST)
	public ModelAndView insereNota(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		String disciplina = allParam.get("disciplina");
		String turno = allParam.get("turno");
		String saida = "";
		String erro = "";
		
		if(botao.equalsIgnoreCase("Notas")) {
			if(disciplina.equalsIgnoreCase("4203-010") || disciplina.equalsIgnoreCase("4203-020") ||
					disciplina.equalsIgnoreCase("4208-010")	|| disciplina.equalsIgnoreCase("4226-004")) {
				System.out.println("fn_notas_A");
			}
			if(disciplina.equalsIgnoreCase("4213-003") || disciplina.equalsIgnoreCase("4213-013")) {
				System.out.println("fn_notas_B");
			}
			if(disciplina.equalsIgnoreCase("4233-005")) {
				System.out.println("fn_notas_C");
			}
			if(disciplina.equalsIgnoreCase("5005-220")) {
				System.out.println("fn_notas_D");
			}
		}
		if(botao.equalsIgnoreCase("Faltas")) {
			
			
			
		}
		return new ModelAndView("relatorio");
	}	
}