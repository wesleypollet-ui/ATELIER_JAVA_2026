<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercices sur les Boucles</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🌀 Exercices sur les Boucles</h1>
            <p>Maîtrisez les structures itératives avec Java</p>
        </header>

        <section>
            <h2>📝 Entrez une valeur</h2>
            <form action="#" method="post">
                <label for="inputValeur">Saisir le nombre d'étoiles :</label>
                <input type="text" id="inputValeur" name="valeur" placeholder="Entrez un nombre...">
                <input type="submit" value="Afficher les résultats">
            </form>

        </section>

        <%-- Récupération de la valeur saisie par l'utilisateur --%>
        <% String valeur = request.getParameter("valeur"); %>
        
        <%-- Vérification de l'existence de la valeur --%>
        <% if (valeur != null && !valeur.isEmpty()) { %>
            <%int cpt = Integer.parseInt(valeur); %>

            <section>
                <h2>⭐ Ligne d'étoiles</h2>
                <p>Ligne simple générée avec une boucle for</p>
                <div class="generated-output"><% for (int i = 1; i <= cpt; i++) { %>*<% } %></div>
            </section>

            <section>
                <h2>▭ Exercice 1 : Le carré d'étoiles</h2>
                <p>Un carré d'étoiles de taille <%= cpt %> × <%= cpt %></p>
                <div class="generated-output"><%
                for(int i = 1; i <= cpt; i++) {
                    for(int j = 1; j <= cpt; j++) {
                        out.print("*");
                    }
                    out.print("\n");
                }
                %></div>
            </section>

            <section>
                <h2>▲ Exercice 2 : Triangle rectangle gauche</h2>
                <p>Triangle aligné sur la gauche</p>
                <div class="generated-output"><%
                for(int i = 1; i <= cpt; i++) {
                    for(int j = 1; j <= i; j++) {
                        out.print("*");
                    }
                    out.print("\n");
                }
                %></div>
            </section>

            <section>
                <h2>▼ Exercice 3 : Triangle rectangle inversé</h2>
                <p>Triangle inversé</p>
                <div class="generated-output"><%
                for(int i = cpt; i >= 1; i--) {
                    for(int j = 1; j <= i; j++) {
                        out.print("*");
                    }
                    out.print("\n");
                }
                %></div>
            </section>

            <section>
                <h2>▶ Exercice 4 : Triangle rectangle aligné à droite</h2>
                <p>Triangle aligné sur la droite</p>
                <div class="generated-output"><%
                for(int i = 1; i <= cpt; i++) {
                    for(int j = 1; j <= cpt - i; j++) {
                        out.print("&nbsp;");
                    }
                    for(int j = 1; j <= i; j++) {
                        out.print("*");
                    }
                    out.print("\n");
                }
                %></div>
            </section>

            <section>
                <h2>△ Exercice 5 : Triangle isocèle</h2>
                <p>Triangle isocèle centré</p>
                <div class="generated-output"><%
                for(int i = 1; i <= cpt; i++) {
                    for(int j = 1; j <= cpt - i; j++) {
                        out.print("&nbsp;");
                    }
                    for(int j = 1; j <= (2 * i - 1); j++) {
                        out.print("*");
                    }
                    out.print("\n");
                }
                %></div>
            </section>

            <section>
                <h2>◇ Exercice 6 : Le losange (demi)</h2>
                <p>Losange avec partie montante et descendante</p>
                <div class="generated-output"><%
                for(int i = 1; i <= cpt; i++) {
                    for(int j = 1; j <= cpt - i; j++) {
                        out.print("&nbsp;");
                    }
                    for(int j = 1; j <= i; j++) {
                        out.print("*");
                    }
                    out.print("\n");
                }
                for(int i = cpt - 1; i >= 1; i--) {
                    for(int j = 1; j <= cpt - i; j++) {
                        out.print("&nbsp;");
                    }
                    for(int j = 1; j <= i; j++) {
                        out.print("*");
                    }
                    out.print("\n");
                }
                %></div>
            </section>

            <section>
                <h2>× Exercice 7 : Table de multiplication</h2>
                <p>Table de multiplication du nombre <%= cpt %></p>
                <div class="result-box"><%
                for(int i = 1; i <= 10; i++) {
                    out.print(cpt + " × " + i + " = " + (cpt * i));
                    out.print("<br>");
                }
                %></div>
            </section>

        <% } %>

        <section>
            <a href="index.html" class="back-link">← Retour au sommaire</a>
        </section>
    </div>
</body>
</html>
