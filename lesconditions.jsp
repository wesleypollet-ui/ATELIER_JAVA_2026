<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercices sur les Conditions</title>
    <link rel="stylesheet" href="style-clean.css">
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">Code <span>X</span></div>
            <a href="index.html" class="nav-link">← Retour</a>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <h1>Exercices sur les Conditions</h1>
            <p>Structures conditionnelles : if, else, else if</p>
        </div>
    </section>

    <section>
        <div class="container">
            <h2>Entrez vos valeurs</h2>
            <form action="#" method="post">
                <label for="valeur1">Valeur 1 :</label>
                <input type="text" id="valeur1" name="valeur1" placeholder="Nombre...">
                
                <label for="valeur2">Valeur 2 :</label>
                <input type="text" id="valeur2" name="valeur2" placeholder="Nombre...">
                
                <label for="valeur3">Valeur 3 :</label>
                <input type="text" id="valeur3" name="valeur3" placeholder="Nombre...">
                
                <input type="submit" value="Analyser">
            </form>
        </section>
        <%-- Récupération des valeurs --%>
        <% String valeur1 = request.getParameter("valeur1"); %>
        <% String valeur2 = request.getParameter("valeur2"); %>
        <% String valeur3 = request.getParameter("valeur3"); %>

        <% if (valeur1 != null && valeur2 != null && valeur3 != null) { %>
            <% int intValeur1 = Integer.parseInt(valeur1); %>
            <% int intValeur2 = Integer.parseInt(valeur2); %>
            <% int intValeur3 = Integer.parseInt(valeur3); %>
            
            <section>
                <div class="container">
                    <h2>Résultats</h2>

                    <h3>Comparaison : Valeur 1 vs Valeur 2</h3>
                    <div class="result-box">
                        <% if (intValeur1 > intValeur2) { %>
                            <p><strong><%= intValeur1 %> est supérieure à <%= intValeur2 %></strong></p>
                        <% } else if (intValeur1 < intValeur2) { %>
                            <p><strong><%= intValeur1 %> est inférieure à <%= intValeur2 %></strong></p>
                        <% } else { %>
                            <p><strong><%= intValeur1 %> est égale à <%= intValeur2 %></strong></p>
                        <% } %>
                    </div>

                    <h3>Valeur 3 entre Valeur 1 et Valeur 2 ?</h3>
                    <div class="result-box">
                        <% if (intValeur3 >= intValeur1 && intValeur3 <= intValeur2) { %>
                            <p><strong>Oui</strong> - <%= intValeur3 %> est compris entre <%= intValeur1 %> et <%= intValeur2 %></p>
                        <% } else { %>
                            <p><strong>Non</strong> - <%= intValeur3 %> n'est pas compris entre <%= intValeur1 %> et <%= intValeur2 %></p>
                        <% } %>
                    </div>

                    <h3>Pair ou Impair ?</h3>
                    <div class="result-box">
                        <% if (intValeur1 % 2 == 0) { %>
                            <p><strong><%= intValeur1 %> est pair</strong></p>
                        <% } else { %>
                            <p><strong><%= intValeur1 %> est impair</strong></p>
                        <% } %>
                    </div>
                </div>
            </section>

        <% } else if (valeur1 != null || valeur2 != null || valeur3 != null) { %>
            <section>
                <div class="container">
                    <h2>Attention</h2>
                    <p>Veuillez remplir les trois valeurs pour voir les résultats.</p>
                </div>
            </section>
        <% } %>

        <section style="border-bottom: none; padding: 2rem 0;">
            <div class="container">
                <a href="index.html" class="nav-link">← Retour à l'accueil</a>
            </div>
        </section>
    </div>
</body>
</html>
