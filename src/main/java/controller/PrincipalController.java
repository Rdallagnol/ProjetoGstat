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

    @Path("/insereBanco")
    public void insereBanco() {

        try {

            Process process = Runtime.getRuntime()
                    .exec("C:\\Program Files\\R\\R-3.2.3\\bin\\x64\\Rscript.exe "
                            + "D:\\ProjetoMestradoWeb\\src\\main\\webapp\\scripts\\scriptTeste.r 8 9");

            try {
                final BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                String line = null;
                List<String> listaRetorno = new ArrayList<>();
                while ((line = reader.readLine()) != null) {
                    listaRetorno.add(line);
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
                    .exec("C:\\Program Files\\R\\R-3.2.3\\bin\\x64\\Rscript.exe "
                            + "D:\\ProjetoMestradoWeb\\src\\main\\webapp\\scripts\\script.r");

            String path = "Rodrigo .png";
            result.include("path", "./file/" + path);

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
                            .exec("C:\\Program Files\\R\\R-3.2.3\\bin\\x64\\Rscript.exe "
                                    + "D:\\ProjetoMestradoWeb\\src\\main\\webapp\\scripts\\scriptTeste.r " + x1 + " " + x2);

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

}
