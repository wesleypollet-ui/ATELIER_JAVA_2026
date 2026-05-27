<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercices sur les Tableaux</title>
    <link rel="stylesheet" href="style-clean.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="header.jspf" %>
    <div class="container">
        <header>
            <h1>📊 Exercices sur les Tableaux</h1>
            <p>Manipulez et analysez des collections de données</p>
        </header>

        <section>
            <h2>🔢 Entrez vos nombres</h2>
            <form action="#" method="post">
                <label for="inputValeur">Saisir au minimum 3 chiffres (séparés par des espaces) :</label>
                <input type="text" id="inputValeur" name="chaine" placeholder="Exemple: 6 78 15 42...">
                <input type="submit" value="Analyser le tableau">
            </form>
        </section>
        <%-- Récupération des valeurs --%>
        <% String chaine = request.getParameter("chaine"); %>
        
        <% if (chaine != null) { %>
            <%-- Division de la chaîne de chiffres séparés par des espaces --%>
            <% String[] tableauDeChiffres = chaine.split("\\s+"); %>

            <section>
                <h2>📋 Contenu du tableau</h2>
                <div class="result-box">
                    <p><strong>Nombre de valeurs :</strong> <%= tableauDeChiffres.length %></p>
                    <p><strong>Valeurs :</strong></p>
                    <% for (int i = 0; i < tableauDeChiffres.length; i++) { %>
                        <p>&nbsp;&nbsp;[<%= i %>] = <%= tableauDeChiffres[i] %></p>
                    <% } %>
                </div>
            </section>

            <section>
                <h2>² Exercice 1 : Le carré de la première valeur</h2>
                <%
                int premiereValeur = Integer.parseInt(tableauDeChiffres[0]);
                int carre = premiereValeur * premiereValeur;
                %>
                <div class="result-box">
                    <p>Valeur : <%= premiereValeur %></p>
                    <p><strong>Carré :</strong> <%= premiereValeur %> × <%= premiereValeur %> = <strong><%= carre %></strong></p>
                </div>
            </section>

            <section>
                <h2>➕ Exercice 2 : La somme des 2 premières valeurs</h2>
                <%
                int valeur1 = Integer.parseInt(tableauDeChiffres[0]);
                int valeur2 = Integer.parseInt(tableauDeChiffres[1]);
                int somme2 = valeur1 + valeur2;
                %>
                <div class="result-box">
                    <p>Valeur 1 : <%= valeur1 %></p>
                    <p>Valeur 2 : <%= valeur2 %></p>
                    <p><strong>Somme :</strong> <%= valeur1 %> + <%= valeur2 %> = <strong><%= somme2 %></strong></p>
                </div>
            </section>

            <section>
                <h2>✚ Exercice 3 : La somme de toutes les valeurs</h2>
                <%
                int somme = 0;
                for(int i = 0; i < tableauDeChiffres.length; i++) {
                    somme = somme + Integer.parseInt(tableauDeChiffres[i]);
                }
                %>
                <div class="result-box">
                    <p><strong>Somme totale :</strong> <strong style="color: var(--primary-blue);"><%=  somme %></strong></p>
                </div>
            </section>

            <section>
                <h2>📈 Exercice 4 : La valeur maximum</h2>
                <%
                int maximum = Integer.parseInt(tableauDeChiffres[0]);
                for(int i = 1; i < tableauDeChiffres.length; i++) {
                    int valeur = Integer.parseInt(tableauDeChiffres[i]);
                    if(valeur > maximum) {
                        maximum = valeur;
                    }
                }
                %>
                <div class="result-box">
                    <p><strong>Valeur maximale :</strong> <strong style="color: var(--primary-blue);"><%=  maximum %></strong></p>
                </div>
            </section>

            <section>
                <h2>📉 Exercice 5 : La valeur minimum</h2>
                <%
                int minimum = Integer.parseInt(tableauDeChiffres[0]);
                for(int i = 1; i < tableauDeChiffres.length; i++) {
                    int valeur = Integer.parseInt(tableauDeChiffres[i]);
                    if(valeur < minimum) {
                        minimum = valeur;
                    }
                }
                %>
                <div class="result-box">
                    <p><strong>Valeur minimale :</strong> <strong style="color: var(--primary-blue);"><%=  minimum %></strong></p>
                </div>
            </section>

            <section>
                <h2>🎯 Exercice 6 : Valeur la plus proche de 0</h2>
                <%
                int procheZero = Integer.parseInt(tableauDeChiffres[0]);
                for(int i = 1; i < tableauDeChiffres.length; i++) {
                    int valeur = Integer.parseInt(tableauDeChiffres[i]);
                    if(Math.abs(valeur) < Math.abs(procheZero)) {
                        procheZero = valeur;
                    }
                }
                %>
                <div class="result-box">
                    <p><strong>Valeur la plus proche de 0 :</strong> <strong style="color: var(--primary-blue);"><%=  procheZero %></strong> (distance: <%= Math.abs(procheZero) %>)</p>
                </div>
            </section>

            <section>
                <h2>🎯 Exercice 7 : Plus proche de 0 (v2 - avec priorité positive)</h2>
                <p>En cas d'égalité (ex: -5 et 5), on affiche la valeur positive</p>
                <%
                int procheZero2 = Integer.parseInt(tableauDeChiffres[0]);
                for(int i = 1; i < tableauDeChiffres.length; i++) {
                    int valeur = Integer.parseInt(tableauDeChiffres[i]);
                    if(Math.abs(valeur) < Math.abs(procheZero2)) {
                        procheZero2 = valeur;
                    } else if(Math.abs(valeur) == Math.abs(procheZero2) && valeur > procheZero2) {
                        procheZero2 = valeur;
                    }
                }
                %>
                <div class="result-box">
                    <p><strong>Valeur la plus proche de 0 :</strong> <strong style="color: var(--primary-blue);"><%=  procheZero2 %></strong> (distance: <%= Math.abs(procheZero2) %>)</p>
                </div>
            </section>

        <% } else { %>
            <section>
                <h2>📌 Instructions</h2>
                <p>Entrez au minimum 3 chiffres séparés par des espaces (exemple: <strong>6 78 15 42</strong>)</p>
            </section>
        <% } %>

        <section>
            <a href="index.html" class="back-link">← Retour au sommaire</a>
        </section>
    </div>
<%@ include file="footer.jspf" %>
</body>
</html>
