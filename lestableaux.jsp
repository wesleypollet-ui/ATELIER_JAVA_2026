<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les tableaux</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les tableaux</h1>
<form action="#" method="post">
    <p>Saisir au minimu 3 chiffres à la suite, exemple : 6 78 15 <input type="text" id="inputValeur" name="chaine">
    <p><input type="submit" value="Afficher">
</form>
<%-- Récupération des valeurs --%>
    <% String chaine = request.getParameter("chaine"); %>
    
    <% if (chaine != null) { %>

    <%-- Division de la chaîne de chiffres séparés par des espaces --%>
    <% String[] tableauDeChiffres = chaine.split("\\s+"); %>
    <p>Le tableau contient <%= nombres.length %> valeurs<br/>
    <% for (int i = 0; i < nombres.length; i++) { %>
    <p>Chiffre <%= i + 1 %> : <%= nombres[i] %></p>
    <% } %>
    
<h2>Exercice 1 : La carré de la première valeur</h2>
<p>Ecrire un programme afin d'afficher le carré de la première valeur</p>
<%
int premiereValeur = Integer.parseInt(tableauDeChiffres[0]);
int carre = premiereValeur * premiereValeur;
%>

<p>Le carré de la première valeur est : <%= carre %></p>

<h2>Exercice 2 : La somme des 2 premières valeurs</h2>
<p>Ecrire un programme afin d'afficher la somme des deux premières valeurs</p>
<%
int valeur1 = Integer.parseInt(tableauDeChiffres[0]);
int valeur2 = Integer.parseInt(tableauDeChiffres[1]);

int somme2 = valeur1 + valeur2;
%>

<p>La somme des deux premières valeurs est : <%= somme2 %></p>

<h2>Exercice 3 : La somme de toutes les valeurs</h2>
<p>L'utilisateur peut à présent saisir autant de valeurs qu'il le souhaite dans champs de saisie.</br>
Ecrire un programme afin de faire la somme de toutes les valeurs saisie par l'utilisateur</p>
<%
int somme = 0;

for(int i = 0; i < tableauDeChiffres.length; i++) {

    somme = somme + Integer.parseInt(tableauDeChiffres[i]);
}
%>

<p>La somme totale est : <%= somme %></p>

<h2>Exercice 4 : La valeur maximum</h2>
<p>Ecrire un programme pour afficher la valeur maximale saisie par l'utilisateur</p>
<%
int maximum = Integer.parseInt(tableauDeChiffres[0]);

for(int i = 1; i < tableauDeChiffres.length; i++) {

    int valeur = Integer.parseInt(tableauDeChiffres[i]);

    if(valeur > maximum) {
        maximum = valeur;
    }
}
%>

<p>La valeur maximale est : <%= maximum %></p>

<h2>Exercice 5 : La valeur minimale</h2>
<p>Ecrire un programme pour afficher la valeur minimale saisie par l'utilisateur</p>
<%
int minimum = Integer.parseInt(tableauDeChiffres[0]);

for(int i = 1; i < tableauDeChiffres.length; i++) {

    int valeur = Integer.parseInt(tableauDeChiffres[i]);

    if(valeur < minimum) {
        minimum = valeur;
    }
}
%>

<p>La valeur minimale est : <%= minimum %></p>

<h2>Exercice 6 : La valeur le plus proche de 0</h2>
<p>Trouvez la valeur la plus proche de 0 (chiffres positifs ou négatifs)</p>
<%
int procheZero = Integer.parseInt(tableauDeChiffres[0]);

for(int i = 1; i < tableauDeChiffres.length; i++) {

    int valeur = Integer.parseInt(tableauDeChiffres[i]);

    if(Math.abs(valeur) < Math.abs(procheZero)) {

        procheZero = valeur;
    }
}
%>

<p>La valeur la plus proche de 0 est : <%= procheZero %></p>

<h2>Exercice 7 : La valeur le plus proche de 0 (2° version)</h2>
<p>Trouvez la valeur la plus proche de 0 (chiffres positifs ou négatifs)</p>
<p>En cas d'égalité entre un chiffre positif et négatif, affichez le chiffre positif</p>
<%
int procheZero2 = Integer.parseInt(tableauDeChiffres[0]);

for(int i = 1; i < tableauDeChiffres.length; i++) {

    int valeur = Integer.parseInt(tableauDeChiffres[i]);

    if(Math.abs(valeur) < Math.abs(procheZero2)) {

        procheZero2 = valeur;

    } else if(Math.abs(valeur) == Math.abs(procheZero2)
              && valeur > procheZero2) {

        procheZero2 = valeur;
    }
}
%>

<p>La valeur la plus proche de 0 est : <%= procheZero2 %></p>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
