package com.sample;

public class Suspeita_Clinica {
	Paciente paciente;
	private String suspeita;
	
	public Suspeita_Clinica(Paciente paciente, String suspeita) {
		super();
		this.paciente = paciente;
		this.suspeita = suspeita;
	}

	public Paciente getPaciente() {
		return paciente;
	}

	public void setPaciente(Paciente paciente) {
		this.paciente = paciente;
	}

	public String getSuspeita() {
		return suspeita;
	}

	public void setSuspeita(String suspeita) {
		this.suspeita = suspeita;
	}
	
	
}
