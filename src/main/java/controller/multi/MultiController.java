/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.multi;

import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Result;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Dallagnol
 */
@Controller
public class MultiController {

    @Inject
    private Result result;

    @Inject
    private HttpServletRequest request;


    @Path("/sele_var")
    public void sele_var() {

    }
    @Path("/sele_var_2")
    public void sele_var_2() {

    }
    
    @Path("/sele_agru")
    public void sele_agru() {

    }
}
