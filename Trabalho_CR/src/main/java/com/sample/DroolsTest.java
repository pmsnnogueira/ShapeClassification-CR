package com.sample;

import com.sample.Paciente;
import com.sample.Suspeita_Clinica;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

/**
 * This is a sample class to launch a rule.
 */
public class DroolsTest {

    public static final void main(String[] args) {
        try {
            // load up the knowledge base
	        KieServices ks = KieServices.Factory.get();
    	    KieContainer kContainer = ks.getKieClasspathContainer();
        	KieSession kSession = kContainer.newKieSession("ksession-rules");

            // go !
            Paciente p1 = new Paciente("Arca",24,299999999,"Checkup","");
            kSession.insert(p1);
            Suspeita_Clinica sc1 = new Suspeita_Clinica(p1,"BAIXA");
            kSession.insert(sc1);
            kSession.fireAllRules();
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }

}
