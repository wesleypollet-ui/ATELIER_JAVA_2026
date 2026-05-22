<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercices sur les Chaînes</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📝 Exercices sur les Chaînes de caractères</h1>
            <p>Manipulez et analysez du texte avec Java</p>
        </header>

        <section>
            <h2>🔤 Entrez votre texte</h2>
            <form action="#" method="post">
                <label for="inputValeur">Saisir une chaîne (6 caractères minimum) :</label>
                <input type="text" id="inputValeur" name="chaine" placeholder="Entrez du texte...">
                <input type="submit" value="Analyser le texte">
            </form>
        </section>
        <%-- Récupération des valeurs --%>
        <% String chaine = request.getParameter("chaine"); %>
        
        <% if (chaine != null) { %>
            <%-- Obtention de la longueur de la chaîne --%>
            <% int longueurChaine = chaine.length(); %>

            <section>
                <h2>📊 Infos générales sur votre texte</h2>
                <div class="result-box">
                    <p><strong>Texte saisi :</strong> "<%= chaine %>"</p>
                    <p><strong>Longueur :</strong> <%= longueurChaine %> caractères</p>
                </div>
            </section>

            <%-- Extraction du 3° caractère dans votre chaine --%>
            <% char caractereExtrait = chaine.charAt(2); %>
            <section>
                <h2>🔍 Le 3e caractère</h2>
                <div class="result-box">
                    <p>Le 3e caractère est : <strong><%= caractereExtrait %></strong></p>
                </div>
            </section>

            <%-- Obtention d'une sous-chaîne --%>
            <% String sousChaine = chaine.substring(2, 6); %>
            <section>
                <h2>✂️ Sous-chaîne (caractères 3-6)</h2>
                <div class="result-box">
                    <p>Sous-chaîne : <strong><%= sousChaine %></strong></p>
                </div>
            </section>

            <%-- Recherche de la lettre "e" --%>
            <% char recherche = 'e'; 
               int position = chaine.indexOf(recherche); %>
            <section>
                <h2>🎯 Recherche du 'e'</h2>
                <div class="result-box">
                    <% if (position != -1) { %>
                        <p>Le premier 'e' est trouvé à la position : <strong><%= position %></strong></p>
                    <% } else { %>
                        <p>Aucun 'e' trouvé dans votre texte.</p>
                    <% } %>
                </div>
            </section>

            <section>
                <h2>📈 Exercice 1 : Combien de 'e' dans le texte ?</h2>
                <div class="result-box">
                    <% int compteurE = 0;
                    for(int i = 0; i < chaine.length(); i++) {
                        if(chaine.charAt(i) == 'e') {
                            compteurE++;
                        }
                    }
                    %>
                    <p>Nombre de lettres 'e' : <strong><%= compteurE %></strong></p>
                </div>
            </section>

            <section>
                <h2>📑 Exercice 2 : Affichage vertical</h2>
                <p>Chaque caractère sur une nouvelle ligne</p>
                <div class="generated-output"><%
                for(int i = 0; i < chaine.length(); i++) {
                    out.print(chaine.charAt(i));
                    out.print("\n");
                }
                %></div>
            </section>

            <section>
                <h2>🔂 Exercice 3 : Retour à la ligne sur espaces</h2>
                <p>Sauts de ligne à chaque espace rencontré</p>
                <div class="generated-output"><%
                for(int i = 0; i < chaine.length(); i++) {
                    char c = chaine.charAt(i);
                    if(c == ' ') {
                        out.print("\n");
                    } else {
                        out.print(c);
                    }
                }
                %></div>
            </section>

            <section>
                <h2>🎲 Exercice 4 : Une lettre sur deux</h2>
                <div class="generated-output"><%
                for(int i = 0; i < chaine.length(); i = i + 2) {
                    out.print(chaine.charAt(i));
                }
                %></div>
            </section>

            <section>
                <h2>🔄 Exercice 5 : Le texte en verlans</h2>
                <p>Texte inversé</p>
                <div class="generated-output"><%
                for(int i = chaine.length() - 1; i >= 0; i--) {
                    out.print(chaine.charAt(i));
                }
                %></div>
            </section>

            <section>
                <h2>🔤 Exercice 6 : Voyelles et consonnes</h2>
                <div class="result-box">
                    <% int voyelles = 0;
                    int consonnes = 0;
                    for(int i = 0; i < chaine.length(); i++) {
                        char c = Character.toLowerCase(chaine.charAt(i));
                        if(c >= 'a' && c <= 'z') {
                            if(c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'y') {
                                voyelles++;
                            } else {
                                consonnes++;
                            }
                        }
                    }
                    %>
                    <p><strong>Voyelles :</strong> <%= voyelles %></p>
                    <p><strong>Consonnes :</strong> <%= consonnes %></p>
                </div>
            </section>

        <% } else { %>
            <section>
                <h2>📌 Instructions</h2>
                <p>Veuillez entrer un texte avec au moins 6 caractères pour voir les résultats.</p>
            </section>
        <% } %>

        <section>
            <a href="index.html" class="back-link">← Retour au sommaire</a>
        </section>
    </div>
</body>
</html>
