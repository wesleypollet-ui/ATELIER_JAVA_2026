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
    <header>
        <div class="container">
            <div class="logo">Code <span>X</span></div>
            <a href="index.html" class="nav-link">← Retour</a>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <h1>Exercices sur les Chaînes</h1>
            <p>Manipulation et analyse de texte</p>
        </div>
    </section>

    <section>
        <div class="container">
            <h2>Entrez votre texte</h2>
            <form action="#" method="post">
                <label for="inputValeur">Texte (6 caractères minimum) :</label>
                <input type="text" id="inputValeur" name="chaine" placeholder="Entrez du texte...">
                <input type="submit" value="Analyser">
            </form>
        </section>
        <%-- Récupération des valeurs --%>
        <% String chaine = request.getParameter("chaine"); %>
        
        <% if (chaine != null) { %>
            <% int longueurChaine = chaine.length(); %>

            <section>
                <div class="container">
                    <h2>Résultats</h2>

                    <h3>Infos générales</h3>
                    <div class="result-box">
                        <p><strong>Texte :</strong> "<%= chaine %>"</p>
                        <p><strong>Longueur :</strong> <%= longueurChaine %> caractères</p>
                    </div>

                    <% char caractereExtrait = chaine.charAt(2); %>
                    <h3>3e caractère</h3>
                    <div class="result-box">
                        <p><strong><%= caractereExtrait %></strong></p>
                    </div>

                    <% String sousChaine = chaine.substring(2, 6); %>
                    <h3>Sous-chaîne (3-6)</h3>
                    <div class="result-box">
                        <p><strong><%= sousChaine %></strong></p>
                    </div>

                    <% char recherche = 'e'; int position = chaine.indexOf(recherche); %>
                    <h3>Recherche du 'e'</h3>
                    <div class="result-box">
                        <% if (position != -1) { %>
                            <p>Position : <strong><%= position %></strong></p>
                        <% } else { %>
                            <p>Aucun 'e' trouvé</p>
                        <% } %>
                    </div>

                    <h3>Analyse du texte</h3>
                    <% int compteurE = 0;
                    for(int i = 0; i < chaine.length(); i++) {
                        if(chaine.charAt(i) == 'e') {
                            compteurE++;
                        }
                    }
                    %>
                    <div class="result-box">
                        <p>Nombre de 'e' : <strong><%= compteurE %></strong></p>
                    </div>

                    <h3>Affichage vertical</h3>
                    <div class="generated-output"><%
                    for(int i = 0; i < chaine.length(); i++) {
                        out.print(chaine.charAt(i));
                        out.print("\n");
                    }
                    %></div>

                    <h3>Retour à la ligne sur espaces</h3>
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

                    <h3>Une lettre sur deux</h3>
                    <div class="generated-output"><%
                    for(int i = 0; i < chaine.length(); i = i + 2) {
                        out.print(chaine.charAt(i));
                    }
                    %></div>

                    <h3>Texte inversé</h3>
                    <div class="generated-output"><%
                    for(int i = chaine.length() - 1; i >= 0; i--) {
                        out.print(chaine.charAt(i));
                    }
                    %></div>

                    <h3>Voyelles et consonnes</h3>
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
                    <div class="result-box">
                        <p><strong>Voyelles :</strong> <%= voyelles %></p>
                        <p><strong>Consonnes :</strong> <%= consonnes %></p>
                    </div>
                </div>
            </section>

        <% } else { %>
            <section>
                <div class="container">
                    <h2>Instructions</h2>
                    <p>Entrez un texte avec au moins 6 caractères pour voir l'analyse.</p>
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
