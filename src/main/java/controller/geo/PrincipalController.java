/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.geo;

import config.Constantes;
import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import dao.AmostraDao;
import entity.AmostraEntity;
import entity.AnaliseEntity;
import entity.AnaliseLinesEntity;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import utils.DaoFactory;

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

        result.include("areas",
                DaoFactory.areaDaoInstance().findAll());

        if (request.getMethod().equals("POST")) {
            try {

                Process process = Runtime.getRuntime()
                        .exec(Constantes.ENDERECO_R
                                + Constantes.ENDERECO_GEO_S
                                + Constantes.ENDERECO_FILE + " "
                                + Constantes.DATA_BASE_NAME + " "
                                + Constantes.DATA_BASE_HOST + " "
                                + Constantes.DATA_BASE_USER + " "
                                + Constantes.DATA_BASE_PASSWORD + " "
                                + Constantes.DATA_BASE_PORT + " "
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
                                + request.getParameter("nro_pares") + " "
                                + request.getParameter("nro_min_contr") + " "
                                + request.getParameter("nro_min_alc") + " "
                        );

                try {
                    String ok = null;
                    
                    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                    String line = null;
                    
                    while ((line = reader.readLine()) != null) {
                        //System.out.println(line);
                        if (line.equals("[1] 9999")) {
                            ok = "OK";
                        }
                    }

                    if (ok != null) {
                        result.redirectTo(this).visualizaGeo();
                    } else {
                        result.include("errorMsg", "Não foi possível realizar a analise favor verificar dados !");
                    }
                } catch (final IOException e) {
                    e.printStackTrace();
                }
            } catch (IOException e1) {
                e1.printStackTrace();
            }

        }
    }

    @Path("/funcaoKrigagem")
    public void funcaoKrigagem() {

        if (request.getMethod().equals("POST")) {
            try {

                Process process = Runtime.getRuntime()
                        .exec(Constantes.ENDERECO_R
                                + Constantes.ENDERECO_KRIG_S
                                + Constantes.ENDERECO_MAPA + " "
                                + Constantes.DATA_BASE_NAME + " "
                                + Constantes.DATA_BASE_HOST + " "
                                + Constantes.DATA_BASE_USER + " "
                                + Constantes.DATA_BASE_PASSWORD + " "
                                + Constantes.DATA_BASE_PORT + " "
                                + request.getParameter("user") + " "
                                + request.getParameter("analise_line_id") + " "
                        );

                try {
                    final BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                    String line = null;
                    String ok = null;
                    while ((line = reader.readLine()) != null) {
                       // System.out.println(line);
                        if (line.equals("[1] 9999")) {
                            ok = "OK";
                        }
                    }
                    reader.close();
                    if (ok != null) {
                        result.redirectTo(this).visualizaMapa(request.getParameter("analise_line_id"), request.getParameter("user"));
                    } else {
                        result.include("errorMsg", "Não foi possível realizar a analise favor verificar dados !");
                    }
                } catch (final Exception e) {
                    e.printStackTrace();
                }
            } catch (IOException e1) {
                e1.printStackTrace();
            }

        }
    }

    @Get("/buscaAmostrasDaArea")
    public void buscaAmostrasDaArea(Long idArea) {
        AmostraDao amostraDao = DaoFactory.amostraDaoInstance();
        List<AmostraEntity> amostras = amostraDao.findByIdArea(idArea);
        result.use(Results.json()).withoutRoot().from(amostras).serialize();
    }

    @Path("/visualizaGeo")
    public void visualizaGeo() {

        result.include("analises", DaoFactory.analiseInstance().findAllOrdenado());

        if (request.getMethod().equals("POST")) {

            String descricao = null;
            Long userId = null;   
            
            result.include("analiseLines",
                    DaoFactory.analiseLineInstance()
                            .findByArea(Long.parseLong(request.getParameter("analiseId"))));

            List<AnaliseEntity> analise
                    = DaoFactory.analiseInstance()
                            .findById(Long.parseLong(request.getParameter("analiseId")));

            for (AnaliseEntity analiseEntity : analise) {
                descricao = analiseEntity.getDescricao_analise();
                userId = analiseEntity.getCreated_by();
            }

            result.include("userID", userId);
            result.include("analiseDesc", descricao);
            
        }
    }

    @Path("/visualizaMapa")
    public void visualizaMapa(String lineId, String userID) {
        System.out.println(lineId);   
        System.out.println(userID);   
        
        result.include("userID", userID);
        result.include("lineId", lineId);
    }
}
