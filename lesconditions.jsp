<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercices sur les Conditions</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <header>
            <h1>❓ Exercices sur les Conditions</h1>
            <p>Apprenez les structures conditionnelles if, else et else if</p>
        </header>

        <section>
            <h2>📝 Entrez vos valeurs</h2>
            <form action="#" method="post">
                <label for="valeur1">Saisir la valeur 1 :</label>
                <input type="text" id="valeur1" name="valeur1" placeholder="Nombre...">
                
                <label for="valeur2">Saisir la valeur 2 :</label>
                <input type="text" id="valeur2" name="valeur2" placeholder="Nombre...">
                
                <label for="valeur3">Saisir la valeur 3 :</label>
                <input type="text" id="valeur3" name="valeur3" placeholder="Nombre...">
                
                <input type="submit" value="Analyser les conditions">
            </form>
        </section>
        <%-- Récupération des valeurs --%>
        <% String valeur1 = request.getParameter("valeur1"); %>
        <% String valeur2 = request.getParameter("valeur2"); %>
        <% String valeur3 = request.getParameter("valeur3"); %>

        <%-- Vérification de la condition entre les deux valeurs --%>
        <% if (valeur1 != null && valeur2 != null && valeur3 != null) { %>
            <%-- Conversion des valeurs en entiers pour la comparaison --%>
            <% int intValeur1 = Integer.parseInt(valeur1); %>
            <% int intValeur2 = Integer.parseInt(valeur2); %>
            <% int intValeur3 = Integer.parseInt(valeur3); %>
            
            <section>
                <h2>🔍 Comparaison : Valeur 1 vs Valeur 2</h2>
                <div class="result-box">
                    <% if (intValeur1 > intValeur2) { %>
                        <p><strong>Résultat :</strong> Valeur 1 (<%= intValeur1 %>) est <span style="color: var(--primary-blue);">supérieure</span> à Valeur 2 (<%= intValeur2 %>)</p>
                    <% } else if (intValeur1 < intValeur2) { %>
                        <p><strong>Résultat :</strong> Valeur 1 (<%= intValeur1 %>) est <span style="color: var(--primary-blue);">inférieure</span> à Valeur 2 (<%= intValeur2 %>)</p>
                    <% } else { %>
                        <p><strong>Résultat :</strong> Valeur 1 (<%= intValeur1 %>) est <span style="color: var(--primary-blue);">égale</span> à Valeur 2 (<%= intValeur2 %>)</p>
                    <% } %>
                </div>
            </section>

            <section>
                <h2>📍 Exercice 1 : Valeur 3 entre Valeur 1 et Valeur 2</h2>
                <p>Vérifions si la valeur 3 est comprise entre les valeurs 1 et 2</p>
                <div class="result-box">
                    <% if (intValeur3 >= intValeur1 && intValeur3 <= intValeur2) { %>
                        <p><strong>✓ Oui</strong> - <%= intValeur3 %> est compris entre <%= intValeur1 %> et <%= intValeur2 %></p>
                    <% } else { %>
                        <p><strong>✗ Non</strong> - <%= intValeur3 %> n'est pas compris entre <%= intValeur1 %> et <%= intValeur2 %></p>
                    <% } %>
                </div>
            </section>

            <section>
                <h2>🔢 Exercice 2 : Pair ou Impair ?</h2>
                <p>Vérification de la parité de Valeur 1 : <%= intValeur1 %></p>
                <div class="result-box">
                    <% if (intValeur1 % 2 == 0) { %>
                        <p><strong style="color: var(--primary-blue);">PAIR</strong> - <%= intValeur1 %> est divisible par 2</p>
                    <% } else { %>
                        <p><strong style="color: var(--accent-violet);">IMPAIR</strong> - <%= intValeur1 %> n'est pas divisible par 2</p>
                    <% } %>
                </div>
            </section>

        <% } else if (valeur1 != null || valeur2 != null || valeur3 != null) { %>
            <section>
                <h2>⚠️ Attention</h2>
                <p>Veuillez remplir les trois valeurs pour voir les résultats.</p>
            </section>
        <% } %>

        <section>
            <a href="index.html" class="back-link">← Retour au sommaire</a>
        </section>
    </div>
</body>
</html>
