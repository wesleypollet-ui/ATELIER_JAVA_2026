<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Boucles</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les boucles</h1>
<form action="#" method="post">
    <label for="inputValeur">Saisir le nombre d'étoiles : </label>
    <input type="text" id="inputValeur" name="valeur">
    <input type="submit" value="Afficher">
</form>

<%-- Récupération de la valeur saisie par l'utilisateur --%>
<% String valeur = request.getParameter("valeur"); %>
    
<%-- Vérification de l'existence de la valeur --%>
<% if (valeur != null && !valeur.isEmpty()) { %>

<%-- Boucle for pour afficher une ligne d'étoiles --%>
    <%int cpt = Integer.parseInt(valeur); %>
    <p>
    <% for (int i = 1; i <= cpt; i++) { %>
       <%= "*" %>
    <% } %>
    </p>

<h2>Exercice 1 : Le carré d'étoiles</h2>
<p>Ecrire le code afin de produire un carré d'étoile</p>
<p>Exemple si l'utilisateur saisie le valeur 5</p>
<h3>Carré d'étoiles</h3>

<%
for(int i = 1; i <= cpt; i++) {
    for(int j = 1; j <= cpt; j++) {
        out.print("*");
    }
    out.print("<br>");
}
%>

<h2>Exercice 2 : Triangle rectangle gauche</h2>
<p>Ecrire le code afin de produire un triangle rectangle aligné sur la gauche</p>
<p>Exemple si l'utilisateur saisie le valeur 5</p>
<h3>Triangle rectangle gauche</h3>

<%
for(int i = 1; i <= cpt; i++) {
    for(int j = 1; j <= i; j++) {
        out.print("*");
    }
    out.print("<br>");
}
%>

<h2>Exercice 3 : Triangle rectangle inversé</h2>
<p>Ecrire le code afin de produire un triangle rectangle aligné sur la gauche</p>
<p>Exemple si l'utilisateur saisie le valeur 5</p>
<h3>Triangle rectangle inversé</h3>

<%
for(int i = cpt; i >= 1; i--) {
    for(int j = 1; j <= i; j++) {
        out.print("*");
    }
    out.print("<br>");
}
%>

<h2>Exercice 4 : Triangle rectangle 2</h2>
<p>Ecrire le code afin de produire un triangle rectangle aligné sur la droite</p>
<p>Exemple si l'utilisateur saisie le valeur 5</p>
<h3>Triangle aligné à droite</h3>

<%
for(int i = 1; i <= cpt; i++) {

    // espaces
    for(int j = 1; j <= cpt - i; j++) {
        out.print("&nbsp;&nbsp;");
    }

    // étoiles
    for(int j = 1; j <= i; j++) {
        out.print("*");
    }

    out.print("<br>");
}
%>

<h2>Exercice 5 : Triangle isocele</h2>
<p>Ecrire le code afin de produire un triangle rectangle aligné sur la droite</p>
<p>Exemple si l'utilisateur saisie le valeur 5</p>
<h3>Triangle isocèle</h3>

<%
for(int i = 1; i <= cpt; i++) {

    // espaces
    for(int j = 1; j <= cpt - i; j++) {
        out.print("&nbsp;");
    }

    // étoiles
    for(int j = 1; j <= (2 * i - 1); j++) {
        out.print("*");
    }

    out.print("<br>");
}
%>

<h2>Exercice 6 : Le demi losange</h2>
<p>Ecrire le code afin de produire un losange</p>
<p>Exemple si l'utilisateur saisie le valeur 5</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**</br>&nbsp;&nbsp;&nbsp;&nbsp;***</br>&nbsp;&nbsp;****</br>*****</p>
<h3>Demi-losange</h3>

<%
/* Partie montante */
for(int i = 1; i <= cpt; i++) {

    for(int j = 1; j <= cpt - i; j++) {
        out.print("&nbsp;&nbsp;");
    }

    for(int j = 1; j <= i; j++) {
        out.print("*");
    }

    out.print("<br>");
}

/* Partie descendante */
for(int i = cpt - 1; i >= 1; i--) {

    for(int j = 1; j <= cpt - i; j++) {
        out.print("&nbsp;&nbsp;");
    }

    for(int j = 1; j <= i; j++) {
        out.print("*");
    }

    out.print("<br>");
}
%>

<h2>Exercice 7 : La table de multiplication</h2>
<p>Ecrire le code afin de créser une table de multiplication</p>
<p>Exemple si l'utilisateur saisie le valeur 5</p>
<h3>Table de multiplication</h3>

<%
for(int i = 1; i <= 10; i++) {
    out.print(cpt + " x " + i + " = " + (cpt * i));
    out.print("<br>");
}
%>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
