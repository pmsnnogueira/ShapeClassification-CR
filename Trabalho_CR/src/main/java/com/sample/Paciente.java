package com.sample;

public class Paciente {
	private String nome;
	private int idade;
	private int NIF;
	private String diagnosticos;
	private String data_prox_consulta;
	
	public Paciente(String nome, int idade, int nIF, String diagnosticos, String data_prox_consulta) {
		super();
		this.nome = nome;
		this.idade = idade;
		NIF = nIF;
		this.diagnosticos = diagnosticos;
		this.data_prox_consulta = data_prox_consulta;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public int getIdade() {
		return idade;
	}

	public void setIdade(int idade) {
		this.idade = idade;
	}

	public int getNIF() {
		return NIF;
	}

	public void setNIF(int nIF) {
		NIF = nIF;
	}

	public String getDiagnosticos() {
		return diagnosticos;
	}

	public void setDiagnosticos(String diagnosticos) {
		this.diagnosticos = diagnosticos;
	}

	public String getData_prox_consulta() {
		return data_prox_consulta;
	}

	public void setData_prox_consulta(String data_prox_consulta) {
		this.data_prox_consulta = data_prox_consulta;
	}
	
	
}
