<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercices sur les Boucles</title>
    <link rel="stylesheet" href="style-clean.css">
</head>
<body>
<%@ include file="header.jspf" %>
    <header>
        <div class="container">
            <div class="logo">Code <span>X</span></div>
            <a href="index.html" class="nav-link">← Retour</a>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <h1>Exercices sur les Boucles</h1>
            <p>Maîtrisez les structures itératives : for, while, do-while</p>
        </div>
    </section>

    <section>
        <div class="container">

        <h2>Saisir une valeur</h2>
            <form action="#" method="post">
                <label for="inputValeur">Nombre d'itérations :</label>
                <input type="text" id="inputValeur" name="valeur" placeholder="Entrez un nombre...">
                <input type="submit" value="Générer">
            </form>

        </section>

        <%-- Récupération de la valeur saisie par l'utilisateur --%>
        <% String valeur = request.getParameter("valeur"); %>
        
        <% if (valeur != null && !valeur.isEmpty()) { %>
            <%int cpt = Integer.parseInt(valeur); %>

            <section>
                <div class="container">
                    <h2>Résultats</h2>

                    <h3>Ligne simple</h3>
                    <div class="generated-output"><% for (int i = 1; i <= cpt; i++) { %>*<% } %></div>

                    <h3>Carré</h3>
                    <div class="generated-output"><%
                    for(int i = 1; i <= cpt; i++) {
                        for(int j = 1; j <= cpt; j++) {
                            out.print("*");
                        }
                        out.print("\n");
                    }
                    %></div>

                    <h3>Triangle - Croissant</h3>
                    <div class="generated-output"><%
                    for(int i = 1; i <= cpt; i++) {
                        for(int j = 1; j <= i; j++) {
                            out.print("*");
                        }
                        out.print("\n");
                    }
                    %></div>

                    <h3>Triangle - Décroissant</h3>
                    <div class="generated-output"><%
                    for(int i = cpt; i >= 1; i--) {
                        for(int j = 1; j <= i; j++) {
                            out.print("*");
                        }
                        out.print("\n");
                    }
                    %></div>

                    <h3>Triangle - Aligné à droite</h3>
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

                    <h3>Triangle - Isocèle</h3>
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

                    <h3>Losange</h3>
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

                    <h3>Table de multiplication</h3>
                    <div class="result-box"><%
                    for(int i = 1; i <= 10; i++) {
                        out.print(cpt + " × " + i + " = " + (cpt * i));
                        out.print("<br>");
                    }
                    %></div>
                </div>
            </section>

        <% } %>

        <section style="border-bottom: none; padding: 2rem 0;">
            <div class="container">
                <a href="index.html" class="nav-link">← Retour à l'accueil</a>
            </div>
        </section>
    </div>
<%@ include file="footer.jspf" %>
</body>
</html>
