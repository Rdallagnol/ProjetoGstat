/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.geo;

import config.Constantes;
import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Result;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Dallagnol
 */
@Controller
public class PrincipalController {

    @Inject
    private Result result;

    @Inject
    private HttpServletRequest request;

    @Path("/")
    public void index() {

    }

    @Path("/funcaoGeo")
    public void funcaoGeo() {

        if (request.getMethod().equals("POST")) {
            try {
                System.out.println(Constantes.ENDERECO_FILE);
                String userID = request.getParameter("user");
                String analiseDesc = request.getParameter("desc");

                Process process = Runtime.getRuntime()
                        .exec(Constantes.ENDERECO_R + Constantes.ENDERECO_GEO_S
                                + Constantes.ENDERECO_FILE + " "
                                + request.getParameter("user") + " "
                                + request.getParameter("area") + " "
                                + request.getParameter("amostra") + " "
                                + '"' + request.getParameter("desc") + '"' + " "
                                + request.getParameter("isi") + " "
                                + request.getParameter("v_lambda") + " "
                                + request.getParameter("auto_lags") + " "
                                + request.getParameter("nro_lags") + " "
                                + request.getParameter("estimador") + " "
                                + request.getParameter("cutoff") + " "
                                + request.getParameter("tamx") + " "
                                + request.getParameter("tamy") + " "
                                + request.getParameter("nro_intervalos_alc") + " "
                                + request.getParameter("nro_intervalos_contr") + " "
                                + request.getParameter("nro_pares") + " ");

                try {
                    final BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                    String line = null;
                    List<String> listaRetorno = new ArrayList<>();
                    while ((line = reader.readLine()) != null) {
                        listaRetorno.add(line);
                        System.out.println(line);
                    }
                    result.include("retorno", listaRetorno);
                    reader.close();
                } catch (final Exception e) {
                    e.printStackTrace();
                }
                System.out.println(userID);
                System.out.println(analiseDesc);
                result.redirectTo(PrincipalController.class).visualizaGeo();
            } catch (IOException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }

        }
    }

    @Path("/visualizaGeo")
    public void visualizaGeo() {
        if (request.getMethod().equals("POST")) {           
            result.include("userID", request.getParameter("userID"));
            result.include("analiseDesc", request.getParameter("analiseDesc"));
        }
    }

    @Path("/funcaoPrincipal")
    public void funcaoPrincipal() {

        try {

            Process process = Runtime.getRuntime()
                    .exec("C:\\Program Files\\R\\R-3.2.5\\bin\\x64\\Rscript.exe "
                            + "D:\\ProjetoGstat\\src\\main\\webapp\\scripts\\R\\script_KO.r");

            try {
                final BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                String line = null;
                List<String> listaRetorno = new ArrayList<>();

                while ((line = reader.readLine()) != null) {

                    /**
                     * Função que remove indentificador string
                     */
                    int inicioString = line.indexOf("[");
                    int fimString = line.indexOf("]");
                    String textSubs = "";
                    String alterarPor = line.substring(inicioString, fimString + 1);

                    listaRetorno.add(line.replace(alterarPor, textSubs));
                    System.out.println("LINE " + line.replace(alterarPor, textSubs));

                }
                result.include("mensagem", listaRetorno);
                reader.close();
            } catch (final Exception e) {
                e.printStackTrace();
            }
        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
    }

}