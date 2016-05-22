<%-- 
    Document   : index
    Created on : 19/03/2016, 14:42:37
    Author     : Dallagnol
--%>

<%@page import="java.io.IOException"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <meta http-equiv="Content-Style-Type" content="text/css">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">    
        
        <title>SAG - Sistema de Analise Geoestatística</title>  

        <script src="<c:url value="./js/jquery-1.10.2.min.js"></c:url>"></script>
        <script src="<c:url value="./js/bootstrap.min.js"></c:url>"></script>
        <link href="<c:url value="./css/bootstrap.min.css"/>" rel="stylesheet"/>
        <link href="<c:url value="./css/bootstrap-responsive.css"/>" rel="stylesheet"/>
        <link rel="shortcut icon" href="./img/favicon.ico">
    </head>

    <body style="background-color: #fafafa;">

        <div id="container-fluid">
            <div class="row-fluid" >
                <div id="header">
                    <div class="navbar navbar-fixed-top">
                        <div class="navbar-inner row-fluid" >                                    
                            <ul class="nav" >
                                <li>
                                    <div style="padding: 4px;"> <img src="./img/logoMenu.png">  </div> </li>
                                <li class="active">
                                    <a href="<c:url value="/"/>">Início</a>
                                      
                                </li>
                            </ul>

                        </div>
                    </div>
                    <br>
                </div>
            </div>      

            <div class="row-fluid" style="padding-top: 1.56%">
                <div class="nav ">
                    <div class="menu-fundo ">
                        <div id="menu"  class="span2">
                        
                            <button type="button" class="btn btn-block" data-toggle="collapse" style="border: 1px solid silver" data-target="#teste">
                                <li class="nav-header"><i class="icon-align-justify"></i> </li>
                            </button>
                            <div class="menu-fundo" style="padding-top: 15px;">

                                <ul class="nav nav-pills ">
                                    <div id="teste"  class="collapse in ">                                       
                                         <li class="nav-header"  style="border-bottom: 1px solid silver; border-right: 1px solid silver">
                                            <a href="<c:url value="/gerarAnalise"/>">Gerar Analise</a>
                                        </li>
                                          <li class="nav-header"  style="border-bottom: 1px solid silver; border-right: 1px solid silver">
                                            <a href="<c:url value="/visualizarAnalises"/>">Visualizar Analises</a>
                                        </li>
                                    </div>
                                </ul>
                            </div>                                                    
                        </div>
                    </div>
                                        
                    <div id="content" class="span10 clearfix">


           
