/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

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

    @Path("/insereBanco")
    public void insereBanco() {

        try {

            Process process = Runtime.getRuntime()
                    .exec("C:\\Program Files\\R\\R-3.2.5\\bin\\x64\\Rscript.exe "
                            + "D:\\ProjetoGstat\\src\\main\\webapp\\scripts\\R\\scriptTeste.r 8 9");

            try {
                final BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                String line = null;
                List<String> listaRetorno = new ArrayList<>();
                while ((line = reader.readLine()) != null) {
                    listaRetorno.add(line);
                    System.out.println("LINE " + line);

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

    @Path("/exibeImagem")
    public void exibeImagem() {
        try {
            Process process = Runtime.getRuntime()
                    .exec("C:\\Program Files\\R\\R-3.2.5\\bin\\x64\\Rscript.exe "
                            + "D:\\ProjetoGstat\\src\\main\\webapp\\scripts\\R\\script.r");
            String path = "Rodrigo .png";
            result.include("path", "/file/" + path);

        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
    }

    @Path("/passaParametros")
    public void passaParametros() {
        String x1 = request.getParameter("x1");
        String x2 = request.getParameter("x2");
        System.out.println(request.getMethod());
        System.out.println(x1);
        System.out.println(x2);
        if (request.getMethod().equals("POST")) {

            if (x1 != null && x2 != null) {
                try {

                    Process process = Runtime.getRuntime()
                            .exec("C:\\Program Files\\R\\R-3.2.5\\bin\\x64\\Rscript.exe "
                                    + "D:\\ProjetoGstat\\src\\main\\webapp\\scripts\\R\\scriptTeste.r " + x1 + " " + x2);

                    try {
                        final BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                        String line = null;
                        List<String> listaRetorno = new ArrayList<>();
                        while ((line = reader.readLine()) != null) {
                            listaRetorno.add(line);

                        }
                        result.include("retorno", listaRetorno);
                        reader.close();
                    } catch (final Exception e) {
                        e.printStackTrace();
                    }
                } catch (IOException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }
            } else {
                result.include("retorno", "NÃO FOI POSSÍVEL INSERIR");
            }
        }

    }

    @Path("/gerarAnalise")
    public void gerarAnalise() {
        System.out.println("teste");
        request.getParameter("area");
        request.getParameter("amostra");
        request.getParameter("desc");
        request.getParameter("interpolador");
        request.getParameter("tamx");
        request.getParameter("tamy");
        request.getParameter("expoente");
        request.getParameter("vizinhos");
        request.getParameter("estimador");
        request.getParameter("nlags");
        request.getParameter("npares");
        request.getParameter("nalcance");
        request.getParameter("ncontribuicao");
        request.getParameter("user");
         
       
        if (request.getMethod().equals("POST")) {

            try {

                Process process = Runtime.getRuntime()
                        .exec("C:\\Program Files\\R\\R-3.2.5\\bin\\x64\\Rscript.exe "
                                + "D:\\ProjetoGstat\\src\\main\\webapp\\scripts\\R\\principal.r "
                                + request.getParameter("area") + " " + request.getParameter("amostra")
                                + " " + request.getParameter("desc").replace(" ", "_") + " " + request.getParameter("interpolador") 
                                + " " + request.getParameter("tamx") + " " + request.getParameter("tamy") 
                                + " " + request.getParameter("expoente")+ " " + request.getParameter("vizinhos")
                                + " " + request.getParameter("estimador") + " " + request.getParameter("nlags")
                                + " " + request.getParameter("npares") + " " + request.getParameter("nalcance")
                                + " " + request.getParameter("ncontribuicao") + " " + request.getParameter("user")
                                + " " + request.getParameter("modelo")+ " " + request.getParameter("vlkappa")
                                + " " + request.getParameter("ncontri")+ " " + request.getParameter("nalcance")
                                + " " + request.getParameter("semicorlinha")+ " " + request.getParameter("metodoajust")
                                + " " + request.getParameter("pesos")+ " " + request.getParameter("metodoajust"));

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
            } catch (IOException e1) {
               e1.printStackTrace();
            }
        }
    }

    @Path("/visualizarAnalises")
    public void visualizarAnalises(){
         System.out.println("########################" + System.getProperty("user.dir"));
    }
}
