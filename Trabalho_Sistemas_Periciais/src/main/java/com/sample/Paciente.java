package com.sample;

public class Paciente {
	private String nome;
	private int idade;
	private int NIF;
	private String diagnostico;
	
	public Paciente(String nome, int idade, int nIF, String diagnostico) {
		super();
		this.nome = nome;
		this.idade = idade;
		NIF = nIF;
		this.diagnostico = diagnostico;
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

	public String getDiagnostico() {
		return diagnostico;
	}

	public void setDiagnostico(String diagnostico) {
		this.diagnostico = diagnostico;
	}
	
	
}
